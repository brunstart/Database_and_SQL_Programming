use company;
show tables;
select * from employee;
select * from project;

drop procedure if exists getDnum;
delimiter $$
create procedure getDnum(in pid int, out dn int)
begin
	select dnum into dn from project where pnumber = pid;
end $$
delimiter ;

call getDnum(1, @dd);
select @dd;

call getDnum(10, @dd);
select @dd;

call getDnum(30, @dd);
select @dd;

select * from project;

drop procedure if exists getPname;
delimiter $$
create procedure getPname(in pid int, out pn varchar(15))
begin
	select pname into pn from project where pnumber = pid;
end $$
delimiter ;

call getPname(1, @pp);
select @pp;

call getPname(2, @pp1);
select @pp1;

select * from employee;

drop procedure if exists getEname;
delimiter $$
create procedure getEname(in sn char(9), out fn varchar(15), out ln varchar(15))
begin
	select fname, lname into fn, ln
    from employee
    where ssn = sn;
end $$
delimiter ;

call getEname('123456789', @fname, @lname);
select @fname, @lname;

call getEname('987654321', @fname, @lname);
select @fname, @lname;

call getEname('369147258', @fname, @lname);
select @fname, @lname;

drop procedure if exists getEname2;
delimiter $$
create procedure getEname2(in sn char(9), 
	out fn varchar(15) character set 'utf8' collate 'utf8_bin',
    out ln varchar(15) character set 'utf8' collate 'utf8_bin')
begin
	select fname, lname into fn, ln
    from employee
    where ssn = sn;
end $$
delimiter ;

call getEname2('123456789', @fname, @lname);
select @fname, @lname;

call getEname2('987654321', @fname, @lname);
select @fname, @lname;

call getEname2('147258369', @fname, @lname);
select @fname, @lname;

drop function if exists getEnameFunc;
delimiter $$
create function getEnameFunc (sn char(9))
		returns varchar(15) char set 'utf8' collate 'utf8_bin'
begin
		declare ln varchar(15) char set 'utf8' collate 'utf8_bin';
        select lname into ln from employee where ssn = sn;
        return ln;
end $$
delimiter ;

select getEnameFunc('123456789');
select getEnameFunc('987654321');
select getEnameFunc('147258369');

### Cursor
drop procedure if exists getSalarySsn;

delimiter $$
create procedure getSalarySsn(in sn char(9), out inc_sal int)
begin
	declare sal int;
    select salary into sal from employee where ssn=sn;
    set inc_sal = sal * 1.1;
end $$
delimiter ;

call getSalarySsn('123456789', @inc_salary);
select @inc_salary;
select * from employee;

call getSalarySsn('987654321', @inc_salary);
select @inc_salary;

drop procedure if exists getSalaryDnoCur;

delimiter $$
create procedure getSalaryDnoCur(in dn int, out total_sal int, out cnt int)
begin
	declare sal int;
    declare endOfRow boolean default false;
    declare cur1 cursor for
		select salary from employee where dno=dn;
	declare continue handler for not found set endOfRow = true;
    
    set total_sal = 0;
    set cnt = 0;
    
    open cur1;
    
    cursor_loop:LOOP
		fetch cur1 into sal;
        if endOfRow then leave cursor_loop;
        end if;
        set total_sal = total_sal + sal;
        set cnt = cnt + 1;
    end loop cursor_loop;
    
    close cur1;
end $$
delimiter ;

call getSalaryDnoCur(5, @total_salary, @cnt);
select @total_salary, @cnt;