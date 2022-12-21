CREATE TABLE genres
(
  genre_id         INTEGER   NOT NULL,
  name_genre      CHAR(100) NOT NULL
);


/*Crerate anime table*/

CREATE TABLE anime
(
  anime_id        INTEGER   NOT NULL,
  anime_name       CHAR(150) NOT NULL,
  episodes       CHAR(150) NOT NULL,
  members       INTEGER,
  anime_type         CHAR(150)   NOT NULL,
  rating     INTEGER
);


/*Crerate genre_anime table*/

CREATE TABLE genre_anime
(
  anime_id         INTEGER        NOT NULL ,
  genre_id          INTEGER        NOT NULL 
);


/*Crerate user_rating table*/

CREATE TABLE user_rating
(
  user_rating_id  INTEGER        NOT NULL ,
  anime_id             INTEGER        NOT NULL ,
  user_id       INTEGER        NOT NULL ,
  user_rating          INTEGER        NOT NULL 
);

/*Crerate user_ table*/

CREATE TABLE user_
(
  user_id             INTEGER        NOT NULL ,
  user_nickname       CHAR(150)      NOT NULL  
);



/*Crerate all keys*/

ALTER TABLE genres ADD PRIMARY KEY (genre_id);
ALTER TABLE anime ADD PRIMARY KEY (anime_id);
ALTER TABLE user_ ADD PRIMARY KEY (user_id);


ALTER TABLE genre_anime ADD CONSTRAINT FK_anime_genre_genre FOREIGN KEY (genre_id) REFERENCES genres (genre_id);
ALTER TABLE genre_anime ADD CONSTRAINT FK_anime_genre_anime FOREIGN KEY (anime_id) REFERENCES anime (anime_id);

ALTER TABLE user_rating ADD CONSTRAINT FK_anime_user_anime FOREIGN KEY (anime_id) REFERENCES anime (anime_id);
ALTER TABLE user_rating ADD CONSTRAINT FK_anime_user_user FOREIGN KEY (user_id) REFERENCES user_ (user_id);
