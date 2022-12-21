-- trigger
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
