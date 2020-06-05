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
    year     varchar(255),
    price    numeric(4, 2)
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

INSERT INTO public.movie (id, actors, director, genre, plot, poster, runtime, title, year, price)
VALUES ('1e8ae68a-dc31-431d-8dd5-cae46192d0a4',
        'Tomasz Kot, Piotr Glowacki, Szymon Piotr Warszawski, Magdalena Czerwinska', 'Lukasz Palkowski',
        'Biography, Drama',
        'The early career of cardiac surgeon Zbigniew Religa. Despite harsh reality of the 1980s Poland, he successfully leads a team of doctors to the country''s first human heart transplantation.',
        'https://m.media-amazon.com/images/M/MV5BMmZhZjQ3ZjktN2M3Mi00OWI1LThhMGMtNTI5NTEwZjgxZjU5XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg',
        '120 min', 'Gods', '2014', '69.99'),
       ('b26d647d-1579-4926-8005-85dc9f4b7f10', 'Tom Hanks, Tim Allen, Don Rickles, Jim Varney', 'John Lasseter',
        'Animation, Adventure, Comedy, Family, Fantasy',
        'A cowboy doll is profoundly threatened and jealous when a new spaceman figure supplants him as top toy in a boy''s room.',
        'https://m.media-amazon.com/images/M/MV5BMDU2ZWJlMjktMTRhMy00ZTA5LWEzNDgtYmNmZTEwZTViZWJkXkEyXkFqcGdeQXVyNDQ2OTk4MzI@._V1_SX300.jpg',
        '81 min', 'Toy Story', '1995', '49.99'),
       ('79a4c6a9-0a60-43e9-80c8-cb7d40aa13f0', 'Lisa Adam, Frank Aldridge, Amitabh Bachchan, Steve Bisley',
        'Baz Luhrmann', 'Drama, Romance',
        'A writer and wall street trader, Nick, finds himself drawn to the past and lifestyle of his millionaire neighbor, Jay Gatsby.',
        'https://m.media-amazon.com/images/M/MV5BMTkxNTk1ODcxNl5BMl5BanBnXkFtZTcwMDI1OTMzOQ@@._V1_SX300.jpg', '143 min',
        'The Great Gatsby', '2013', '34.99'),
       ('28892558-c8b6-416a-ae47-5c2246d84567', 'Ellen Burstyn, Matthew McConaughey, Mackenzie Foy, John Lithgow',
        'Christopher Nolan', 'Adventure, Drama, Sci-Fi',
        'A team of explorers travel through a wormhole in space in an attempt to ensure humanity''s survival.',
        'https://m.media-amazon.com/images/M/MV5BZjdkOTU3MDktN2IxOS00OGEyLWFmMjktY2FiMmZkNWIyODZiXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg',
        '169 min', 'Interstellar', '2014', '14.99'),
       ('dd2bde75-5369-408f-b163-914a06f279ba', 'Dawid Ogrodnik, Piotr Glowacki, Tomasz Kot, Joanna Kulig',
        'Maciej Bochniak', 'Comedy, Music',
        'Fabulous story of two boys from province, who want to become top stars of Polish popular disco genre.',
        'https://m.media-amazon.com/images/M/MV5BMjMzNDQ0MjkxOV5BMl5BanBnXkFtZTgwMzczNzM2NDE@._V1_SX300.jpg', '107 min',
        'Disco Polo', '2015', '39.99'),
       ('5fa121e4-636c-4d65-a579-4da53129f602', 'Leigh Whannell, Cary Elwes, Danny Glover, Ken Leung', 'James Wan',
        'Horror, Mystery, Thriller',
        'Two strangers, who awaken in a room with no recollection of how they got there, soon discover they''re pawns in a deadly game perpetrated by a notorious serial killer.',
        'https://m.media-amazon.com/images/M/MV5BMjE4MDYzNDE1OV5BMl5BanBnXkFtZTcwNDY2OTYwNA@@._V1_SX300.jpg', '103 min',
        'Saw', '2004', '39.99'),
       ('7a43eeb1-85bf-4336-978a-af68b2679edb', 'Leonardo DiCaprio, Kate Winslet, Billy Zane, Kathy Bates',
        'James Cameron', 'Drama, Romance',
        'A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.',
        'https://m.media-amazon.com/images/M/MV5BMDdmZGU3NDQtY2E5My00ZTliLWIzOTUtMTY4ZGI1YjdiNjk3XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_SX300.jpg',
        '194 min', 'Titanic', '1997', '29.99'),
       ('74317116-3bb6-484e-a949-1a3903c32924', 'James Caan, Kathy Bates, Richard Farnsworth, Frances Sternhagen',
        'Rob Reiner', 'Drama, Thriller',
        'After a famous author is rescued from a car crash by a fan of his novels, he comes to realize that the care he is receiving is only the beginning of a nightmare of captivity and abuse.',
        'https://m.media-amazon.com/images/M/MV5BNzY0ODQ3MTMxN15BMl5BanBnXkFtZTgwMDkwNTg4NjE@._V1_SX300.jpg', '107 min',
        'Misery', '1990', '29.99'),
       ('43205969-c698-49db-9a67-cb935f2f76e9', 'Jack Nicholson, Shelley Duvall, Danny Lloyd, Scatman Crothers',
        'Stanley Kubrick', 'Drama, Horror',
        'A family heads to an isolated hotel for the winter where a sinister presence influences the father into violence, while his psychic son sees horrific forebodings from both past and future.',
        'https://m.media-amazon.com/images/M/MV5BZWFlYmY2MGEtZjVkYS00YzU4LTg0YjQtYzY1ZGE3NTA5NGQxXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg',
        '146 min', 'The Shining', '1980', '19.99'),
       ('97aad7af-2e04-4cef-b77c-2719fa400e50', 'Tom Hanks, David Morse, Bonnie Hunt, Michael Clarke Duncan',
        'Frank Darabont', 'Crime, Drama, Fantasy, Mystery',
        'The lives of guards on Death Row are affected by one of their charges: a black man accused of child murder and rape, yet who has a mysterious gift.',
        'https://m.media-amazon.com/images/M/MV5BMTUxMzQyNjA5MF5BMl5BanBnXkFtZTYwOTU2NTY3._V1_SX300.jpg', '189 min',
        'The Green Mile', '1999', '39.99'),
       ('6cea43b5-fc00-45c8-8250-a2dd89256716', 'Jennifer Aniston, Jason Sudeikis, Emma Roberts, Will Poulter',
        'Rawson Marshall Thurber', 'Comedy, Crime',
        'A veteran pot dealer creates a fake family as part of his plan to move a huge shipment of weed into the U.S. from Mexico.',
        'https://m.media-amazon.com/images/M/MV5BMjA5Njc0NDUxNV5BMl5BanBnXkFtZTcwMjYzNzU1OQ@@._V1_SX300.jpg', '110 min',
        'We''re the Millers', '2013', '39.99'),
       ('395f82c5-0f1f-4940-83f5-99f515dfcf1a', 'Dakota Johnson, Jamie Dornan, Jennifer Ehle, Eloise Mumford',
        'Sam Taylor-Johnson', 'Drama, Romance, Thriller',
        'Literature student Anastasia Steele''s life changes forever when she meets handsome, yet tormented, billionaire Christian Grey.',
        'https://m.media-amazon.com/images/M/MV5BMjE1MTM4NDAzOF5BMl5BanBnXkFtZTgwNTMwNjI0MzE@._V1_SX300.jpg', '125 min',
        'Fifty Shades of Grey', '2015', '44.99'),
       ('277ad6d4-d398-40dc-ac4d-df7be3846f06', 'Ben Barnes, John Hollingworth, Cato Sandford, Pip Torrens',
        'Oliver Parker', 'Drama, Fantasy, Thriller',
        'A corrupt young man somehow keeps his youthful beauty eternally, but a special painting gradually reveals his inner ugliness to all.',
        'https://m.media-amazon.com/images/M/MV5BMTY5ODc1NjU5N15BMl5BanBnXkFtZTcwMTUyNDg3Mg@@._V1_SX300.jpg', '112 min',
        'Dorian Gray', '2009', '59.99'),
       ('38d26f8e-10ce-4856-9ac4-c6da3c9542a4', 'Ralph Fiennes, Michael Gambon, Alan Rickman, Daniel Radcliffe',
        'David Yates', 'Adventure, Drama, Fantasy, Mystery',
        'Harry, Ron, and Hermione search for Voldemort''s remaining Horcruxes in their effort to destroy the Dark Lord as the final battle rages on at Hogwarts.',
        'https://m.media-amazon.com/images/M/MV5BMjIyZGU4YzUtNDkzYi00ZDRhLTljYzctYTMxMDQ4M2E0Y2YxXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_SX300.jpg',
        '130 min', 'Harry Potter and the Deathly Hallows: Part 2', '2011', '24.99'),
       ('09dd6ff2-d131-4c91-9a86-f1565307afe7', 'Bill Nighy, Emma Watson, Richard Griffiths, Harry Melling',
        'David Yates', 'Adventure, Family, Fantasy, Mystery',
        'As Harry (Daniel Radcliffe), Ron (Rupert Grint), and Hermione (Emma Watson) race against time and evil to destroy the Horcruxes, they uncover the existence of the three most powerful objects in the wizarding world: the Deathly Hallows.',
        'https://m.media-amazon.com/images/M/MV5BMTQ2OTE1Mjk0N15BMl5BanBnXkFtZTcwODE3MDAwNA@@._V1_SX300.jpg', '146 min',
        'Harry Potter and the Deathly Hallows: Part 1', '2010', '39.99'),
       ('f0dab6d2-4dc2-4ff4-90f4-845d138e4fbb', 'Ian McKellen, Martin Freeman, Richard Armitage, Ken Stott',
        'Peter Jackson', 'Adventure, Family, Fantasy',
        'A reluctant Hobbit, Bilbo Baggins, sets out to the Lonely Mountain with a spirited group of dwarves to reclaim their mountain home, and the gold within it from the dragon Smaug.',
        'https://m.media-amazon.com/images/M/MV5BMTcwNTE4MTUxMl5BMl5BanBnXkFtZTcwMDIyODM4OA@@._V1_SX300.jpg', '169 min',
        'The Hobbit: An Unexpected Journey', '2012', '44.99'),
       ('f7f24518-5610-4b06-a008-13917d6b523f', 'Harrison Ford, Sean Connery, Denholm Elliott, Alison Doody',
        'Steven Spielberg', 'Action, Adventure',
        'In 1938, after his father Professor Henry Jones, Sr. goes missing while pursuing the Holy Grail, Professor Henry "Indiana" Jones, Jr. finds himself up against Adolf Hitler''s Nazis again to stop them from obtaining its powers.',
        'https://m.media-amazon.com/images/M/MV5BMjNkMzc2N2QtNjVlNS00ZTk5LTg0MTgtODY2MDAwNTMwZjBjXkEyXkFqcGdeQXVyNDk3NzU2MTQ@._V1_SX300.jpg',
        '127 min', 'Indiana Jones and the Last Crusade', '1989', '39.99'),
       ('3c3458b6-adb4-4d4b-b3f0-6074b59ddc6f', 'Tim Robbins, Morgan Freeman, Bob Gunton, William Sadler',
        'Frank Darabont', 'Drama',
        'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',
        'https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg',
        '142 min', 'The Shawshank Redemption', '1994', 25.99),
       ('db350835-c184-4e31-8904-ffe1ec85f383', 'Tom Hanks, Rebecca Williams, Sally Field, Michael Conner Humphreys',
        'Robert Zemeckis', 'Drama, Romance',
        'The presidencies of Kennedy and Johnson, the events of Vietnam, Watergate and other historical events unfold through the perspective of an Alabama man with an IQ of 75, whose only desire is to be reunited with his childhood sweetheart.',
        'https://m.media-amazon.com/images/M/MV5BNWIwODRlZTUtY2U3ZS00Yzg1LWJhNzYtMmZiYmEyNmU1NjMzXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg',
        '142 min', 'Forrest Gump', '1994', 24.99),
       ('79cf99cb-04ab-4433-8fcd-287231c1033a', 'Martin Balsam, John Fiedler, Lee J. Cobb, E.G. Marshall',
        'Sidney Lumet', 'Crime, Drama',
        'A jury holdout attempts to prevent a miscarriage of justice by forcing his colleagues to reconsider the evidence.',
        'https://m.media-amazon.com/images/M/MV5BMWU4N2FjNzYtNTVkNC00NzQ0LTg0MjAtYTJlMjFhNGUxZDFmXkEyXkFqcGdeQXVyNjc1NTYyMjg@._V1_SX300.jpg',
        '96 min', '12 Angry Men', '1957', 34.99),
       ('dd59095a-0ae7-414e-a5b5-8097073ef1f3', 'Marlon Brando, Al Pacino, James Caan, Richard S. Castellano',
        'Francis Ford Coppola', 'Crime, Drama',
        'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',
        'https://m.media-amazon.com/images/M/MV5BM2MyNjYxNmUtYTAwNi00MTYxLWJmNWYtYzZlODY3ZTk3OTFlXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg',
        '175 min', 'The Godfather', '1972', 29.99),
       ('43cddc7e-579b-4089-9ec0-fd07bb512623', 'Al Pacino, Robert Duvall, Diane Keaton, Robert De Niro',
        'Francis Ford Coppola', 'Crime, Drama',
        'The early life and career of Vito Corleone in 1920s New York City is portrayed, while his son, Michael, expands and tightens his grip on the family crime syndicate.',
        'https://m.media-amazon.com/images/M/MV5BMWMwMGQzZTItY2JlNC00OWZiLWIyMDctNDk2ZDQ2YjRjMWQ0XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg',
        '202 min', 'The Godfather: Part II', '1974', 32.99),
       ('49408bd2-447e-40b0-a831-f838f62fee3a', 'Tim Roth, Amanda Plummer, Laura Lovelace, John Travolta',
        'Quentin Tarantino', 'Crime, Drama',
        'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.',
        'https://m.media-amazon.com/images/M/MV5BNGNhMDIzZTUtNTBlZi00MTRlLWFjM2ItYzViMjE3YzI5MjljXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg',
        '154 min', 'Pulp Fiction', '1994', 26.99),
       ('62e46e55-26f2-4226-84ba-97e082d546c7', 'Edward Norton, Brad Pitt, Meat Loaf, Zach Grenier', 'David Fincher',
        'Drama',
        'An insomniac office worker and a devil-may-care soapmaker form an underground fight club that evolves into something much, much more.',
        'https://m.media-amazon.com/images/M/MV5BMmEzNTkxYjQtZTc0MC00YTVjLTg5ZTEtZWMwOWVlYzY0NWIwXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg',
        '139 min', 'Fight Club', '1999', 34.99),
       ('a27ac608-16cf-4320-9545-0883acc72ddc', 'Leonardo DiCaprio, Joseph Gordon-Levitt, Ellen Page, Tom Hardy',
        'Christopher Nolan', 'Action, Adventure, Sci-Fi, Thriller',
        'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.',
        'https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SX300.jpg', '148 min',
        'Inception', '2010', 24.99),
       ('e9907d73-b559-4491-be58-87281e2b5372', 'Jodie Foster, Lawrence A. Bonney, Kasi Lemmons, Lawrence T. Wrentz',
        'Jonathan Demme', 'Crime, Drama, Thriller',
        'A young F.B.I. cadet must receive the help of an incarcerated and manipulative cannibal killer to help catch another serial killer, a madman who skins his victims.',
        'https://m.media-amazon.com/images/M/MV5BNjNhZTk0ZmEtNjJhMi00YzFlLWE1MmEtYzM1M2ZmMGMwMTU4XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg',
        '118 min', 'The Silence of the Lambs', '1991', 19.99),
       ('a05e1ad8-c664-4829-9edd-dd7aca5e0ec6', 'James Robinson, Sean Lawlor, Sandy Nelson, James Cosmo', 'Mel Gibson',
        'Biography, Drama, History, War',
        'When his secret bride is executed for assaulting an English soldier who tried to rape her, William Wallace begins a revolt against King Edward I of England.',
        'https://m.media-amazon.com/images/M/MV5BMzkzMmU0YTYtOWM3My00YzBmLWI0YzctOGYyNTkwMWE5MTJkXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg',
        '178 min', 'Braveheart', '1995', 34.99),
       ('87e53a39-a77f-47ed-8eb0-3520e338f5db', 'Miles Teller, J.K. Simmons, Paul Reiser, Melissa Benoist',
        'Damien Chazelle', 'Drama, Music',
        'A promising young drummer enrolls at a cut-throat music conservatory where his dreams of greatness are mentored by an instructor who will stop at nothing to realize a student''s potential.',
        'https://m.media-amazon.com/images/M/MV5BOTA5NDZlZGUtMjAxOS00YTRkLTkwYmMtYWQ0NWEwZDZiNjEzXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg',
        '106 min', 'Whiplash', '2014', 23.99),
       ('21b51de7-171b-4ad8-a692-2ac4b0a99a20', 'Leonardo DiCaprio, Matt Damon, Jack Nicholson, Mark Wahlberg',
        'Martin Scorsese', 'Crime, Drama, Thriller',
        'An undercover cop and a mole in the police attempt to identify each other while infiltrating an Irish gang in South Boston.',
        'https://m.media-amazon.com/images/M/MV5BMTI1MTY2OTIxNV5BMl5BanBnXkFtZTYwNjQ4NjY3._V1_SX300.jpg', '151 min',
        'The Departed', '2006', 25.99);


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
       ('79cf99cb-04ab-4433-8fcd-287231c1033a', 'Rotten Tomatoes', '100%'),
       ('79cf99cb-04ab-4433-8fcd-287231c1033a', 'Metacritic', '96/100'),
       ('79cf99cb-04ab-4433-8fcd-287231c1033a', 'Internet Movie Database', '8.9/10'),
       ('dd59095a-0ae7-414e-a5b5-8097073ef1f3', 'Metacritic', '100/100'),
       ('dd59095a-0ae7-414e-a5b5-8097073ef1f3', 'Internet Movie Database', '9.2/10'),
       ('dd59095a-0ae7-414e-a5b5-8097073ef1f3', 'Rotten Tomatoes', '98%'),
       ('43cddc7e-579b-4089-9ec0-fd07bb512623', 'Metacritic', '90/100'),
       ('43cddc7e-579b-4089-9ec0-fd07bb512623', 'Internet Movie Database', '9.0/10'),
       ('43cddc7e-579b-4089-9ec0-fd07bb512623', 'Rotten Tomatoes', '97%'),
       ('49408bd2-447e-40b0-a831-f838f62fee3a', 'Rotten Tomatoes', '91%'),
       ('49408bd2-447e-40b0-a831-f838f62fee3a', 'Metacritic', '94/100'),
       ('49408bd2-447e-40b0-a831-f838f62fee3a', 'Internet Movie Database', '8.9/10'),
       ('62e46e55-26f2-4226-84ba-97e082d546c7', 'Metacritic', '66/100'),
       ('62e46e55-26f2-4226-84ba-97e082d546c7', 'Rotten Tomatoes', '78%'),
       ('62e46e55-26f2-4226-84ba-97e082d546c7', 'Internet Movie Database', '8.8/10'),
       ('a27ac608-16cf-4320-9545-0883acc72ddc', 'Metacritic', '74/100'),
       ('a27ac608-16cf-4320-9545-0883acc72ddc', 'Rotten Tomatoes', '87%'),
       ('a27ac608-16cf-4320-9545-0883acc72ddc', 'Internet Movie Database', '8.8/10'),
       ('e9907d73-b559-4491-be58-87281e2b5372', 'Metacritic', '85/100'),
       ('e9907d73-b559-4491-be58-87281e2b5372', 'Internet Movie Database', '8.6/10'),
       ('e9907d73-b559-4491-be58-87281e2b5372', 'Rotten Tomatoes', '96%'),
       ('a05e1ad8-c664-4829-9edd-dd7aca5e0ec6', 'Internet Movie Database', '8.3/10'),
       ('a05e1ad8-c664-4829-9edd-dd7aca5e0ec6', 'Rotten Tomatoes', '77%'),
       ('a05e1ad8-c664-4829-9edd-dd7aca5e0ec6', 'Metacritic', '68/100'),
       ('87e53a39-a77f-47ed-8eb0-3520e338f5db', 'Rotten Tomatoes', '93%'),
       ('87e53a39-a77f-47ed-8eb0-3520e338f5db', 'Metacritic', '88/100'),
       ('87e53a39-a77f-47ed-8eb0-3520e338f5db', 'Internet Movie Database', '8.5/10'),
       ('21b51de7-171b-4ad8-a692-2ac4b0a99a20', 'Metacritic', '85/100'),
       ('21b51de7-171b-4ad8-a692-2ac4b0a99a20', 'Rotten Tomatoes', '91%'),
       ('21b51de7-171b-4ad8-a692-2ac4b0a99a20', 'Internet Movie Database', '8.5/10'),
       ('3c3458b6-adb4-4d4b-b3f0-6074b59ddc6f', 'Metacritic', '80/100'),
       ('3c3458b6-adb4-4d4b-b3f0-6074b59ddc6f', 'Rotten Tomatoes', '90%'),
       ('3c3458b6-adb4-4d4b-b3f0-6074b59ddc6f', 'Internet Movie Database', '9.3/10'),
       ('db350835-c184-4e31-8904-ffe1ec85f383', 'Rotten Tomatoes', '70%'),
       ('db350835-c184-4e31-8904-ffe1ec85f383', 'Metacritic', '82/100'),
       ('db350835-c184-4e31-8904-ffe1ec85f383', 'Internet Movie Database', '8.8/10');

INSERT INTO public.inventory (id, value, movie_id)
VALUES ('851a7173-58ee-45cc-95e2-64e4c665a223', 10, '1e8ae68a-dc31-431d-8dd5-cae46192d0a4'),
       ('0e80a850-5ceb-4cc6-b69e-6ea6b813f495', 10, 'b26d647d-1579-4926-8005-85dc9f4b7f10'),
       ('ad047d7a-7081-4c2a-9682-49c6eda8bb82', 10, '79a4c6a9-0a60-43e9-80c8-cb7d40aa13f0'),
       ('cacedda4-3416-4058-ae16-5c544f4c4c2f', 10, '28892558-c8b6-416a-ae47-5c2246d84567'),
       ('f0eeb0db-a768-480d-9c4f-c25dcf3f2cd9', 10, 'dd2bde75-5369-408f-b163-914a06f279ba'),
       ('d22adc3a-0269-47d1-b567-f58fd1137d51', 10, '5fa121e4-636c-4d65-a579-4da53129f602'),
       ('17642a97-65a3-4b66-a603-ec3a17c19515', 10, '7a43eeb1-85bf-4336-978a-af68b2679edb'),
       ('876569cf-df2b-4e9c-ab18-102592763c7c', 10, '74317116-3bb6-484e-a949-1a3903c32924'),
       ('d37bc060-c026-4ea4-ad10-0aeddffd145c', 10, '43205969-c698-49db-9a67-cb935f2f76e9'),
       ('3286ad99-e517-40fb-9611-e0da8f240d2a', 10, '97aad7af-2e04-4cef-b77c-2719fa400e50'),
       ('1417512f-7597-4500-b5aa-618085921c92', 10, '6cea43b5-fc00-45c8-8250-a2dd89256716'),
       ('84b319ad-9b8a-4342-873d-00853512058c', 10, '395f82c5-0f1f-4940-83f5-99f515dfcf1a'),
       ('538435f3-a508-40f4-bdf1-8ad7d4545ab3', 10, '277ad6d4-d398-40dc-ac4d-df7be3846f06'),
       ('7dc5287f-c93a-4f59-91ed-b91e108e000e', 10, '38d26f8e-10ce-4856-9ac4-c6da3c9542a4'),
       ('5deac792-d323-4284-958d-4273c6e1d2ce', 10, '09dd6ff2-d131-4c91-9a86-f1565307afe7'),
       ('f5cdd1c3-efaf-433f-bd6c-db20db696643', 10, 'f0dab6d2-4dc2-4ff4-90f4-845d138e4fbb'),
       ('c2040a31-bb75-483c-83d5-0ecadee6940f', 10, 'f7f24518-5610-4b06-a008-13917d6b523f'),
       ('59669438-77bb-4ae6-bc90-d678003dc912', 10, '3c3458b6-adb4-4d4b-b3f0-6074b59ddc6f'),
       ('8e6eead6-ef46-476f-9a80-c8d276c8b0f4', 10, 'db350835-c184-4e31-8904-ffe1ec85f383'),
       ('cb5200a4-20cb-4239-8a36-ca4c56ce1e71', 10, '79cf99cb-04ab-4433-8fcd-287231c1033a'),
       ('3124b97e-eb52-4fb6-8405-c19b03688297', 10, 'dd59095a-0ae7-414e-a5b5-8097073ef1f3'),
       ('be6f913b-cad8-404a-a1f7-55d19fdc6723', 10, '43cddc7e-579b-4089-9ec0-fd07bb512623'),
       ('68ed8b84-925d-452a-8b12-c3e8d845652a', 10, '49408bd2-447e-40b0-a831-f838f62fee3a'),
       ('204a58c5-5c4d-4646-8f55-097a0c71fd84', 10, '62e46e55-26f2-4226-84ba-97e082d546c7'),
       ('aea31a1c-4afa-47f3-a915-fa166a240c5e', 10, 'a27ac608-16cf-4320-9545-0883acc72ddc'),
       ('febcde5e-46b8-4b7c-8bc4-3144b4930970', 10, 'e9907d73-b559-4491-be58-87281e2b5372'),
       ('48e53155-d2d5-42b4-85c8-f0020af54c35', 10, 'a05e1ad8-c664-4829-9edd-dd7aca5e0ec6'),
       ('75081657-0913-4755-88d5-ff4bfb0e74d4', 10, '87e53a39-a77f-47ed-8eb0-3520e338f5db'),
       ('e17d0818-13a9-4558-83b0-389b04bc1b8c', 10, '21b51de7-171b-4ad8-a692-2ac4b0a99a20');