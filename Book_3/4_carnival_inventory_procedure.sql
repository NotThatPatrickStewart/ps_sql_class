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