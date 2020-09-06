use company;
show tables;

select * from employee;
select * from department;

drop procedure if exists avg_sal;
delimiter $$
create procedure avg_sal(in ddname varchar(15) character set 'utf8' collate 'utf8_bin',
	out avg_sal int)
begin
	declare sal int;
    declare total_sal int;
    declare cnt int;
	declare endOfRow boolean default false;
    declare cur1 cursor for
		select salary from employee, department where dno=dnumber and dname=ddname;
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
    
	set avg_sal = total_sal / cnt;
    
    close cur1;
    
end $$
delimiter ;

call avg_sal('Research', @average);
select @average;
call avg_sal('Administration', @average);
select @average;
call avg_sal('영업부', @average);
select @average;

drop function if exists avg_salFunc;
delimiter $$
create function avg_salFunc(ddname varchar(15) character set 'utf8' collate 'utf8_bin')
	returns int
begin
	declare sal int;
    declare total_sal int;
    declare cnt int;
    declare avg_sal int;
	declare endOfRow boolean default false;
    declare cur1 cursor for
		select salary from employee, department where dno=dnumber and dname=ddname;
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
    
	set avg_sal = total_sal / cnt;
    
    close cur1;
    
    return avg_sal;
    
end $$
delimiter ;

select avg_salFunc('Research');
select avg_salFunc('영업부');
select avg_salFunc('Administration');
