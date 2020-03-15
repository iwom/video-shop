create table users
(
    id       uuid not null
        constraint users_pkey
            primary key,
    email    varchar(255) unique,
    password varchar(255),
    role     varchar(255)
);

-- using BCrypt for password
insert into users (id, email, password, role)
values ('7791d5b2-a257-49c9-bb2b-384362fe83c7', 'admin@take.com',
        '$2a$10$ZOo/aqLvylvQwGyEsWu4dugpJTXnFaii9D2ui6helq/TsYjDwFJDe', 'ADMIN');