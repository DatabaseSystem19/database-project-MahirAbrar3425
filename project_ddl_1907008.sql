
drop table performance;
drop table work;
drop table team;
drop table employee;


Create table employee(
em_id number(20),
age INTEGER CHECK (age>=20),
qualification varchar(30) CHECK (qualification IN('BSC','MSC','BBA','MBA','BTECH')),
salary number(20),
name varchar(30),
team_id number(30),
primary key(em_id)
);

Create table team(
team_id number(30),
em_id number(20),
t_lead number(30),
team_role varchar(30),
primary key(team_id,em_id),
foreign key(em_id) references employee(em_id)
);

create table work(
project_id number(30),
team_id number(30),
from_date date,
to_date date,
is_completed number(10),
primary key(project_id)
);

create table performance(
em_id number(20),
project_id number(30),
presence number(20),
profit number(20),
primary key(em_id,project_id),
foreign key(em_id) references employee(em_id),
foreign key(project_id) references work(project_id)
);