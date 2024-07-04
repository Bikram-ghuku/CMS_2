CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE user
(
    user_id  uuid DEFAULT uuid_generate_v4() NOT NULL,
    username text NOT NULL,
    pswd     text NOT NULL,
    role     text NOT NULL,
    CONSTRAINT PK_user PRIMARY KEY (user_id)
);

CREATE TABLE inventory
(
    item_id    uuid DEFAULT uuid_generate_v4() NOT NULL,
    item_name  text NOT NULL,
    item_qty   numeric NOT NULL,
    item_price numeric NOT NULL,
    item_desc  text NOT NULL,
    CONSTRAINT PK_inventory PRIMARY KEY (item_id)
);

CREATE TABLE complains
(
    comp_id      uuid DEFAULT uuid_generate_v4() NOT NULL,
    comp_nos     text NOT NULL,
    comp_loc     text NOT NULL,
    comp_des     text NOT NULL,
    comp_stat    text NOT NULL,
    comp_date    timestamp(6) with time zone NOT NULL,
    fin_datetime timestamp(6) with time zone NOT NULL,
    fin_text     text NOT NULL,
    CONSTRAINT PK_complains PRIMARY KEY (comp_id, comp_nos)
);

CREATE TABLE inven_used
(
    id        uuid DEFAULT uuid_generate_v4() NOT NULL,
    user_id   uuid NOT NULL,
    comp_id_1 uuid NOT NULL,
    comp_nos  text NOT NULL,
    item_id_1 uuid NOT NULL,
    item_used numeric NOT NULL,
    CONSTRAINT PK_inven_used PRIMARY KEY (id, user_id, comp_id_1, comp_nos, item_id_1),
    CONSTRAINT FK_user FOREIGN KEY (user_id) REFERENCES user (user_id),
    CONSTRAINT FK_complains FOREIGN KEY (comp_id_1, comp_nos) REFERENCES complains (comp_id, comp_nos),
    CONSTRAINT FK_inventory FOREIGN KEY (item_id_1) REFERENCES inventory (item_id)
);

CREATE INDEX IDX_item_id_1 ON inven_used (item_id_1);
CREATE INDEX IDX_comp_id_nos ON inven_used (comp_id_1, comp_nos);
CREATE INDEX IDX_user_id ON inven_used (user_id);
