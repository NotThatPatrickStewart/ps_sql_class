--Adding 5 brand new 2021 Honda CR-Vs to the inventory. They have I4 engines and are classified as a Crossover SUV or CUV. 
--All of them have beige interiors but the exterior colors are Lilac, Dark Red, Lime, Navy and Sand.
--The floor price is $21,755 and the MSR price is $18,999.

do $$
declare
	newvehicletype int;
	newmake int;
	newmodel int;
	newtypeid int;

    begin
insert into vehiclebodytypes(name)
values('CUV')
returning vehicle_body_type_id into newvehicletype;
insert into vehiclemakes(name)
values('Honda')
returning vehicle_make_id into newmake;
insert into vehiclemodels(name)
values('CR-V')
returning vehicle_model_id into newmodel;
insert into vehicletypes(vehicle_body_type_id, vehicle_make_id, vehicle_model_id)
values(newvehicletype, newmake, newmodel)
returning vehicle_type_id into newtypeid;

-- 1
insert into vehicles 
(vin, 
engine_type, 
vehicle_type_id, 
exterior_color, 
interior_color, 
floor_price, 
msr_price, 
miles_count, 
year_of_car, 
is_sold, is_new, 
dealership_location_id)
VALUES(
'3452345fea45dscv', 
'I4', 
newtypeid, 
'lilac', 
'beige', 
21755, 
18999, 
0, 
2021, 
false, 
true, 
4);

--2
insert into vehicles 
(vin, 
engine_type, 
vehicle_type_id, 
exterior_color, 
interior_color, 
floor_price, 
msr_price, 
miles_count, 
year_of_car, 
is_sold, is_new, 
dealership_location_id)
VALUES(
'345234sd5fea45dscv', 
'I4', 
newtypeid, 
'dark red', 
'beige', 
21755, 
18999, 
0, 
2021, 
false, 
true, 
4);

--3
insert into vehicles 
(vin, 
engine_type, 
vehicle_type_id, 
exterior_color, 
interior_color, 
floor_price, 
msr_price, 
miles_count, 
year_of_car, 
is_sold, is_new, 
dealership_location_id)
VALUES(
'234sd5fea45dscv', 
'I4', 
newtypeid, 
'lime', 
'beige', 
21755, 
18999, 
0, 
2021, 
false, 
true, 
4);

--4
insert into vehicles 
(vin, 
engine_type, 
vehicle_type_id, 
exterior_color, 
interior_color, 
floor_price, 
msr_price, 
miles_count, 
year_of_car, 
is_sold, is_new, 
dealership_location_id)
VALUES(
'ppfgzr0dsvmWKE', 
'I4', 
newtypeid, 
'navy', 
'beige', 
21755, 
18999, 
0, 
2021, 
false, 
true, 
4);

--5
insert into vehicles 
(vin, 
engine_type, 
vehicle_type_id, 
exterior_color, 
interior_color, 
floor_price, 
msr_price, 
miles_count, 
year_of_car, 
is_sold, is_new, 
dealership_location_id)
VALUES(
'Silasd5fea45dscv', 
'I4', 
newtypeid, 
'sand', 
'beige', 
21755, 
18999, 
0, 
2021, 
false, 
true,
4);
end;
$$
language plpgsql;


select *
from vehicle


--For the CX-5s and CX-9s in the inventory that have not been sold, change the year of the car to 2021 since we will be updating our stock of Mazdas.
--For all other unsold Mazdas, update the year to 2020. The newer Mazdas all have red and black interiors.
do $$
begin 

update vehicles v
set year_of_car = 2021, interior_color = 'Red and Black'
where year_of_car = 2020 and is_sold = false and v.vehicle_type_id in (select v.vehicle_type_id 
from vehiclemodels vm
join vehicletypes vt on vm.vehicle_model_id = vt.vehicle_model_id 
join vehicles v on vt.vehicle_type_id = v.vehicle_type_id 
where vm.name like 'CX-5' or vm.name like 'CX-9');