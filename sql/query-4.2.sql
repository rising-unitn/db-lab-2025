BEGIN TRANSACTION;

CREATE TABLE People(
  person_id INT PRIMARY KEY,
  name VARCHAR(255),
  surname VARCHAR(255),
  date_of_birth DATE
);

CREATE TABLE Managers(
  manager_id INT PRIMARY KEY,
  FOREIGN KEY(manager_id) REFERENCES People(person_id)
);

CREATE TABLE Artists(
  artist_id INT PRIMARY KEY,
  stage_name VARCHAR(255),
  degree VARCHAR(255),   
  FOREIGN KEY(artist_id) REFERENCES People(person_id)
);

CREATE TYPE vocal_range_enum AS ENUM ('soprano', 'alto', 'tenor', 'bass');

CREATE TABLE Singers(
  singer_id INT PRIMARY KEY,
  manager_id INT NOT NULL,
  vocal_range vocal_range_enum,
  FOREIGN KEY(singer_id) REFERENCES Artists(artist_id),
  FOREIGN KEY(manager_id) REFERENCES Managers(manager_id) DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE Producers(
  producer_id INT PRIMARY KEY,
  manager_id INT NOT NULL, 
  equipment_brand VARCHAR(255), equipment_model VARCHAR(255), equipment_year INT, -- ...
  FOREIGN KEY(producer_id) REFERENCES Artists(artist_id),
  FOREIGN KEY(manager_id) REFERENCES Managers(manager_id) DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE Songs(
  song_id INT PRIMARY KEY,
  title VARCHAR(255)
);

CREATE TABLE Song_Singers(
  song_id INT,
  singer_id INT,
  FOREIGN KEY(song_id) REFERENCES Songs(song_id),
  FOREIGN KEY(singer_id) REFERENCES Singers(singer_id),
  PRIMARY KEY(song_id, singer_id)
);

CREATE TABLE Song_Producers(
  song_id INT,
  producer_id INT,
  FOREIGN KEY(song_id) REFERENCES Songs(song_id),
  FOREIGN KEY(producer_id) REFERENCES Producers(producer_id),
  PRIMARY KEY(song_id, producer_id)
);

CREATE TABLE Albums(
  album_id INT PRIMARY KEY,
  title VARCHAR(255)
);

ALTER TABLE Songs
ADD COLUMN album_id INT, -- can be NULL, a song may not be in an album 
ADD FOREIGN KEY(album_id) REFERENCES Albums(album_id);

CREATE TABLE Genres(
  genre_id INT PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE Subgenres(
  subgenre_id INT PRIMARY KEY,
  name VARCHAR(255),
  parent_genre INT,
  parent_subgenre INT,
  FOREIGN KEY(parent_genre) REFERENCES Genres(genre_id),
  FOREIGN KEY(parent_subgenre) REFERENCES Subgenres(subgenre_id),
  CHECK (
    (parent_genre IS NOT NULL AND parent_subgenre IS NULL) OR
    (parent_genre IS NULL AND parent_subgenre IS NOT NULL)
  )
);

CREATE TABLE Genres_Songs(
  song_id INT NOT NULL,
  genre_id INT,
  subgenre_id INT,
  FOREIGN KEY(song_id) REFERENCES Songs(song_id),
  FOREIGN KEY(genre_id) REFERENCES Genres(genre_id),
  FOREIGN KEY(subgenre_id) REFERENCES Subgenres(subgenre_id),
  PRIMARY KEY(song_id, genre_id, subgenre_id),
  CHECK (
    (genre_id IS NOT NULL AND subgenre_id IS NULL) OR
    (genre_id IS NULL AND subgenre_id IS NOT NULL)
  )
);

CREATE TABLE Financial_Advisors(
  advisor_id INT PRIMARY KEY,
  advisor_name VARCHAR(255)
);

ALTER TABLE Singers
ADD COLUMN advisor_id INT NOT NULL,
ADD FOREIGN KEY(advisor_id) REFERENCES Financial_Advisors(advisor_id) DEFERRABLE INITIALLY DEFERRED,
ADD CONSTRAINT SingerAdvisor UNIQUE(advisor_id);

COMMIT;
