use hrdb;
/***************************
select문 (조회)
***************************/
#select ~from 절alter
-- 테이블 전체 조회하기
select * from employees;
select * from departments;
select * from locations;
select * from countries;
select * from regions;
select * from jobs;
select * from job_history;
select * FROM job_history;
-- select 절 column 보여준다
select first_name, salary
from employees;

-- 모든 직원의 직원아이디(employee_id), 이름(first_name), 성(last_name)
-- 을 모두 출력하세요

select employee_id, first_name, last_name 
from employees;
select first_name, phone_number, hire_date, commission_pct
from employees;
select  first_name,
		last_name, 
		salary,
		phone_number,
		email, 
		hire_date
from employees;

select *
from employees;
select employee_id as empNO,
		first_name as 'f-name',
        salary as '월 급'
from employees;

select first_name 이름,
	   phone_number 전화번호,
	   hire_date 입사일, 
	   salary 월급
from employees;

select employee_id as '사 번',
		first_name 이름,
        last_name 성,
        salary 월급,
        phone_number 전화번호 ,
        email 이메일,
        hire_date 입사일
from employees;

-- 산술 연산자 사용하기
select first_name,
		salary, 월급,
        salary-100 '월급 -식대',
        salary*12,
        salary*12 +500,
        salary/30,
        employee_id%3
from employees;

-- 문자열은 0 으로 처리 --> 오류가 나지 않으므로 확인이 안될 수 있다. 
select job_id*12
from employees;

-- 컬럼 합치기
select  first_name,
		last_name,
		concat(first_name,' ', last_name) name,
        concat(first_name,' ', last_name, ' hire date is ', hire_date) name2
from employees;

-- 테이블의 컬럼명 테이블의 데이터, 문자열, 숫자는 그대로 출력
select first_name,
		salary*12 연봉,
        '(주)개발자' company,
        3 상태 #별명은 항상 옆에 써주면 된다
        
from employees;

-- 테이블 명 생략가능, 가상의 테이블 dual

select now();

select  now()
from dual; 

select 123*5;

-- where 절
select first_name, department_id
from   employees
where  department_id = 10;

select first_name, 
	   salary
from   employees
where  salary >= 15000;

select first_name, 
	   hire_date
from employees
where hire_date >= '2007-01-01';

select  first_name,
		salary
from employees
where first_name = 'Lex';

select first_name, 
	   salary
from employees
where binary first_name = 'lex';

#월급이 14000이상 17000이하인 사원의 이름과 월급을 구하시오

select  first_name,
		salary
from employees
where salary >= 14000
and salary <= 17000
;

select  first_name,
		salary
from employees
where salary <= 14000
or salary >= 17000
;

select  first_name,
		hire_date
from employees
where hire_date >= '04/01/01'
and hire_date <= '05/12/31'
;

select  first_name,
		salary
from employees
where salary >= 14000
and salary <= 17000
;

select  first_name,
		salary
from employees
where salary between 14000 and 17000
;

select  first_name,
		last_name,
        salary
from employees
where first_name = 'Neena'
or first_name = 'Lex'
or first_name = 'John'
;

select  first_name,
		last_name,
        salary
from employees
where first_name in ('Neena','Lex','John', 'David')
;

select  first_name,
		salary
from employees
where salary in('2100','3100','4100','5100')
;

select  first_name,
		salary
from employees
where salary = '2100'
or salary = '3100'
or salary = '4100'
or salary = '5100'
;

select first_name, '여자' gender
from employees;

/************************************
*02일차 수업
*************************************/

-- like Like 연산자로 비슷한것들 모두 찾기

select *
from employees
where first_name = 'John'
;

select  first_name,
		last_name,
		salary
from employees
where first_name like 'L%'
;
select  first_name,
		salary
from employees
where first_name like '%am%'
;
select  first_name,
		salary
from employees
where first_name like '_a%'
;
select  first_name,
		salary
from employees
where first_name like '___a%'
;
select  *
from employees
where first_name like '_a__'
;

-- null
select  first_name,
		salary,
        commission_pct,
        salary*commission_pct
from employees
where salary between 13000 and 15000
;
select *
from employees
where commission_pct is null
;
select *
from employees
where commission_pct is not null
;

#커미션비율이 있는 사원의 이름과 월급 커미션비율을 출력하세요
select  first_name,
		commission_pct
from employees
where commission_pct is not null
;

#담당매니저가 없고 커미션비율이 없는 직원의 이름과 매니저아이디 커미션 비율을 출력하세요
select  first_name,
		manager_id,
        commission_pct
from employees
where manager_id is null
and commission_pct is null
;

#부서가 없는 직원의 이름과 월급을 출력하세요
select  first_name,
		salary
from employees
where department_id is null
;

-- ORDER BY
select  first_name,
		salary
from employees
where salary >= 10000
order by salary desc; -- asc 올라가는 --order by 만 치면 기본으로 asc 순으로 나옴

select *
from employees
order by employee_id asc
;

select  first_name,
		salary
from employees
order by first_name asc
;

select  first_name,
		hire_date,
        salary
from employees
order by hire_date desc;

-- 1.최근 입사한 순, 2. 입사일이 같으면 월급이 많은 사람부터

select  first_name,
		hire_date,
        salary
from employees
order by hire_date desc, salary desc; -- 순번은 and 나 or 아니고 , 로 추가

#부서번호를 오름차순으로 정렬하고 부서번호, 월급, 이름을 출력하세요
select  department_id,
		salary,
        first_name
from employees
order by department_id asc;
        
#월급이 10000 이상인 직원의 이름 월급을 월급이 큰직원부터 출력하세요
select  first_name,
		salary
from employees
where salary >= 10000
order by salary desc
;

#부서번호를 오름차순으로 정렬하고 부서번호가 같으면 월급이 높은 사람부터 부서번호 월급 이름을 출력하세요
select  department_id,
		salary,
        first_name
from employees
order by department_id asc, salary desc
;

#직원의 이름, 급여, 입사일을 이름의 알파벳 올림차순으로 출력하세요
select  first_name,
		salary,
        hire_date
from employees
order by first_name asc
;

#직원의 이름, 급여, 입사일을 입사일이 빠른 사람 부터 출력하세요
select  first_name,
		salary,
        hire_date
from employees
order by hire_date asc
;

/*************************************
* 02 일차 수업 함수
***************************************/
-- 단일형 함수
-- 단일형 함수 >  숫자 함수
-- round() : 반올림
select  round(123.123, 2)
		,round(123.126, 2) -- 둘째자리 까지 출력 되게 반올림 하쇼
        ,round(234.567, 0)
        ,round(123.456) -- 0일때는 안써줘도 알아서 반올림 됨
        ,round(123.126, -1) -- 소수점 기준 -1 방향에서 반올림
        ,round(125.126, -1)
        ,round(123.126, -2)
from dual;

-- 올림 ceil
select  ceil(123.456), -- 124 올림은 무조건 0자리에서
		ceil(123.789), -- 124 
		ceil(123.7892313), -- 124
		ceil(987.1234) -- 988
;
 select first_name,
		salary,
        ceil(salary/30) as 일당
 from employees
 order by salary desc;

-- 내림 floor

select  floor(123.456), -- 123
		floor(123.789), -- 123
		floor(123.7892313), -- 123
		floor(987.1234) -- 987
;

-- 버림 truncate
select  truncate(1234.34567, 2), --  소수점 2째짜리 까지 나타내쇼
		truncate(1234.34567, 3),
		truncate(1234.34567, 0),
		truncate(1235.34567, -2)
;
-- n승 pow, power
 select pow(12,2), power(12,2); -- 숫자의 2승
 
 -- 제곱근
 select sqrt(144); -- 숫자의 제곱근/ 루트
 
 -- SIGN(숫자): 숫자가 음수이면 -1, 0이면 0, 양수이면 1
  select sign(123), -- 1
		 sign(0), -- 0
		 sign(-123) -- -1
;

-- ABS(숫자): 절대값
select  abs(123), -- 123
		abs(0), -- 0
		abs(-123) -- 123
;
-- GREATEST(x, y, z, ...): 괄호안의 값중 가장 큰값
select  greatest(2, 0, -2),  -- 2
		greatest(4, 3.2, 5.25), -- 5.25
		greatest('B', 'A', 'C', 'c') --  ABC 중에서는 C/ Cc 중에서는 c
        ;
select  employee_id,
		manager_id,
        department_id,
      greatest(employee_id, manager_id, department_id) -- 값 하나 주고 제일 큰거 고르라는 식 따라서 어색
from employees;

        
-- LEAST(x, y, z, ...): 괄호안의 값중 가장 작은값
select  least(2, 0, -2), -- -2
		least(4, 3.2, 5.25), -- 3.20
		least('B', 'A', 'C', 'c') -- A
from dual;


select max(salary) -- 이 컬럼 중에 제일 큰거
from employees; 

-- 단일형 함수 > 문자함수
select concat('안녕', '하세요')
from dual;

select concat ('안녕', ' ' , '하세요')
from dual;

select concat('-', 'abc', '123', '가나다')
from dual;


-- CONCAT_WS(s, str1, str2, ..., strn): str1, str2, ..., strn을 연결할때 사이에 s 로 연결 with seperator
select concat_ws('********','abc','123','가나다')
from dual;

select concat_ws('-', 'first_name', 'last_name', 'salary')
from employees;

-- LCASE(str) 또는 LOWER(str): str의 모든 대문자를 소문자로 변환
select  first_name,
		ucase(first_name),
        upper(first_name),
        upper('ABCabc*&^%'),
        upper('가나다라마바사')
from employees;

-- 문자갯수
select first_name,
		length(first_name),
        char_length(first_name),
        char_length(first_name)
from employees;

-- LENGTH(str): str의 길이를 바이트로 반환
-- CHAR_LENGTH(str) 또는 CHARACTER_LENGTH(): str의 문자열 길이를 반환
select  length('a'), 
		char_length('a'), 
        character_length('a')
from dual;

select  length('가'),
        char_length('가'),
        char_length('가')
from dual;

-- SUBSTRING(str, pos, len) 또는 SUBSTR(str, pos, len): 
-- str의 pos 위치에서 시작하여 len 길이의 문자열 반환
select  first_name, 
		substr(first_name,1,3), 
		substr(first_name,2,2),
        substr(first_name,-3,2) -- -는 뒤에서부터 온다 거시서부터 2글자 따라서 n
from employees
where department_id = 100;

select  substr('901112-2234567' , 8, 1), -- 성별
		substr('901112-2234567' ,-7, 1), -- 성별 뒤에서 계산
        substr('901112-2234567' ,1, 2), -- 년도
        substr('901112-2234567' ,3, 2), -- 월
        substr('901112-2234567' ,5, 2) -- 일
from dual;

-- LPAD(str, len, padstr): str 문자열 왼쪽에 padstr 문자열을 추가하여, 전체 문자열의 길이가 len이 되도록 만듬
select  first_name,
		lpad(first_name, 10, '#*')
from employees;

-- TRIM(str) 공백 삭제
select  concat('|','          안녕하세요          ','|'),
		concat('|', trim('          안녕하세요          '),'|'),
        concat('|', ltrim('          안녕하세요          '),'|'),
        concat('|', rtrim('          안녕하세요          '),'|')
from dual;

-- REPLACE(str, from_str, to_str): str에서 from_str을 to_str로 변경
select first_name,
		replace(first_name, 'a', '*'),
        replace(first_name, substr(first_name, 2, 3), '***')
         
from employees
where department_id = 100;

-- 단일형 함수 >  날짜함수
select current_date(), curdate();

select current_time(), curtime();

select current_timestamp(), now();

-- ADDDATE() 또는 DATE_ADD(): 날짜 시간 더하기
-- SUBDATE() 또는 DATE_SUB(): 날짜 시간 빼기
select  adddate('2021-06-20 00:00:00', INTERVAL -1 YEAR), 
		adddate('2021-06-20 00:00:00', INTERVAL 1 MONTH), 
		adddate('2021-06-20 00:00:00', INTERVAL 1 WEEK), 
		adddate('2021-06-20 00:00:00', INTERVAL 1 DAY), 
		adddate('2021-06-20 00:00:00', INTERVAL 1 HOUR), 
		adddate('2021-06-20 00:00:00', INTERVAL 1 MINUTE), 
		adddate('2021-06-20 00:00:00', INTERVAL 1 SECOND)
; -- 음수로 넣으면 빼기 효과 subdate()

-- DATEDIFF(): 두 날짜간 일수차 TIMEDIFF(): 두 날짜시간 간 시간차
select  datediff('2021-06-21 01:05:05', '2021-06-21 01:00:00'),
		timediff('2021-06-21 01:05:05', '2021-06-20 01:00:00')
from dual;

--  날짜/시간함수
select  first_name,
		hire_date,
        round(datediff(now(), hire_date)/365, 1) workday -- 근무기간 확인방법
		-- now()-hire_date
from employees
order by workday desc;

-- 변환 함수
-- DATE_FORMAT(date, format): date를 format형식으로 변환

select now(),
		date_format(now(), '%y.%m.%d %H:%i:%s'),
        date_format(now(), '%Y-%m-%d(%a) %H:%i:%s %p')
from dual;

-- STR_TO_DATE(str, format): str를 format형식으로 변환
select datediff('2021-06-04', '2021-06-01')
from dual;
select str_to_date('2021-Jun-04', '%Y-%b-%d')
from dual;
select str_to_date('2021-06-01', '%Y-%m-%d')
from dual;
select datediff(str_to_date('2021-Jun-04', '%Y-%b-%d'), str_to_date('2021-06-01', '%Y-%m-%d'))
from dual;

-- FORMAT(숫자, p): 숫자에 콤마(,) 를 추가, 소수점 p자리까지 출력

SELECT  format(1234567.89, 2),
		format(1234567.89, 0),
		format(1234567.89, -5)
from dual;

-- IFNULL(컬럼명, null일때값): 컬럼의 값이 null일때 정해진값을 출력

select first_name, ifnull(commission_pct, 0)
from employees;

select commission_pct, ifnull(commission_pct, "없음")
from employees;

/*문제 1. 
전체직원의 다음 정보를 조회하세요. 정렬은 입사일(hire_date)의 올림차순(ASC)으로 가장 선
임부터 출력이 되도록 하세요. 이름(first_name last_name), 월급(salary), 전화번호
(phone_number), 입사일(hire_date) 순서이고 "이름", "월급", "전화번호", "입사일" 로 컬럼
이름을 대체해 보세요. 입사일이 같으면 abc순(오름차순)으로 출력합니다.*/

select concat(first_name,' ', last_name) 이름,
		salary 월급,
        phone_number 전화번호,
        hire_date 입사일
from employees
order by hire_date asc, 이름 asc
;


/*문제2.
업무(jobs)별로 업무이름(job_title)과 최고월급(max_salary)을 월급의 내림차순(DESC)로 정렬
하세요.*/

select  employee_id,
		max(salary) 
from employees; 
		

/*문제3.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 이름, 매니저
아이디, 커미션 비율, 월급을 월급이 많은사람부터 출력하세요.*/

select  employee_id 이름,
		manager_id 아이디,
        commission_pct 커미션,
        salary 월급
from employees
where commission_pct is null
and salary > 3000
order by salary desc
;


/*문제4.
최고월급(max_salary)이 10000 이상인 업무의 이름(job_title)과 최고월급(max_salary)을 최
고월급의(max_salary) 내림차순(DESC)로 정렬하여 출력하세요. */
select max(salary) 
from employees
where max(salary) >= 10000
order by max(salary) desc
;

 
/*문제5.
월급이 14000 미만 10000 이상인 직원의 이름(first_name), 월급, 커미션퍼센트 를 월급순
(내림차순) 출력하세오. 단 커미션퍼센트 가 null 이면 0 으로 나타내시오.*/

select  first_name,
		salary,
        commission_pct, ifnull(commission_pct, '0')
from employees
where salary >= 10000
and salary < 14000
order by salary desc
;
/*문제6.
부서번호가 10, 90, 100 인 직원의 이름, 월급, 입사일, 부서번호를 나타내시오
입사일은 1977-12 와 같이 표시하시오*/
select  first_name,
		salary,
        hire_date,
        department_id
from employees
where department_id in(10,90,100)
-- REPLACE(str, from_str, to_str): str에서 from_str을 to_str로 변경
;

/*문제7.
이름(first_name)에 S 또는 s 가 들어가는 직원의 이름, 월급을 나타내시오*/

select  first_name,
		salary
from employees
where first_name like 'S%' or 's%'
;
/*문제8.
전체 부서를 출력하려고 합니다. 순서는 부서이름이 긴 순서대로 출력해 보세오.*/
select department_id
-- char_length
from employees;

/*문제9.
정확하지 않지만, 지사가 있을 것으로 예상되는 나라들을 나라이름을 대문자로 출력하고
올림차순(ASC)으로 정렬해 보세오.*/
select *
from employees;
/*문제10.
입사일이 03/12/31 일 이전 입사한 직원의 이름, 월급, 전화 번호, 입사일을 출력하세요
전화번호는 545-343-3433 과 같은 형태로 출력하시오.*/
select  first_name,
		salary,
        phone_number,
        hire_date
from employees
where hire_date <= 03/12/31
;
-- where hire_date >= '2007-01-01';

