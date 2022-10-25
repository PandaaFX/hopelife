create table rcore_tattoos
(
    identifier varchar(100) not null,
    tattoos    LONGTEXT null,
    constraint rcore_tattoos_pk
        primary key (identifier)
);

create unique index rcore_tattoos_identifier_uindex
    on rcore_tattoos (identifier);

