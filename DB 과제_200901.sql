use company;
set sql_safe_updates = 0;
show tables;

select * from dept_locations;
alter table dept_locations add column phone char(15);
select * from dept_locations;

update dept_locations set phone='01000000001' where dnumber=1 and dlocation='Houston';
update dept_locations set phone='01000000002' where dnumber=4;
update dept_locations set phone='01000000003' where dlocation='Bellaire';
update dept_locations set phone='01000000004' where dnumber=5 and dlocation='Houston';
update dept_locations set phone='01000000005' where dlocation='Sugarland';
select * from dept_locations;

alter table project add column 금액 int;
select * from project;

update project set 금액=500 where pnumber=1;
update project set 금액=5000 where pnumber=2;
update project set 금액=50000 where pnumber=3;
update project set 금액=500000 where pnumber=10;
update project set 금액=5000000 where pnumber=20;
update project set 금액=50000000 where pnumber=30;
select * from project;

insert into department values('영업부', 7, '333445555', '1990-01-01');
insert into department values('비서실', 8, '999887777', '2010-01-01');
select * from department;

insert into dept_locations values(7, '서울', '01000000006');
insert into dept_locations values(7, '부산', '01000000007');
insert into dept_locations values(7, '대구', '01000000008');
select * from dept_locations;

insert into employee values ('Beomsu', 'A', 'Kim', '147258369',
'1988-12-08', 'Seoul', 'M', 65000, '888665555', 7);
insert into employee values ('Eol', 'T', 'Na', '258369147',
'1988-03-23', 'Daegu', 'M', 60000, '123456789', 7);
insert into employee values ('Hyosin', 'T', 'Park', '369147258',
'1988-10-18', 'Busan', 'M', 85000, null, 7);
select * from employee;

insert into works_on values (147258369, 1, 5);
insert into works_on values (147258369, 2, 3);
insert into works_on values (258369147, 1, 15);
insert into works_on values (258369147, 3, 5);
insert into works_on values (369147258, 1, 52);
select * from works_on;

select ssn, fname, lname, bdate from employee where salary>=30000;

select ssn, fname, lname, bdate from employee where salary>=30000 and dno=5;

select ssn, fname, lname, bdate
from employee, department
where salary>=30000 and dnumber=dno and dname='Research';

select ssn, pno
from employee, department, works_on
where dnumber=dno and dname='Research' and ssn=essn;

select fname, lname, pname
from employee, department, works_on, project
where dnumber=dno and dname='Research' and ssn=essn and pno=pnumber;

select dnumber, mgr_ssn
from department
where dname='영업부';

select dlocation, phone
from department as d, dept_locations as dl
where d.dname='영업부' and d.dnumber=dl.dnumber;

select e.fname, e.lname, s.fname fname_mentor, s.lname lname_mentor
from employee e, employee s
where e.super_ssn=s.ssn and e.dno!=s.dno;
