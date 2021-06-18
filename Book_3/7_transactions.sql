-- Add a new role for employees called Automotive Mechanic
-- Add five new mechanics, their data is up to you
-- Each new mechanic will be working at all three of these dealerships:
-- Meeler Autos of San Diego, Meadley Autos of California and Major Autos of Florida

begin
insert into employeetypes(name)
values('Automotive Mechanic')
returning employee_type_id into newemployeetype;

insert into
		employees(
			first_name,
			last_name,
			email_address,
			phone,
			employee_type_id 
		)
	values
		(
			'Frank',
			'Miller',
			'frank@miller.com',
			'206-555-5555',
			newemployeetype
		) returning employee_id into newemployeeid;
		
		currentts = current_date;
	
	insert into dealershipemployees
		(
		employee_id,
		dealership_id 
		)
	values (
		newemployeeid,
		20
	),
	(
		newemployeeid,
		36
	),
	(
		newemployeeid,
		50
	);

	insert into
		employees(
			first_name,
			last_name,
			email_address,
			phone,
			employee_type_id 
		)
	values
		(
			'Ze',
			'Frank',
			'ze@frank.com',
			'978-555-5555',
			newemployeetype
		) returning employee_id into newemployeeid;
		
		currentts = current_date;
	
	insert into dealershipemployees
		(
		employee_id,
		dealership_id 
		)
	values (
		newemployeeid,
		20
	),
	(
		newemployeeid,
		36
	),
	(
		newemployeeid,
		50
	);

	insert into
		employees(
			first_name,
			last_name,
			email_address,
			phone,
			employee_type_id 
		)
	values
		(
			'Mona',
			'Lisa',
			'mona@lisa.com',
			'999-555-5555',
			newemployeetype
		) returning employee_id into newemployeeid;
		
		currentts = current_date;
	
	insert into dealershipemployees
		(
		employee_id,
		dealership_id 
		)
	values (
		newemployeeid,
		20
	),
	(
		newemployeeid,
		36
	),
	(
		newemployeeid,
		50
	);

	insert into
		employees(
			first_name,
			last_name,
			email_address,
			phone,
			employee_type_id 
		)
	values
		(
			'Dan',
			'Harmon',
			'rick@morty.com',
			'000-555-5555',
			newemployeetype
		) returning employee_id into newemployeeid;
		
		currentts = current_date;
	
	insert into dealershipemployees
		(
		employee_id,
		dealership_id 
		)
	values (
		newemployeeid,
		20
	),
	(
		newemployeeid,
		36
	),
	(
		newemployeeid,
		50
	);

	insert into
		employees(
			first_name,
			last_name,
			email_address,
			phone,
			employee_type_id 
		)
	values
		(
			'Beth',
			'Harmon',
			'queen@bishop.com',
			'987-555-5555',
			newemployeetype
		) returning employee_id into newemployeeid;
		
		currentts = current_date;
	
	insert into dealershipemployees
		(
		employee_id,
		dealership_id 
		)
	values (
		newemployeeid,
		20
	),
	(
		newemployeeid,
		36
	),
	(
		newemployeeid,
		50
	);
	
end;
$$ language plpgsql;


-- Creating a new dealership in Washington, D.C. called Felphun Automotive
-- Hire 3 new employees for the new dealership: Sales Manager, General Manager and Customer Service.
-- All employees that currently work at Nelsen Autos of Illinois will now start working at Cain Autos of Missouri instead.

do $$
declare
	newdealershipid int;
	newemployeeid int;
begin 
	INSERT INTO dealerships
(business_name, phone, city, state, website, tax_id)

VALUES(
'Felphun Automotive', 
'555-555-5555', 
'Washington D.C', 
'D.C', 
'http://www.carnivalcars.com/felphunautomotive', 
'dc-749-iz-2m08')
returning dealership_id into newdealershipid;

INSERT INTO employees
(first_name, last_name, email_address, phone, employee_type_id)
VALUES('Curly', 'Howard', 'curly@stooges.com', '555-555-5555', 3)
returning employee_id into newemployeeid;
insert into dealershipemployees
		(
		employee_id,
		dealership_id 
		)
	values (
		newemployeeid,
		newdealershipid
	);
INSERT INTO employees
(first_name, last_name, email_address, phone, employee_type_id)
VALUES('Mo', 'Howard', 'mo@stooges.com', '123-123-1234', 6)
returning employee_id into newemployeeid;
insert into dealershipemployees 
		(
		employee_id,
		dealership_id 
		)
	values (
		newemployeeid,
		newdealershipid
	);
INSERT INTO employees
(first_name, last_name, email_address, phone, employee_type_id)
VALUES('Larry', 'Howard', 'larry@stooges.com', '123-123-1234', 4)
returning employee_id into newemployeeid;
insert into dealershipemployees 
		(
		employee_id,
		dealership_id 
		)
	values (
		newemployeeid,
		newdealershipid
	);

    --All employees that currently work at Nelsen Autos of Illinois will now start working at Cain Autos of Missouri instead.*/
update dealershipemployees de
set dealership_id = (
	select
		dealership_id
		from dealerships d
		where d.business_name ilike '%Cain Autos of Missouri')
where dealership_id = (
	select
		dealership_id
		from dealerships d
		where d.business_name ilike '%Nelsen Autos of Illinois'
);
END;
$$ language plpgsql;


select * from dealerships d where dealership_id = 4;

select *
from employees e 
where e.first_name = 'Curly';