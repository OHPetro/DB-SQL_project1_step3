--drop function if exists get_avg_epintype;


--функція показує середній рейтинг по типу аніме та з відповідним діпазоном мемберв

CREATE OR REPLACE FUNCTION get_avg_epintype_diapason(anime_type_ varchar,members_min int,members_max int) RETURNS Float AS $$
	select ROUND(avg(rating),3) from anime
    where  anime_type = anime_type_ and members > members_min and members < members_max
$$ LANGUAGE SQL;

--test
--select * from get_avg_epintype_diapason('TV',10000,30000)
--select * from get_avg_epintype_diapason('TV',40000,70000)
