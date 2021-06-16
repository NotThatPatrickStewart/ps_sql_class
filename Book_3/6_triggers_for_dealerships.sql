--Because Carnival is a single company, we want to ensure that there is consistency in the data provided to the user.
--Each dealership has it's own website but we want to make sure the website URL are consistent and easy to remember.
--Therefore, any time a new dealership is added or an existing dealership is updated,
--we want to ensure that the website URL has the following format: http://www.carnivalcars.com/{name of the dealership with underscores separating words}.

CREATE or replace FUNCTION set_dealership_url()
  RETURNS TRIGGER
  LANGUAGE PlPGSQL
AS $$
BEGIN
  UPDATE dealerships
  SET website = CONCAT('http://www.carnivalcars.com/', new.business_name)
  where dealerships.dealership_id = new.dealership_id;
  RETURN NULL;
END;
$$

CREATE TRIGGER new_dealership_website
  AFTER INSERT
  ON dealerships
  FOR EACH ROW
  EXECUTE PROCEDURE set_dealership_url();

  insert into dealerships (business_name, phone, city, state, tax_id)
	values ('carzzz', '615-999-9990', 'Nashville', 'Tennessee', 'px-209-px-gq6b');

select * from dealerships where phone like '615-999-9990';


--If a phone number is not provided for a new dealership, set the phone number to the default customer care number 777-111-0305.
CREATE or replace FUNCTION set_default_phone_number()
  RETURNS TRIGGER
  LANGUAGE PlPGSQL
AS $$
BEGIN
  UPDATE dealerships
  set phone = '777-111-0305'
  where phone is NULL;
  RETURN NULL;
END;
$$

create trigger dealership_phone_default
	after insert 
	on dealerships
	for each row
	execute procedure set_default_phone_number();

insert into dealerships (business_name, city, state, website, tax_id)
	values ('carz_again', 'Nashville', 'Tennessee', 'http://www.carnivalcars.com/carz', 'po-098-px-gq6b');

select * from dealerships d where business_name like 'carz_again';