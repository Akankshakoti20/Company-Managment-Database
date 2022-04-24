Drop table works_on;
Drop table project;
Drop table dlocation;
Drop table department;
Drop table employee;
create table employee
(
	ssn varchar(8),
	fname varchar(10),
	lname varchar(10),
	address varchar(10),
	sex varchar(1),
	salary int,
	sup_ssn varchar(8),
	dno int,
	primary key(ssn),
	foreign key(sup_ssn) references employee (ssn)
);

create table department
(
	dno int,
	dname varchar(20),
	mgrssn varchar(8),
	mgr_sdate date,
	primary key(dno),
	foreign key(mgrssn) references employee(ssn)
);

create table dlocation
(
	dno int,
	dloc varchar(20),
	primary key(dno,dloc),
	foreign key(dno) references department(dno)
);

create table project 
(
	pno int,
	pname varchar(20),
	plocation varchar(20),
	dno int,
	primary key(pno),
	foreign key(dno) references department(dno)
);

create table works_on
(
	pno int,
	ssn varchar(8),
	hours int,
	primary key(ssn,pno),
	foreign key(ssn) references employee (ssn),
	foreign key(pno) references project (pno)
);

alter table employee add foreign key (dno) references department (dno);

desc employee;
desc department;
desc project;
desc works_on;

insert into employee values('alis01','soman','scott','bangalore','m',2000000,NULL,NULL);
insert into employee values('alis02','james','smith','kolar','m',1500000,'alis01',NULL);
insert into employee values('alis03','william','baker','bangalore','m',1500000,'alis01',NULL);
insert into employee values('alis04','elson','scott','mysore','m',1500000,'alis01',NULL);
insert into employee values('alis05','pavan','hegde','mangalore','m',700000,'alis02',NULL);
insert into employee values('alis06','girish','jain','mysore','m',1000000,'alis03',NULL);
insert into employee values('alis07','neha','salian','bangalore','f',600500,'alis02',NULL);
insert into employee values('alis08','ashika','hegde','mangalore','f',800000,'alis04',NULL);
insert into employee values('alis09','santhosh','kumar','mumbai','m',500000,'alis02',NULL);
insert into employee values('alis10','mythri','poojary','mysore','f',300000,'alis02',NULL);
insert into employee values('alis11','nagesh','tantri','bangalore','m',900000,'alis04',NULL);
insert into employee values('alis12','vignesh','g','bangalore','m',650000,'alis02',NULL);
insert into employee values('alis13','kaveri','jain','mangalore','f',750000,'alis01',NULL);

insert into department values(1,'accounts','alis02','01-jan-01');
insert into department values(2,'marketing','alis03','11-aug-16');
insert into department values(3,'IT','alis04','23-mar-08');
insert into department values(4,'production','alis08','10-aug-12');
insert into department values(5,'support','alis01','05-mar-10');

update employee set dno=5 where ssn='alis01';
update employee set dno=1 where ssn='alis02';
update employee set dno=2 where ssn='alis03';
update employee set dno=3 where ssn='alis04';
update employee set dno=1 where ssn='alis05';
update employee set dno=2 where ssn='alis06';
update employee set dno=1 where ssn='alis07';
update employee set dno=4 where ssn='alis08';
update employee set dno=1 where ssn='alis09';
update employee set dno=1 where ssn='alis10';
update employee set dno=3 where ssn='alis11';
update employee set dno=1 where ssn='alis12';
update employee set dno=5 where ssn='alis13';

insert into dlocation values(1,'bangalore');
insert into dlocation values(2,'bangalore');
insert into dlocation values(3,'bangalore');
insert into dlocation values(1,'mangalore');
insert into dlocation values(3,'mangalore');
insert into dlocation values(4,'mysore');
insert into dlocation values(5,'hubli');

insert into project values(100,'market_s','bangalore',1);
insert into project values(101,'stocks','bangalore',1);
insert into project values(102,'GST_b','bangalore',1);
insert into project values(103,'T_cards','bangalore',2);
insert into project values(104,'Jio_money','bangalore',2);
insert into project values(105,'iot','bangalore',3);
insert into project values(106,'Pro_xl','bangalore',4);
insert into project values(107,'project_j','bangalore',5);
insert into project values(108,'project_d','bangalore',5);

insert into works_on(pno,ssn,hours) values(100,'alis02',20);
insert into works_on(pno,ssn,hours) values(100,'alis09',30);
insert into works_on(pno,ssn,hours) values(101,'alis10',10);
insert into works_on(pno,ssn,hours) values(101,'alis02',34);
insert into works_on(pno,ssn,hours) values(102,'alis12',25);
insert into works_on(pno,ssn,hours) values(102,'alis07',65);
insert into works_on(pno,ssn,hours) values(103,'alis03',34);
insert into works_on(pno,ssn,hours) values(104,'alis06',22);
insert into works_on(pno,ssn,hours) values(105,'alis11',12);
insert into works_on(pno,ssn,hours) values(107,'alis13',34);
insert into works_on(pno,ssn,hours) values(107,'alis08',63);
insert into works_on(pno,ssn,hours) values(107,'alis01',27);
insert into works_on(pno,ssn,hours) values(108,'alis13',10);
insert into works_on(pno,ssn,hours) values(108,'alis08',30);
insert into works_on(pno,ssn,hours) values(108,'alis05',20);
insert into works_on(pno,ssn,hours) values(105,'alis04',12);

select * from employee;
select * from department;
select * from dlocation;
select * from project;
select * from works_on;

--Query1
(select p.pno from project p, department d, employee e where p.dno = d.dno and d.mgrssn = e.ssn and e.lname='scott')
union
(select p1.pno from project p1,works_on w,employee e1 where p1.pno=w.pno and e1.ssn = w.ssn and e1.lname='scott');

--Query2
select e.fname, e.lname, 1.1*e.salary as incr_sal
from employee e, works_on w, project p
where e.ssn=w.ssn and w.pno=p.pno and p.pname='iot';

--Query3
select sum(e.salary) as total_salary, max(e.salary) as max_salary, min(e.salary) as min_salary, avg(e.salary) as average_salary
from employee e, department d
where e.dno=d.dno
and d.dname = 'accounts';

--Query4
select e.fname, e.lname
from employee e
where not exists((select pno from project where dno='5')minus(select pno from works_on where e.ssn=ssn));

--Query5
select d.dno,count(*)
from department d, employee e
where d.dno=e.dno
and e.salary>600000 and d.dno in (select e1.dno from employee e1 group by e1.dno having count(*)>5) group by d.dno;


