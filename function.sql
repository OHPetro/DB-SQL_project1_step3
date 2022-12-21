--drop function if exists get_avg_epintype;


--функція показує середній рейтинг по типу аніме та з відповідним діпазоном мемберв

CREATE OR REPLACE FUNCTION get_avg_epintype_diapason(anime_type_ varchar,members_min int,members_max int) RETURNS Float AS $$
	select ROUND(avg(rating),3) from anime
    where  anime_type = anime_type_ and members > members_min and members < members_max
$$ LANGUAGE SQL;

--test
--select * from get_avg_epintype_diapason('TV',10000,30000)
--select * from get_avg_epintype_diapason('TV',40000,70000)



--drop function if exists top_genre_of_user;
-функція показує топ жанрів для юзера

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
