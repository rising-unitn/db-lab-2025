BEGIN TRANSACTION;
INSERT INTO Financial_Advisors (advisor_id, advisor_name) VALUES
(1, 'Financial Advisor 1'),
(2, 'Financial Advisor 2');
INSERT INTO People (person_id, name, surname, date_of_birth) VALUES
(1, 'John', 'Doe', '1980-01-01'),
(2, 'Jane', 'Smith', '1985-02-02'),
(3, 'Alice', 'Johnson', '1990-03-03'),
(4, 'Bob', 'Brown', '1975-04-04'),
(5, 'Charlie', 'Whiting', '1970-05-05');

INSERT INTO Managers (manager_id) VALUES
(1),
(4);
INSERT INTO Artists (artist_id, stage_name, degree) VALUES
(2, 'JSmith', 'Bachelor of Music'),
(3, 'AJohnson', 'Master of Arts');
INSERT INTO Singers (singer_id, manager_id, vocal_range, advisor_id) VALUES
(2, 1, 'soprano', 1);
INSERT INTO Producers (producer_id, manager_id, equipment_brand, equipment_model, equipment_year) VALUES
(3, 4, 'Yamaha', 'MG10XU', 2019);

INSERT INTO Albums (album_id, title) VALUES
(1, 'Greatest Hits'),
(2, 'New Beginnings');
INSERT INTO Songs (song_id, title, album_id) VALUES
(1, 'Hit Song 1', 1),
(2, 'Hit Song 2', 1),
(3, 'New Song 1', 2),
(4, 'New Song 2', 2);
INSERT INTO Song_Singers (song_id, singer_id) VALUES
(1, 2),
(2, 2),
(3, 2);
INSERT INTO Song_Producers (song_id, producer_id) VALUES
(1, 3),
(2, 3),
(3, 3);

INSERT INTO Genres (genre_id, name) VALUES
(1, 'Rock'),
(2, 'Pop'),
(3, 'Ambient');
INSERT INTO Subgenres (subgenre_id, name, parent_genre, parent_subgenre) VALUES
(1, 'Alternative Rock', 1, NULL),
(2, 'Synth Pop', 2, NULL),
(3, 'Indie Rock', 1, NULL),
(4, 'Grunge', 1, NULL),
(5, 'Nu-Metal', NULL, 4);
INSERT INTO Genres_Songs (song_id, genre_id, subgenre_id) VALUES
(1, 1, NULL),
(1, NULL, 1),
(3, 1, NULL),
(3, NULL, 2);
END TRANSACTION;
