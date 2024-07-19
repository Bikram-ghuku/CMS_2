CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TYPE user_role AS ENUM ('admin', 'inven_manage', 'worker');
CREATE TYPE comp_status AS ENUM ('open', 'closed');

CREATE TABLE users
(
    user_id  uuid DEFAULT uuid_generate_v4() NOT NULL,
    username text NOT NULL UNIQUE,
    pswd     text NOT NULL,
    role     user_role DEFAULT 'worker' NOT NULL,
    CONSTRAINT PK_user PRIMARY KEY (user_id)
);

CREATE TABLE inventory
(
    item_id    uuid DEFAULT uuid_generate_v4() NOT NULL,
    item_name  text NOT NULL,
    item_qty   numeric NOT NULL,
    item_price numeric NOT NULL,
    item_desc  text NOT NULL,
    item_unit  text NOT NULL,
    CONSTRAINT PK_inventory PRIMARY KEY (item_id)
);

CREATE TABLE complaints
(
    comp_id      uuid DEFAULT uuid_generate_v4() NOT NULL,
    comp_nos     text NOT NULL,
    comp_loc     text NOT NULL,
    comp_des     text NOT NULL,
    comp_stat    comp_status NOT NULL,
    comp_date    timestamp(6) with time zone NOT NULL,
    fin_datetime timestamp(6) with time zone NULL,
    fin_text     text NULL,
    CONSTRAINT PK_complaints PRIMARY KEY (comp_id)
);

CREATE TABLE inven_used
(
    id            uuid DEFAULT uuid_generate_v4() NOT NULL,
    user_id       uuid NOT NULL,
    comp_id       uuid NOT NULL,
    item_id       uuid NOT NULL,
    item_used     numeric NOT NULL,
    item_l        numeric NULL,
    item_b        numeric NULL,
    item_h        numeric NULL,
    total_qty     numeric DEFAULT 0 NOT NULL,
    total_amount  numeric DEFAULT 0 NOT NULL,
    CONSTRAINT PK_inven_used PRIMARY KEY (id),
    CONSTRAINT FK_user FOREIGN KEY (user_id) REFERENCES users (user_id),
    CONSTRAINT FK_complaints FOREIGN KEY (comp_id) REFERENCES complaints (comp_id),
    CONSTRAINT FK_inventory FOREIGN KEY (item_id) REFERENCES inventory (item_id)
);

CREATE INDEX IDX_item_id ON inven_used (item_id);
CREATE INDEX IDX_comp_id ON inven_used (comp_id);
CREATE INDEX IDX_user_id ON inven_used (user_id);


CREATE OR REPLACE FUNCTION update_inven_used_totals()
RETURNS TRIGGER AS $$
DECLARE
    curr_comp_date timestamp(6) with time zone;
BEGIN
    SELECT comp_date INTO curr_comp_date FROM complaints WHERE comp_id = NEW.comp_id;

    NEW.total_qty := (SELECT COALESCE(SUM(iu.item_used), 0)
                      FROM inven_used iu
                      JOIN complaints c ON iu.comp_id = c.comp_id
                      WHERE iu.item_id = NEW.item_id AND c.comp_date < curr_comp_date);

    NEW.total_amount := (SELECT COALESCE(SUM(iu.item_used * inv.item_price), 0)
                         FROM inven_used iu
                         JOIN inventory inv ON iu.item_id = inv.item_id
                         JOIN complaints c ON iu.comp_id = c.comp_id
                         WHERE iu.item_id = NEW.item_id AND c.comp_date < curr_comp_date);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION adjust_totals_after_delete()
RETURNS TRIGGER AS $$
DECLARE
    curr_comp_date timestamp(6) with time zone;
BEGIN
    SELECT comp_date INTO curr_comp_date FROM complaints WHERE comp_id = OLD.comp_id;

    UPDATE inven_used
    SET total_qty = (SELECT COALESCE(SUM(item_used), 0)
                     FROM inven_used iu
                     JOIN complaints c ON iu.comp_id = c.comp_id
                     WHERE iu.item_id = OLD.item_id AND c.comp_date < curr_comp_date),
        total_amount = (SELECT COALESCE(SUM(item_used * inv.item_price), 0)
                        FROM inven_used iu
                        JOIN inventory inv ON iu.item_id = inv.item_id
                        JOIN complaints c ON iu.comp_id = c.comp_id
                        WHERE iu.item_id = OLD.item_id AND c.comp_date < curr_comp_date)
    WHERE item_id = OLD.item_id AND comp_id != OLD.comp_id;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_inven_used_totals_before_insert
BEFORE INSERT ON inven_used
FOR EACH ROW
EXECUTE FUNCTION update_inven_used_totals();

CREATE TRIGGER trg_update_inven_used_totals_before_update
AFTER UPDATE ON inven_used
FOR EACH ROW
WHEN (OLD.item_used IS DISTINCT FROM NEW.item_used)
EXECUTE FUNCTION update_inven_used_totals();

CREATE TRIGGER trg_adjust_totals_after_delete
AFTER DELETE ON inven_used
FOR EACH ROW
EXECUTE FUNCTION adjust_totals_after_delete();
