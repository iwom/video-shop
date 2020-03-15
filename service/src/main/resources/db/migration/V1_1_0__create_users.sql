create table users
(
    id       uuid not null
        constraint users_pkey
            primary key,
    username    varchar(255) unique,
    email    varchar(255) unique,
    password varchar(255),
    role     varchar(255)
);

-- using BCrypt for password
insert into users (id, username, email, password, role)
values ('7791d5b2-a257-49c9-bb2b-384362fe83c7', 'admin', 'pieta.lukasz98@gmail.com',
        '$2a$10$ZOo/aqLvylvQwGyEsWu4dugpJTXnFaii9D2ui6helq/TsYjDwFJDe', 'ADMIN');