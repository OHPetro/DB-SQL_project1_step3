----FUNCTIONS

--функція показує середній рейтинг по типу аніме та з відповідним діпазоном мемберв

drop function if exists get_avg_epintype;

CREATE OR REPLACE FUNCTION get_avg_epintype_diapason(anime_type_ varchar,members_min int,members_max int) RETURNS Float AS $$
	select ROUND(avg(rating),3) from anime
    where  anime_type = anime_type_ and members > members_min and members < members_max
$$ LANGUAGE SQL;

--test
--select * from get_avg_epintype_diapason('TV',10000,30000)
--select * from get_avg_epintype_diapason('TV',40000,70000)


-функція показує топ жанрів для юзера

drop function if exists top_genre_of_user;

CREATE OR REPLACE FUNCTION top_genre_of_user(user_id_ int,limit_ int) RETURNS table(counts_ int,fav_geres varchar) AS $$
	select count(*) as counts,name_genre from genres 
	join genre_anime on genres.genre_id = genre_anime.genre_id
	join anime on anime.anime_id = genre_anime.anime_id
	join user_rating on user_rating.anime_id = anime.anime_id
	where user_id = user_id_
	group by name_genre
	order by counts DESC
	limit limit_
$$ LANGUAGE SQL;
--test
---select * from top_genre_of_user(3,3)

-------------------------------------------------------------------------------------------------------------------------
--PROCEDURE

--додамо стовпчик
--ALTER TABLE genres ADD COLUMN ogranichenia varchar; 

--процедура додае у колонку рейтинг шоу на основі жанру 
CREATE OR REPLACE PROCEDURE insert_adulty() LANGUAGE plpgsql  AS $$ 
BEGIN
	update genres set ogranichenia = '18+' where name_genre in ('Horror','Thriller','Harem');
	update genres set ogranichenia = '14+' where name_genre in ('Roman','Vampire','Echti');
	update genres set ogranichenia = '0+' where name_genre not in ('Horror','Thriller','Harem','Roman','Vampire','Echti');
END;
$$;

---call insert_adulty()
---select * from genres

-----------------------------------------------------------------------------------------------------------
---TRIGGER


-- створемо trigger, який буде реагувати на insert, записуючи дату занесення данних у таблицю

-- спочатку створемо відповідні додаткові атрибути 
ALTER TABLE anime ADD COLUMN time_of_insert timestamp; 

CREATE FUNCTION time_inserts() RETURNS trigger
AS $$ BEGIN
	NEW.time_of_insert = NOW(); 
	RETURN new;
END;$$
LANGUAGE 'plpgsql';


CREATE TRIGGER time_inserts
BEFORE INSERT OR UPDATE ON anime
FOR EACH ROW
EXECUTE PROCEDURE time_inserts();

-- тестування
-- insert into anime values (4444444, 'PetrosLIfe', '69', 6969,'TV',10);
-- select * from anime; 




