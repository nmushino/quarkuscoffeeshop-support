DROP SCHEMA IF EXISTS inventory CASCADE;
CREATE SCHEMA inventory AUTHORIZATION coffeeshopuser;
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
                               item int4,
                               primary key (sku_id)
);
alter table if exists inventory.Inventory
    add constraint FK4gqdqmrew97itl6ola2uh50tu
    foreign key (productMaster_sku_id)
    references inventory.ProductMaster;
DROP SCHEMA IF EXISTS coffeeshop CASCADE;
CREATE SCHEMA coffeeshop AUTHORIZATION coffeeshopuser;
alter table if exists coffeeshop.LineItems
    drop constraint if exists FK6fhxopytha3nnbpbfmpiv4xgn;
drop table if exists coffeeshop.LineItems cascade;
drop table if exists coffeeshop.Orders cascade;
drop table if exists coffeeshop.OutboxEvent cascade;
create table coffeeshop.LineItems (
                           itemId varchar(255) not null,
                           item varchar(255),
                           lineItemStatus varchar(255),
                           name varchar(255),
                           price numeric(19, 2),
                           order_id varchar(255) not null,
                           primary key (itemId)
);
create table coffeeshop.Orders (
                        order_id varchar(255) not null,
                        loyaltyMemberId varchar(255),
                        location     varchar(255),
                        orderSource varchar(255),
                        orderStatus varchar(255),
                        timestamp timestamp,
                        primary key (order_id)
);
create table coffeeshop.OutboxEvent (
                             id uuid not null,
                             aggregatetype varchar(255) not null,
                             aggregateid varchar(255) not null,
                             type varchar(255) not null,
                             timestamp timestamp not null,
                             payload varchar(8000),
                             tracingspancontext varchar(256),
                             primary key (id)
);
alter table if exists coffeeshop.LineItems
    add constraint FK6fhxopytha3nnbpbfmpiv4xgn
        foreign key (order_id)
            references coffeeshop.Orders;