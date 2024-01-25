/***********************************************************
05일차 수업
************************************************************/
-- ---------------------------------------------------------
# SubQuery : 하나의 SQL 질의문 속에 다른 SQL 질의문이 포함되어 있는 형태
-- ---------------------------------------------------------
/* 'Den' 보다 월급을 많은 사람의 이름과 월급은?
-- 계획 수립 
1. Den 월급 조회. 
2. 직원테이블에서 월급이 11000Den보다 많은 사람을 구한다.
*/
-- Den 월급구하기
select *
from employees
where first_name = 'Den' -- 11000
;
--  직원 테이블 에서 월급이 11000보다 많은 사람을 구한다.
select *
from employees
where salary > 11000
;

-- 합치기
select *
from employees
where salary > (select salary
				from employees
				where first_name = 'Den')
;

/* 월급을 가장 적게 받는 사람의 이름, 월급, 사원번호는?

1. 가장 적은 월급 구하기
2. 그 월급을 받는 사람의 이름, 월급 , 사원번호 구하기
*/
select min(salary)
from employees
;

select  first_name,
		salary,
        employee_id
from employees
where salary = 2100
;

select  first_name,
		salary,
        employee_id
from employees
where salary  = (select min(salary)
				from employees)
;

/* 평균 월급보다 적게 받는 사람의 이름, 월급을 출력하세요

1. 평균 월급 구하기
2. 그 수치 보다 낮은 사람 이름, 월급 구하기 */

select avg(salary)
from employees
;
select  first_name,
		salary
from employees
where salary < 6461.831776
;
select  first_name,
		salary
from employees
where salary <(select avg(salary)
				from employees)
;

/* 부서번호가 110인 직원의 급여와 같은 월급을 받는 모든 직원의 사번, 이름, 급여를 출력하세요

1. 부서번호가 110인 직원의 급여 구하기 > Shelley 12008.00 , William 8300.00
2. 그 급여와 같은 월급을 받는 모든 직원의 사번, 이름, 급여 구하기
*/

select *
from employees
where department_id = 110
; 

select  employee_id,
		first_name,
        salary
from employees
where salary = 12008.00
or salary = 8300.00 -- where salary in (12008, 8300)
; -- 12008.00, 8300.00 결과의 row 1개 이상일때

select *
from employees
where salary in (select salary
				 from employees
				 where department_id = 110)
;
select  employee_id,
		first_name,
        salary
from employees
where salary in (select salary
				 from employees
				 where department_id = 110)
;

/*각 부서별로 최고급여를 받는 사원의 이름과 월급을 출력하세요

1. 각 부서별 최고급여 구하기
*/

select max(salary)
from employees
group by department_id
; -- 12개의 값이 나옴

select  first_name,
		salary,
        department_id
from employees
where salary in (select max(salary)
				 from employees
				 group by department_id)
                 ; -- 아니 각 부서별 최고월급인데 왜 같은값 부서가 여러개 값이 나올까?! 
                   -- ex) 40번 부서 최고월급이 6500 인데, 80번 부서 사람 중 월급이 6500인 사람이 많다!!
                   -- 그래서 40번 부서 최고월급 6500과 80번 6500이 같이 출력됨
			# 즉, in((10,4400),(20,13000),(30,11000),(40,6500).....) 이 뜻
            # 따라서, salary 말고 department_id 로도 구분을 한번 더 해줘야한다.
-- in 문법 확장
-- where 절 여러가지 칼럼을 동시에 비교가능, 칼럼의 갯수와 데이터의 개수가 일치해야 한다. operand 갯수 = column 갯수
select  first_name,
		salary,
        department_id
from employees
where (department_id, salary) in (select department_id, max(salary)
								  from employees
								  group by department_id)
 ;
 /*
 부서별 최고값 이름
 부서별 최저값 이름
 월급 최저인 직원의 월급과 이름*/
 
 select min(salary)
 from employees
 group by department_id
 ; -- 부서갯수 12개
 
 select salary,
		first_name,
        department_id
 from employees
 where (department_id, salary) in (select department_id, min(salary)
									from employees
									group by department_id)
				;
-- ---------------------------------------------------------
# SubQuery Any
-- ---------------------------------------------------------
/*부서번호가 110인 직원의 급여 보다 큰 모든 직원의
이름, 급여를 출력하세요.(or연산--> 8300보다 큰)
1. 부서번호 110 인 직원 급여 구하기
2. 
*/
select first_name,
		salary
from employees
where department_id = 110
;

-- 월급이 8300 보다 큰 직원의 이름, 급여를 출력하세요.
select first_name,
		salary
from employees
where salary > any(select salary
					from employees
					where department_id = 110)
;
-- ---------------------------------------------------------
# SubQuery All
-- ---------------------------------------------------------
/*부서번호가 110인 직원의 급여 보다 큰 모든 직원의
이름, 급여를 출력하세요.(and연산--> 12008보다 큰)*/

select first_name,
		salary
from employees
where department_id = 110
;

select  first_name,
		salary
from employees
where salary > all (select salary
					from employees
					where department_id = 110) 
;

-- ---------------------------------------------------------
# 조건절에서 비교 vs 테이블에서 조인
-- ---------------------------------------------------------
/*각 부서별로 최고월급을 받는 사원의 부서번호, 직원번호, 이름, 월급을 출력하세요*/

select max(salary)
from employees
group by department_id
;
select  department_id,
		employee_id,
        first_name,
        salary
from employees
where (department_id, salary) in (select department_id, max(salary)
									from employees
									group by department_id)
;
select *
from employees e , departments d
;
-- -----------------
# 테이블에서 조인
-- -----------------

select *
from employees e, (select department_id, max(salary) salary
					from employees
					group by department_id) s -- 이런 값의 테이블을 만들어줬음. 테이블 s
 where e.department_id = s.department_id
 and e.salary =  s.salary
;
-- ---------------------------------------------------------
# limit
-- ---------------------------------------------------------
select *
from employees
order by employee_id asc
limit 0,5
;
select employee_id, first_name, salary
from employees
order by employee_id asc
limit 5 offset 1
;
/*07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은?*/

select  first_name,
		salary,
        hire_date
from employees
where hire_date between '07/01/01' and '07/12/31' -- '' 꼭 확인하기
order by salary desc
limit 2,5
;