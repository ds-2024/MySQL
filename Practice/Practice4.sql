-- ---------------------------
#서브쿼리(SUBQUERY) SQL 문제입니다.
-- ---------------------------
/*문제1.
평균 월급보다 적은 월급을 받는 직원은 몇명인지 구하시요.
(56건)*/
select avg(salary)
from employees
; -- 6461.831776

select  first_name,
		salary
from employees
where salary < (select avg(salary)
						from employees)
;

/*문제2. 
평균월급 이상, 최대월급 이하의 월급을 받는 사원의
직원번호(employee_id), 이름(first_name), 월급(salary), 평균월급, 최대월급을 월급의 오름차
순으로 정렬하여 출력하세요
(51건)*/
select  avg(salary),
		max(salary)
from employees
; -# avg 6461.831776 max 24000.00

select  employee_id,
		first_name,
        salary
from employees
where salary between avg(salary) and max(salary)
; -- invalid usd of group function

select  employee_id,
		first_name,
        salary
from employees
where salary >= (select  avg(salary)
							from employees)
 and salary <= (select max(salary)
						from employees) 
order by salary asc
;

/*문제3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소
를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주
(state_province), 나라아이디(country_id) 를 출력하세요
(1건)*/
select*
from employees
where last_name = 'King'
;
select  e.department_id,
		d.department_name,
		e.first_name,
        e.last_name
from departments d, employees e
where first_name = 'Steven'
and last_name = 'King'
;
select  l.location_id,
		l.street_address,
        l.postal_code,
        l.city,
        l.state_province,
        l.country_id
from locations, departments, employees
;

/*문제4.
job_id 가 'ST_MAN' 인 직원의 월급보다 작은 직원의 사번,이름,월급을 월급의 내림차순으로
출력하세요 -ANY연산자 사용
(74건)*/
/* 1. job_id 가 'ST_MAN' 인 직원의 월급 구하기*/
select  first_name,
		salary
from employees
where job_id = 'ST_MAN'
; -- between 5800 and 8200

select  employee_id,
		first_name,
        salary
from employees
where salary < any(select salary
					from employees
					where job_id = 'ST_MAN') -- any 연산으로 했으니 8200 이하면 ok
order by salary desc
;

/*문제5. 
각 부서별로 최고의 월급을 받는 사원의 직원번호(employee_id), 이름(first_name)과 월급
(salary) 부서번호(department_id)를 조회하세요
단 조회결과는 월급의 내림차순으로 정렬되어 나타나야 합니다. 
조건절비교, 테이블조인 2가지 방법으로 작성하세요
(11건)*/
/*1. 각 부서별 최고 월급 구하기*/
select  max(salary)
from employees
group by department_id
; -- 12 rows

select  employee_id 직원번호,
		first_name 이름,
        salary 월급,
        department_id 부서번호
from employees
where (department_id, salary) in (select  department_id, max(salary)
										from employees
										group by department_id)
order by salary desc
; -- 부서번호 11개 따라서 11rows

select  e.employee_id 직원번호,
		e.first_name 이름,
        s.salary 월급,
        s.department_id 부서번호
from employees e, (select department_id, max(salary) salary
					from employees
					group by department_id) s
 where e.department_id = s.department_id
  and e.salary =  s.salary
 order by s.salary desc
 ;
/*문제6.
각 업무(job) 별로 월급(salary)의 총합을 구하고자 합니다. 
월급 총합이 가장 높은 업무부터 업무명(job_title)과 월급 총합을 조회하시오
(19건)*/
select sum(salary),
		job_id
from employees
group by job_id
; -- job 갯수 19 rows

select  job_title,
		sum(salary)
from jobs, employees
order by sum(salary) desc
;

/*문제7.
자신의 부서 평균 월급보다 월급(salary)이 많은 직원의 직원번호(employee_id), 이름
(first_name)과 월급(salary)을 조회하세요
(38건)*/
/* 1.자신의 부서 평균 월급보다 월급이 많은 직원 구하기*/
select  avg(salary),
		department_id
from employees
group by department_id
; -- 12rows 
select  employee_id,
		first_name,
        salary
from employees
where salary >any (select  avg(salary),
						
						from employees
						group by department_id)
;
/*문제8.
직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 월급, 입사일을 입사일 순서로 출력
하세요*/
select  employee_id 사번,
		first_name 이름,
        salary 월급,
        hire_date 입사일
from employees
order by hire_date asc
limit 10,5
;

