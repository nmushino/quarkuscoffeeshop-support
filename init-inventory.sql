DROP SCHEMA IF EXISTS inventory CASCADE;
CREATE SCHEMA inventory AUTHORIZATION robotshopuser;
create sequence inventory.hibernate_sequence start 1 increment 1;
create table inventory.Inventory (
                                     id int8 not null,
                                     backOrderQuantity int4 not null,
                                     inStockQuantity int4 not null,
                                     lastSaleDate date,
                                     lastStockDate date,
                                     maxRetailPrice float8,
                                     maximumQuantity int4 not null,
                                     minimumQuantity int4 not null,
                                     orderQuantity int4 not null,
                                     reservedQuantity int4 not null,
                                     unitCost float8,
                                     productMaster_sku_id uuid,
                                     primary key (id)
);
create table inventory.OutboxEvent (
                                       id uuid not null,
                                       aggregatetype varchar(255) not null,
                                       aggregateid varchar(255) not null,
                                       type varchar(255) not null,
                                       timestamp timestamp not null,
                                       payload varchar(8000),
                                       tracingspancontext varchar(256),
                                       primary key (id)
);
create table inventory.ProductMaster (
                                         sku_id uuid not null,
                                         item varchar(256),
                                         primary key (sku_id)
);
alter table if exists inventory.Inventory
    add constraint FK4gqdqmrew97itl6ola2uh50tu
    foreign key (productMaster_sku_id)
    references inventory.ProductMaster;
