create table sales_order
(
    id         uuid not null
        constraint sales_order_pkey
            primary key,
    created_on timestamp,
    updated_on timestamp,
    user_id    uuid
        constraint fk6xxiw9y7x8ocx2uw6m2gwtckd
            references users
);

create table sales_order_line
(
    id             uuid    not null
        constraint sales_order_line_pkey
            primary key,
    price          numeric(8, 2),
    quantity       integer not null,
    movie_id       uuid
        constraint fk4vfb5c3i31psuu0itk6b9t477
            references movie,
    sales_order_id uuid
        constraint fk3hhrmxpwt1cqlnxmtiwpy9wpg
            references sales_order
);

create table historical_sales_order
(
    id         uuid not null
        constraint historical_sales_order_pkey
            primary key,
    created_on timestamp,
    user_id    uuid
        constraint fki1tldpvfpyt8gfg0vphsqm5h4
            references users
);

create table historical_sales_order_line
(
    id                        uuid    not null
        constraint historical_sales_order_line_pkey
            primary key,
    price                     numeric(8, 2),
    quantity                  integer not null,
    historical_sales_order_id uuid
        constraint fkq6i8dpbnnwhh2j9ioxsvgvux3
            references historical_sales_order,
    movie_id                  uuid
        constraint fkkwt9f01xff7chlf23tt3kva7q
            references movie
);
