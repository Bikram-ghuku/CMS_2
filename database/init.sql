CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE Complains
(
    comp_id       UUID NOT NULL DEFAULT uuid_generate_v4(),
    comp_nos      integer NOT NULL,
    comp_loc      text NOT NULL,
    comp_des      text NOT NULL,
    comp_stat     text NOT NULL,
    comp_date     timestamp(6) with time zone NOT NULL,
    fin_datetime  timestamp(6) with time zone NOT NULL,
    fin_info      text NOT NULL,
    CONSTRAINT PK_Complains PRIMARY KEY (comp_id, comp_nos)
);

CREATE TABLE public.inventory
(
    item_id     UUID NOT NULL DEFAULT uuid_generate_v4(),
    item_name   text NOT NULL,
    item_qty    numeric NOT NULL,
    item_price  numeric NOT NULL,
    CONSTRAINT PK_Inventory PRIMARY KEY (item_id)
);

CREATE TABLE inven_used
(
    id          UUID NOT NULL DEFAULT uuid_generate_v4(),
    item_id     UUID NOT NULL,
    comp_id     UUID NOT NULL,
    comp_nos    integer NOT NULL,
    item_used   integer NOT NULL,
    CONSTRAINT PK_Inven_Used PRIMARY KEY (id, item_id, comp_id, comp_nos),
    CONSTRAINT FK_Inven_Used_Item FOREIGN KEY (item_id) REFERENCES public.inventory(item_id),
    CONSTRAINT FK_Inven_Used_Complain FOREIGN KEY (comp_id, comp_nos) REFERENCES Complains(comp_id, comp_nos)
);

CREATE INDEX IDX_Inven_Used_Item ON inven_used(item_id);
CREATE INDEX IDX_Inven_Used_Complain ON inven_used(comp_id, comp_nos);
