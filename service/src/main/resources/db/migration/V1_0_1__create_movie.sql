create table movie
(
    id       uuid not null
        constraint movie_pkey
            primary key,
    actors   text,
    director varchar(255),
    genre    varchar(255),
    plot     text,
    poster   text,
    runtime  varchar(255),
    title    varchar(255),
    year     varchar(255)
);


create table inventory
(
    id       uuid    not null,
    value    integer not null,
    movie_id uuid    not null
        constraint uk_9uosytjoxnrh3mtrhbt7tdbri
            unique
        constraint fkt3cpggl0cxpxodqv4ghgvsfq3
            references movie,
    constraint inventory_pkey
        primary key (id, movie_id)
);

create table movie_ratings
(
    movie_id uuid not null
        constraint fkky2b7201ypwxqp3p67int4gkc
            references movie,
    source   varchar(255),
    value    varchar(255)
);

INSERT INTO public.movie (id, actors, director, genre, plot, poster, runtime, title, year)
VALUES ('1e8ae68a-dc31-431d-8dd5-cae46192d0a4',
        'Tomasz Kot, Piotr Glowacki, Szymon Piotr Warszawski, Magdalena Czerwinska', 'Lukasz Palkowski',
        'Biography, Drama',
        'The early career of cardiac surgeon Zbigniew Religa. Despite harsh reality of the 1980s Poland, he successfully leads a team of doctors to the country''s first human heart transplantation.',
        'https://m.media-amazon.com/images/M/MV5BMmZhZjQ3ZjktN2M3Mi00OWI1LThhMGMtNTI5NTEwZjgxZjU5XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg',
        '120 min', 'Gods', '2014'),
       ('b26d647d-1579-4926-8005-85dc9f4b7f10', 'Tom Hanks, Tim Allen, Don Rickles, Jim Varney', 'John Lasseter',
        'Animation, Adventure, Comedy, Family, Fantasy',
        'A cowboy doll is profoundly threatened and jealous when a new spaceman figure supplants him as top toy in a boy''s room.',
        'https://m.media-amazon.com/images/M/MV5BMDU2ZWJlMjktMTRhMy00ZTA5LWEzNDgtYmNmZTEwZTViZWJkXkEyXkFqcGdeQXVyNDQ2OTk4MzI@._V1_SX300.jpg',
        '81 min', 'Toy Story', '1995'),
       ('79a4c6a9-0a60-43e9-80c8-cb7d40aa13f0', 'Lisa Adam, Frank Aldridge, Amitabh Bachchan, Steve Bisley',
        'Baz Luhrmann', 'Drama, Romance',
        'A writer and wall street trader, Nick, finds himself drawn to the past and lifestyle of his millionaire neighbor, Jay Gatsby.',
        'https://m.media-amazon.com/images/M/MV5BMTkxNTk1ODcxNl5BMl5BanBnXkFtZTcwMDI1OTMzOQ@@._V1_SX300.jpg', '143 min',
        'The Great Gatsby', '2013'),
       ('28892558-c8b6-416a-ae47-5c2246d84567', 'Ellen Burstyn, Matthew McConaughey, Mackenzie Foy, John Lithgow',
        'Christopher Nolan', 'Adventure, Drama, Sci-Fi',
        'A team of explorers travel through a wormhole in space in an attempt to ensure humanity''s survival.',
        'https://m.media-amazon.com/images/M/MV5BZjdkOTU3MDktN2IxOS00OGEyLWFmMjktY2FiMmZkNWIyODZiXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg',
        '169 min', 'Interstellar', '2014'),
       ('dd2bde75-5369-408f-b163-914a06f279ba', 'Dawid Ogrodnik, Piotr Glowacki, Tomasz Kot, Joanna Kulig',
        'Maciej Bochniak', 'Comedy, Music',
        'Fabulous story of two boys from province, who want to become top stars of Polish popular disco genre.',
        'https://m.media-amazon.com/images/M/MV5BMjMzNDQ0MjkxOV5BMl5BanBnXkFtZTgwMzczNzM2NDE@._V1_SX300.jpg', '107 min',
        'Disco Polo', '2015'),
       ('5fa121e4-636c-4d65-a579-4da53129f602', 'Leigh Whannell, Cary Elwes, Danny Glover, Ken Leung', 'James Wan',
        'Horror, Mystery, Thriller',
        'Two strangers, who awaken in a room with no recollection of how they got there, soon discover they''re pawns in a deadly game perpetrated by a notorious serial killer.',
        'https://m.media-amazon.com/images/M/MV5BMjE4MDYzNDE1OV5BMl5BanBnXkFtZTcwNDY2OTYwNA@@._V1_SX300.jpg', '103 min',
        'Saw', '2004'),
       ('7a43eeb1-85bf-4336-978a-af68b2679edb', 'Leonardo DiCaprio, Kate Winslet, Billy Zane, Kathy Bates',
        'James Cameron', 'Drama, Romance',
        'A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.',
        'https://m.media-amazon.com/images/M/MV5BMDdmZGU3NDQtY2E5My00ZTliLWIzOTUtMTY4ZGI1YjdiNjk3XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_SX300.jpg',
        '194 min', 'Titanic', '1997'),
       ('74317116-3bb6-484e-a949-1a3903c32924', 'James Caan, Kathy Bates, Richard Farnsworth, Frances Sternhagen',
        'Rob Reiner', 'Drama, Thriller',
        'After a famous author is rescued from a car crash by a fan of his novels, he comes to realize that the care he is receiving is only the beginning of a nightmare of captivity and abuse.',
        'https://m.media-amazon.com/images/M/MV5BNzY0ODQ3MTMxN15BMl5BanBnXkFtZTgwMDkwNTg4NjE@._V1_SX300.jpg', '107 min',
        'Misery', '1990'),
       ('43205969-c698-49db-9a67-cb935f2f76e9', 'Jack Nicholson, Shelley Duvall, Danny Lloyd, Scatman Crothers',
        'Stanley Kubrick', 'Drama, Horror',
        'A family heads to an isolated hotel for the winter where a sinister presence influences the father into violence, while his psychic son sees horrific forebodings from both past and future.',
        'https://m.media-amazon.com/images/M/MV5BZWFlYmY2MGEtZjVkYS00YzU4LTg0YjQtYzY1ZGE3NTA5NGQxXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg',
        '146 min', 'The Shining', '1980'),
       ('97aad7af-2e04-4cef-b77c-2719fa400e50', 'Tom Hanks, David Morse, Bonnie Hunt, Michael Clarke Duncan',
        'Frank Darabont', 'Crime, Drama, Fantasy, Mystery',
        'The lives of guards on Death Row are affected by one of their charges: a black man accused of child murder and rape, yet who has a mysterious gift.',
        'https://m.media-amazon.com/images/M/MV5BMTUxMzQyNjA5MF5BMl5BanBnXkFtZTYwOTU2NTY3._V1_SX300.jpg', '189 min',
        'The Green Mile', '1999'),
       ('6cea43b5-fc00-45c8-8250-a2dd89256716', 'Jennifer Aniston, Jason Sudeikis, Emma Roberts, Will Poulter',
        'Rawson Marshall Thurber', 'Comedy, Crime',
        'A veteran pot dealer creates a fake family as part of his plan to move a huge shipment of weed into the U.S. from Mexico.',
        'https://m.media-amazon.com/images/M/MV5BMjA5Njc0NDUxNV5BMl5BanBnXkFtZTcwMjYzNzU1OQ@@._V1_SX300.jpg', '110 min',
        'We''re the Millers', '2013'),
       ('b633873f-c714-427b-ae2f-4ba97e797549', 'Andrea Vicunia, Dustin Lemos', 'N/A', 'Comedy',
        '50 nights, 50 beds, 50 stories of relationships.',
        'https://m.media-amazon.com/images/M/MV5BZGM2NTM1ZmItMDU0Yi00YWQxLWE5NmItMTQ4MDFiNDgzZmU2XkEyXkFqcGdeQXVyMjQwMDg0Ng@@._V1_SX300.jpg',
        '2 min', '50 Shades of Girls', '2013–'),
       ('395f82c5-0f1f-4940-83f5-99f515dfcf1a', 'Dakota Johnson, Jamie Dornan, Jennifer Ehle, Eloise Mumford',
        'Sam Taylor-Johnson', 'Drama, Romance, Thriller',
        'Literature student Anastasia Steele''s life changes forever when she meets handsome, yet tormented, billionaire Christian Grey.',
        'https://m.media-amazon.com/images/M/MV5BMjE1MTM4NDAzOF5BMl5BanBnXkFtZTgwNTMwNjI0MzE@._V1_SX300.jpg', '125 min',
        'Fifty Shades of Grey', '2015'),
       ('277ad6d4-d398-40dc-ac4d-df7be3846f06', 'Ben Barnes, John Hollingworth, Cato Sandford, Pip Torrens',
        'Oliver Parker', 'Drama, Fantasy, Thriller',
        'A corrupt young man somehow keeps his youthful beauty eternally, but a special painting gradually reveals his inner ugliness to all.',
        'https://m.media-amazon.com/images/M/MV5BMTY5ODc1NjU5N15BMl5BanBnXkFtZTcwMTUyNDg3Mg@@._V1_SX300.jpg', '112 min',
        'Dorian Gray', '2009'),
       ('38d26f8e-10ce-4856-9ac4-c6da3c9542a4', 'Ralph Fiennes, Michael Gambon, Alan Rickman, Daniel Radcliffe',
        'David Yates', 'Adventure, Drama, Fantasy, Mystery',
        'Harry, Ron, and Hermione search for Voldemort''s remaining Horcruxes in their effort to destroy the Dark Lord as the final battle rages on at Hogwarts.',
        'https://m.media-amazon.com/images/M/MV5BMjIyZGU4YzUtNDkzYi00ZDRhLTljYzctYTMxMDQ4M2E0Y2YxXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_SX300.jpg',
        '130 min', 'Harry Potter and the Deathly Hallows: Part 2', '2011'),
       ('09dd6ff2-d131-4c91-9a86-f1565307afe7', 'Bill Nighy, Emma Watson, Richard Griffiths, Harry Melling',
        'David Yates', 'Adventure, Family, Fantasy, Mystery',
        'As Harry (Daniel Radcliffe), Ron (Rupert Grint), and Hermione (Emma Watson) race against time and evil to destroy the Horcruxes, they uncover the existence of the three most powerful objects in the wizarding world: the Deathly Hallows.',
        'https://m.media-amazon.com/images/M/MV5BMTQ2OTE1Mjk0N15BMl5BanBnXkFtZTcwODE3MDAwNA@@._V1_SX300.jpg', '146 min',
        'Harry Potter and the Deathly Hallows: Part 1', '2010'),
       ('f0dab6d2-4dc2-4ff4-90f4-845d138e4fbb', 'Ian McKellen, Martin Freeman, Richard Armitage, Ken Stott',
        'Peter Jackson', 'Adventure, Family, Fantasy',
        'A reluctant Hobbit, Bilbo Baggins, sets out to the Lonely Mountain with a spirited group of dwarves to reclaim their mountain home, and the gold within it from the dragon Smaug.',
        'https://m.media-amazon.com/images/M/MV5BMTcwNTE4MTUxMl5BMl5BanBnXkFtZTcwMDIyODM4OA@@._V1_SX300.jpg', '169 min',
        'The Hobbit: An Unexpected Journey', '2012'),
       ('f7f24518-5610-4b06-a008-13917d6b523f', 'Harrison Ford, Sean Connery, Denholm Elliott, Alison Doody',
        'Steven Spielberg', 'Action, Adventure',
        'In 1938, after his father Professor Henry Jones, Sr. goes missing while pursuing the Holy Grail, Professor Henry "Indiana" Jones, Jr. finds himself up against Adolf Hitler''s Nazis again to stop them from obtaining its powers.',
        'https://m.media-amazon.com/images/M/MV5BMjNkMzc2N2QtNjVlNS00ZTk5LTg0MTgtODY2MDAwNTMwZjBjXkEyXkFqcGdeQXVyNDk3NzU2MTQ@._V1_SX300.jpg',
        '127 min', 'Indiana Jones and the Last Crusade', '1989'),
       ('2af2bbd7-ff5b-45ba-90a0-25478d29ae92', 'Julian Bailey, Aimée Castle, Dean Hagopian, A.J. Henderson', 'N/A',
        'Animation, Adventure, Drama, Family',
        'A series following the adventures of a young boy and Boumbo, a talking yellow car who hatched from an egg, as they travel the world in search for Boumbo''s mother. A car salesman is after to catch Boumbo.',
        'https://m.media-amazon.com/images/M/MV5BMjEzOTcxNjM1MV5BMl5BanBnXkFtZTcwMDU5NzQ5MQ@@._V1_SX300.jpg', '10 min',
        'Hey! Bumbo', '1985–');



INSERT INTO public.movie_ratings (movie_id, source, value)
VALUES ('1e8ae68a-dc31-431d-8dd5-cae46192d0a4', 'Internet Movie Database', '7.7/10'),
       ('b26d647d-1579-4926-8005-85dc9f4b7f10', 'Internet Movie Database', '8.3/10'),
       ('b26d647d-1579-4926-8005-85dc9f4b7f10', 'Rotten Tomatoes', '100%'),
       ('b26d647d-1579-4926-8005-85dc9f4b7f10', 'Metacritic', '95/100'),
       ('79a4c6a9-0a60-43e9-80c8-cb7d40aa13f0', 'Internet Movie Database', '7.2/10'),
       ('79a4c6a9-0a60-43e9-80c8-cb7d40aa13f0', 'Rotten Tomatoes', '48%'),
       ('79a4c6a9-0a60-43e9-80c8-cb7d40aa13f0', 'Metacritic', '55/100'),
       ('28892558-c8b6-416a-ae47-5c2246d84567', 'Internet Movie Database', '8.6/10'),
       ('28892558-c8b6-416a-ae47-5c2246d84567', 'Rotten Tomatoes', '72%'),
       ('28892558-c8b6-416a-ae47-5c2246d84567', 'Metacritic', '74/100'),
       ('dd2bde75-5369-408f-b163-914a06f279ba', 'Internet Movie Database', '5.0/10'),
       ('5fa121e4-636c-4d65-a579-4da53129f602', 'Internet Movie Database', '7.6/10'),
       ('5fa121e4-636c-4d65-a579-4da53129f602', 'Rotten Tomatoes', '49%'),
       ('5fa121e4-636c-4d65-a579-4da53129f602', 'Metacritic', '46/100'),
       ('7a43eeb1-85bf-4336-978a-af68b2679edb', 'Internet Movie Database', '7.8/10'),
       ('7a43eeb1-85bf-4336-978a-af68b2679edb', 'Rotten Tomatoes', '89%'),
       ('7a43eeb1-85bf-4336-978a-af68b2679edb', 'Metacritic', '75/100'),
       ('74317116-3bb6-484e-a949-1a3903c32924', 'Internet Movie Database', '7.8/10'),
       ('74317116-3bb6-484e-a949-1a3903c32924', 'Rotten Tomatoes', '90%'),
       ('74317116-3bb6-484e-a949-1a3903c32924', 'Metacritic', '75/100'),
       ('43205969-c698-49db-9a67-cb935f2f76e9', 'Internet Movie Database', '8.4/10'),
       ('43205969-c698-49db-9a67-cb935f2f76e9', 'Rotten Tomatoes', '85%'),
       ('43205969-c698-49db-9a67-cb935f2f76e9', 'Metacritic', '66/100'),
       ('97aad7af-2e04-4cef-b77c-2719fa400e50', 'Internet Movie Database', '8.6/10'),
       ('97aad7af-2e04-4cef-b77c-2719fa400e50', 'Rotten Tomatoes', '78%'),
       ('97aad7af-2e04-4cef-b77c-2719fa400e50', 'Metacritic', '61/100'),
       ('6cea43b5-fc00-45c8-8250-a2dd89256716', 'Internet Movie Database', '7.0/10'),
       ('6cea43b5-fc00-45c8-8250-a2dd89256716', 'Rotten Tomatoes', '47%'),
       ('6cea43b5-fc00-45c8-8250-a2dd89256716', 'Metacritic', '44/100'),
       ('b633873f-c714-427b-ae2f-4ba97e797549', 'Internet Movie Database', '2.5/10'),
       ('395f82c5-0f1f-4940-83f5-99f515dfcf1a', 'Internet Movie Database', '4.1/10'),
       ('395f82c5-0f1f-4940-83f5-99f515dfcf1a', 'Rotten Tomatoes', '25%'),
       ('395f82c5-0f1f-4940-83f5-99f515dfcf1a', 'Metacritic', '46/100'),
       ('277ad6d4-d398-40dc-ac4d-df7be3846f06', 'Internet Movie Database', '6.3/10'),
       ('277ad6d4-d398-40dc-ac4d-df7be3846f06', 'Rotten Tomatoes', '44%'),
       ('38d26f8e-10ce-4856-9ac4-c6da3c9542a4', 'Internet Movie Database', '8.1/10'),
       ('38d26f8e-10ce-4856-9ac4-c6da3c9542a4', 'Rotten Tomatoes', '96%'),
       ('38d26f8e-10ce-4856-9ac4-c6da3c9542a4', 'Metacritic', '87/100'),
       ('09dd6ff2-d131-4c91-9a86-f1565307afe7', 'Internet Movie Database', '7.7/10'),
       ('09dd6ff2-d131-4c91-9a86-f1565307afe7', 'Rotten Tomatoes', '77%'),
       ('09dd6ff2-d131-4c91-9a86-f1565307afe7', 'Metacritic', '65/100'),
       ('f0dab6d2-4dc2-4ff4-90f4-845d138e4fbb', 'Internet Movie Database', '7.8/10'),
       ('f0dab6d2-4dc2-4ff4-90f4-845d138e4fbb', 'Rotten Tomatoes', '64%'),
       ('f0dab6d2-4dc2-4ff4-90f4-845d138e4fbb', 'Metacritic', '58/100'),
       ('f7f24518-5610-4b06-a008-13917d6b523f', 'Internet Movie Database', '8.2/10'),
       ('f7f24518-5610-4b06-a008-13917d6b523f', 'Rotten Tomatoes', '88%'),
       ('f7f24518-5610-4b06-a008-13917d6b523f', 'Metacritic', '65/100'),
       ('2af2bbd7-ff5b-45ba-90a0-25478d29ae92', 'Internet Movie Database', '6.2/10');

INSERT INTO public.inventory (id, value, movie_id)
VALUES ('851a7173-58ee-45cc-95e2-64e4c665a223', 0, '1e8ae68a-dc31-431d-8dd5-cae46192d0a4'),
       ('0e80a850-5ceb-4cc6-b69e-6ea6b813f495', 0, 'b26d647d-1579-4926-8005-85dc9f4b7f10'),
       ('ad047d7a-7081-4c2a-9682-49c6eda8bb82', 0, '79a4c6a9-0a60-43e9-80c8-cb7d40aa13f0'),
       ('cacedda4-3416-4058-ae16-5c544f4c4c2f', 0, '28892558-c8b6-416a-ae47-5c2246d84567'),
       ('f0eeb0db-a768-480d-9c4f-c25dcf3f2cd9', 0, 'dd2bde75-5369-408f-b163-914a06f279ba'),
       ('d22adc3a-0269-47d1-b567-f58fd1137d51', 0, '5fa121e4-636c-4d65-a579-4da53129f602'),
       ('17642a97-65a3-4b66-a603-ec3a17c19515', 0, '7a43eeb1-85bf-4336-978a-af68b2679edb'),
       ('876569cf-df2b-4e9c-ab18-102592763c7c', 0, '74317116-3bb6-484e-a949-1a3903c32924'),
       ('d37bc060-c026-4ea4-ad10-0aeddffd145c', 0, '43205969-c698-49db-9a67-cb935f2f76e9'),
       ('3286ad99-e517-40fb-9611-e0da8f240d2a', 0, '97aad7af-2e04-4cef-b77c-2719fa400e50'),
       ('1417512f-7597-4500-b5aa-618085921c92', 0, '6cea43b5-fc00-45c8-8250-a2dd89256716'),
       ('c42d7a7f-b4b9-4aaa-8480-0bbc5c347064', 0, 'b633873f-c714-427b-ae2f-4ba97e797549'),
       ('84b319ad-9b8a-4342-873d-00853512058c', 0, '395f82c5-0f1f-4940-83f5-99f515dfcf1a'),
       ('538435f3-a508-40f4-bdf1-8ad7d4545ab3', 0, '277ad6d4-d398-40dc-ac4d-df7be3846f06'),
       ('7dc5287f-c93a-4f59-91ed-b91e108e000e', 0, '38d26f8e-10ce-4856-9ac4-c6da3c9542a4'),
       ('5deac792-d323-4284-958d-4273c6e1d2ce', 0, '09dd6ff2-d131-4c91-9a86-f1565307afe7'),
       ('f5cdd1c3-efaf-433f-bd6c-db20db696643', 0, 'f0dab6d2-4dc2-4ff4-90f4-845d138e4fbb'),
       ('c2040a31-bb75-483c-83d5-0ecadee6940f', 0, 'f7f24518-5610-4b06-a008-13917d6b523f'),
       ('dcc177a5-6ded-4beb-8570-287d0e2f7f5e', 0, '2af2bbd7-ff5b-45ba-90a0-25478d29ae92');