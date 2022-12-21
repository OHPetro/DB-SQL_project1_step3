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
