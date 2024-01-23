/***************************
*03 일차 수업
***************************/
-- 그룹함수 여러개중에 하나로 대표값으로 나오는것 ex) avg, sum

select sum(salary)
from employees;
-- 단일형 함수
select first_name,
		salary,
        round(salary,2) 
from employees;

 -- count() • 함수에 입력되는 데이터의 총 건수를 구하는 함수

select count(*)
from employees; -- 전체 column 중 가장 많은 애 / null 상관 없음

select count(first_name)
from employees;

select count(commission_pct)
from employees; -- null 값이 많아서 두개(first_name,commission_pct) 계산결과가 완전 다름

select count(*), count(commission_pct)
from employees
; 

-- 월급이 16000 초과 되는 직원의 수는?
select count(*) 
from employees
where salary > 16000
;

select count(commission_pct)
from employees
where salary >16000
;

-- -----------------------------
# sum()
-- -----------------------------
select  sum(salary), -- 이 컬럼 데이터의 합계
		count(*)
from employees
;
-- -----------------------------
# avg() null 포함여부 주의
-- -----------------------------
select  count(*),
		sum(salary),
        avg(salary)
from employees
;

select  count(*), 
		sum(salary), 
		avg(ifnull(salary,0))
from employees
;

-- -----------------------------
# max() / min()
-- -----------------------------
select  count(*),
		max(salary),
        min(salary)
from employees
;

select max(salary),
		first_name
from employees
; -- 정사각형 모양이 아니라서 출력이 안됨 > 다른 컬럼은 107row 대표값은 1개 따라서 출력이 안됨

-- -----------------------------
# GROUP BY 절
-- -----------------------------
select department_id, salary
from employees
; -- "그룹 별 샐러리 합계 갖고와"

select department_id, count(*), max(salary), avg(salary), sum(salary)
from employees
group by department_id 
; -- select 부서별, 대표값
	# Group by에 참여한 컬럼이나 그룹함수만 select 뒤에 올 수 있다.

-- 그룹을 세분화 그룹안에 그룹 만들기
-- 그룹
select department_id, job_id, count(*)
from employees
group by department_id, job_id
;

/*월급(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 월급합계를 출력하
세요*/

select  department_id,
		count(*),
        sum(salary)
from employees        
where sum(salary) >= 20000
group by department_id
; -- select 단계에서 sum 실행하는데 where에서 sum 불러오라니까 에러 뜸. 합계 계산전에 where 을 실행하기 때문에.
  --  where 절에서는 그룹함수 쓸 수 없다.

select department_id, count(*), sum(salary)
from employees
where salary > 20000
group by department_id
;
-- -----------------------------
# HAVING 절
-- -----------------------------
select  department_id,
		count(*),
        sum(salary)
from employees        
-- where sum(salary) >= 20000
group by department_id
having sum(salary) >= 20000
and department_id = 100;
; -- having 절에는 그룹함수 와 Group by에 참여한 컬럼만 사용할 수 있다.

-- -----------------------------
# IF(조건문, 참일때값, 거짓일때값)
-- -----------------------------

select  first_name,
		commission_pct,
        if(commission_pct is null, 0, 1) state
        
from employees;

-- ----------------------------------
# CASE ~ END 문: if~else if~else if~else
-- ----------------------------------

/*직원아이디, 월급, 업무아이디, 실제월급(realSalary)을 출력하세요.
실제월급은 job_id 가 'AC_ACCOUNT' 면 월급+월급*0.1,
'SA_REP' 월급+월급*0.2,
'ST_CLERL' 면 월급+월급*0.3
그외에는 월급으로 계산하세요*/

select  employee_id,
		salary,
        job_id,
        -- case when 조건 then 월급
        case when job_id = 'AC_ACCOUNT' then salary + salary*0.1
			 when job_id = 'SA-REP' then salary + salary*0.2
             when job_id = 'ST-CLERK' then salary + salary*0.3
			 else salary
		end as realSalary
       
from employees
;
/*직원의 이름, 부서번호, 팀을 출력하세요
팀은 코드로 결정하며 부서코드가
10~50 이면 'A-TEAM'
60~100이면 'B-TEAM' 
110~150이면 'C-TEAM' 
나머지는 '팀없음' 으로
출력하세요 */

select  first_name,
		department_id,
        -- case when 조건 then 월급
        case when department_id between 10 and 50 then 'A-TEAM'
             when department_id between 60 and 100 then 'B-TEAM'
             when department_id between 110 and 150 then 'C-TEAM'
        else '팀없음'
        end as 팀
from employees;

-- -----------------------------
# join
-- -----------------------------
-- 사원이름, 부서번호
select first_name,
		department_id
from employees;
-- 부서명
select *
from departments;

-- join
select first_name, department_name
from employees, departments;



select first_name, department_name, department_id
from employees, departments; -- 에러 뜸

select  e.first_name,
		d.department_name,
        e.department_id,
        d.department_id
from employees e, departments d -- 누구 출신의 누구 라고 명확하게 써줘야함 + 별명 정하기
where e.department_id = d.department_id
;

select  e.first_name,
		d.department_name,
        e.department_id,
        d.department_id
from employees e 
inner join departments d
	on e.department_id = d.department_id
    ;
    
/*모든 직원이름, 부서이름, 업무명 을 출력하세요*/

select  e.first_name, -- 4. 뽑을거 열거 해주기
		d.department_id,
        j.job_title,
        j.job_id
from employees e, departments d, jobs j -- 1.from 절에 필요한 테이블 모두 적음
where e.department_id = d.department_id -- 2. 일반적으로 테이블 개수 -1 개의 조인 조건이 필요
and e.job_id = j.job_id -- 3. 조건 마무리
;

select  e.first_name,
		d.department_name,
        j.job_title,
        j.job_id
from employees e
inner join departments d
	on e.department_id = d.department_id
inner join jobs j
	on e.job_id = j.job_id
    ;

/*모든 직원 이름, 부서번호, 부서명, 업무아이디, 업무명, 도시아이디, 도시명 을 출력*/
select  e.first_name,
		d.department_id,
        d.department_name,
        j.job_id,
        j.job_title,
        l.location_id,
        l.city
from employees e, departments d, jobs j, locations l
where e.department_id = d.department_id -- 2. 일반적으로 테이블 개수 -1 개의 조인 조건이 필요
and e.job_id = j.job_id
and d.location_id = l.location_id
;


select  e.first_name,
		d.department_id,
        d.department_name,
        j.job_id,
        j.job_title,
        l.location_id,
        l.city
from employees e
inner join departments d
	on e.department_id = d.department_id
inner join jobs j
	on e.job_id = j.job_id
inner join locations l
	on d.location_id = l.location_id
    ;
    





        
