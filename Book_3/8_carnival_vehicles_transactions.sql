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