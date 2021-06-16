-- Add a new role for employees called Automotive Mechanic
-- Add five new mechanics, their data is up to you
-- Each new mechanic will be working at all three of these dealerships:
-- Meeler Autos of San Diego, Meadley Autos of California and Major Autos of Florida

begin
insert into employeetypes(name)
values('Automotive Mechanic')
returning employee_type_id into newemployeetype;