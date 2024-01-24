-- -----------------------------
# left outer join
-- -----------------------------

select  e.department_id,
		e.first_name,
        d.department_name
from employees e -- 왼쪽기준
left outer join departments d -- ex 1조 2조 3조 4조 5조 까지 만들어 놨는데 5조 전원 중탈 >  근데 서류상으로는 5조까지 정보를 남기고 싶음(null값)
	on e.department_id = d.department_id
    ;
    
select * -- null 16개
from employees e -- 왼
right outer join departments d -- 오른쪽 기준으로 다보여줘
	on e.department_id = d.department_id
    ;
    
select * -- Kimberly
from employees e -- 오른쪽
left outer join departments d -- 왼쪽기준  *왜 왼쪽기준으로 join 했을까? departments d기준으로 직원이름 다 보여줘 값이 null이라도
	on e.department_id = d.department_id
    ;  
    
select first_name, e.department_id, d.department_name
from employees e
right outer join departments d
	on e.department_id = d.department_id
;
-- ---두개 출력값이 같다.
select first_name, e.department_id, d.department_name
from departments d
left outer join employees e
	on e.department_id = d.department_id
;

(select  *
from employees e
left outer join departments d
	on e.department_id = d.department_id
    )
    union
    
(select  *
from employees e
right outer join departments d
on e.department_id = d.department_id
    )
    ;
select 107+122-106;

-- -----------------------------
# self join
-- -----------------------------
select  employee_id,
		first_name,
        manager_id,
        department_id,
        job_id
from employees;

select *
from employee e, manager m
where e.manager_id = m.employee_id
;

/*모든 직원이름, 부서이름, 업무명 을 출력하세요*/

select  e.first_name, -- 4. 뽑을거 열거 해주기
		d.department_id
from employees e, departments d -- 1.from 절에 필요한 테이블 모두 적음
where e.department_id = d.department_id -- 2. 일반적으로 테이블 개수 -1 개의 조인 조건이 필요
;

select e.employee_id,
		e.first_name,
        m.first_name manager_name
from employees e, employees m -- 같은 테이블을 두번 보겠다! 따라서 다른 별명 꼭 필요함
where e.manager_id = m.employee_id
;

-- -----------------------------
# 잘못된 join 정보를 결합했을때 유의미한 결과가 없이 숫자데이터만 같은경우
-- -----------------------------
select  e.first_name,
		e.salary,
		l.location_id,
        l.street_address,
        l.city-- 1.select * 으로 두고 나중에 원하는 품목명 넣어주자 4. 특정컬럼 기입
from employees e, locations l -- 2. 테이블과 as
where e.salary = l.location_id -- 3.조건
; -- 정보를 결합했을때 유의미한 결과가 없이 숫자데이터만 같은경우

-- -----------------------------

# SubQuery : 하나의 SQL 질의문 속에 다른 SQL 질의문이 포함되어 있는 형태

-- -----------------------------

select first_name,
		salary
from employees       
where first_name = 'Den' -- Den, 11000
;

select first_name,
		salary
from employees
where salary >= 11000
;
-- 'Den' 보다 월급을 많은 사람의 이름과 월급은?
-- Den의 월급을 구한다

select first_name,
		salary
from employees
where first_name = 'Den';

select first_name,
		salary
from employees
where salary >= 11000
;
-- 합치기
select first_name,
		salary
from employees
where salary >= (select salary
				 from employees
				 where first_name = 'Den');



