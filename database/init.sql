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
    bill_id       uuid NULL,
    CONSTRAINT PK_inven_used PRIMARY KEY (id),
    CONSTRAINT FK_user FOREIGN KEY (user_id) REFERENCES users (user_id),
    CONSTRAINT FK_complaints FOREIGN KEY (comp_id) REFERENCES complaints (comp_id),
    CONSTRAINT FK_inventory FOREIGN KEY (item_id) REFERENCES inventory (item_id),
    CONSTRAINT FK_bills FOREIGN KEY (bill_id) REFERENCES bills (id)
);

CREATE TABLE bills
{
    id          uuid DEFAULT uuid_generate_v4() NOT NULL,
    dateTime    timestamp(6) with time zone NOT NULL,
    CONSTRAINT PK_bills PRIMARY KEY (id)
}

CREATE INDEX IDX_item_id ON inven_used (item_id);
CREATE INDEX IDX_comp_id ON inven_used (comp_id);
CREATE INDEX IDX_user_id ON inven_used (user_id);
