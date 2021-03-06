--Create a trigger for when a new Sales record is added, set the pickup date to 7 days from the purchase date.

CREATE FUNCTION set_pickup_date() 
  RETURNS TRIGGER 
  LANGUAGE PlPGSQL
AS $$
BEGIN
  -- trigger function logic
  UPDATE sales
  SET pickup_date = NEW.purchase_date + integer '7'
  WHERE sales.sale_id = NEW.sale_id;
  
  RETURN NULL;
END;
$$

CREATE TRIGGER new_sale_made
  AFTER INSERT
  ON sales
  FOR EACH ROW
  EXECUTE PROCEDURE set_pickup_date();

  insert into sales (sales_type_id, vehicle_id, employee_id, customer_id, dealership_id, price, deposit, purchase_date, invoice_number, payment_method, sale_returned)
 	values (1, 10000, 497, 834, 27, 27000, 3000, '2021-06-07', '4684684465', 'mastercard', false);
 	
select * from sales where invoice_number = '4684684465';


--Create a trigger for when a new Sales record is added, set the purchase date to 3 days from the current date.

create or replace function set_purchase_date()
	returns trigger
	language plpgsql
as $$
begin
	update sales 
	set purchase_date = current_date + integer '3'
	where sales.sale_id = new.sale_id;

	return null;
end;
$$

create trigger new_purchase_made
	after insert 
	on sales
	for each row
	execute procedure set_purchase_date();

insert into sales (sales_type_id, vehicle_id, employee_id, customer_id, dealership_id, price, deposit, invoice_number, payment_method, sale_returned)
 	values (1, 594, 497, 834, 27, 27000, 3000, '897918566', 'mastercard', false);
 	
 select * from sales where invoice_number = '897918566';


 --Both?

create or replace function set_purchase_and_pickup_dates()
	returns trigger
	language plpgsql
as $$
begin
	update sales 
	set purchase_date = current_date + integer '3', pickup_date = current_date + integer '7'
	where sales.sale_id = new.sale_id;

	return null;
end;
$$

CREATE TRIGGER new_sale_made_all_dates
  AFTER INSERT
  ON sales
  FOR EACH ROW
  EXECUTE PROCEDURE set_purchase_and_pickup_dates();

   insert into sales (sales_type_id, vehicle_id, employee_id, customer_id, dealership_id, price, deposit, invoice_number, payment_method, sale_returned)
 	values (1, 1006, 497, 834, 27, 27000, 3000, '8791234555', 'mastercard', false);
 
 select * from sales where invoice_number = '8791234555';


 --Create a trigger for updates to the Sales table. If the pickup date is on or before the purchase date, set the pickup date to 7 days after the purchase date.
--If the pickup date is after the purchase date but less than 7 days out from the purchase date, add 4 additional days to the pickup date.

create or replace function variable_pickup_date()
	returns trigger 
	language plpgsql
as $$
begin 
	if (new.pickup_date <= new.purchase_date + integer '7'
	and new.pickup_date > new.purchase_date)
	then
		 update sales
		 set pickup_date = NEW.purchase_date + integer '4'
		 where sales.sale_id = NEW.sale_id;
	elseif
	(new.pickup_date <= new.purchase_date)
	then
	update sales
	set pickup_date = new.purchase_date + integer '7'
 	where sales.sale_id = NEW.sale_id;
 end if;
return null;
end;
$$

create trigger check_purcahse_date
	after insert 
	on sales
	for each row
	execute procedure variable_pickup_date();

    	insert into sales (sales_type_id, vehicle_id, employee_id, customer_id, dealership_id, price, deposit, purchase_date, pickup_date, invoice_number, payment_method, sale_returned)
 	values (1, 1008, 497, 834, 27, 27000, 3000, '2021-06-02', '2021-06-03', '897215800', 'mastercard', false);
 
 select * from sales where invoice_number = '897215800';