--mark vehicle as sold

create or replace procedure vehicle_sold(in car_id integer)
language plpgsql
as $$
begin
	update vehicles
	set is_sold = true 
	where vehicle_id = car_id;
end
$$;

call vehicle_sold(12) ;

select * from vehicles v ;


--mark vehicle as returned (and corrresponding actions)

DROP PROCEDURE vehicle_returned(integer)

create or replace procedure vehicle_returned(in invoice_num varchar)
language plpgsql
as $$
begin 
	update vehicles 
	set is_sold = false 
	where vehicle_id = (
		select s.vehicle_id from sales s
		where s.invoice_number
	);
		update sales 
		set sale_returned = true 
	where invoice_number = invoice_num;

	insert into oilchangelogs(date_occured, vehicle_id)
	values(now(), (
		select s.vehicle_id from sales s
		where s.invoice_number = invoice_num));
end
$$;

call vehicle_returned('1936644983');

select is_sold, sale_returned, o.* from sales s
left join oilchangelogs o on s.vehicle_id = o.vehicle_id 
join vehicles v on v.vehicle_id = s.vehicle_id 
where s.invoice_number = '1936644983'