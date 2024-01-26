-- 작가 테이블 만들기
create table author (
	author_id   int			 primary key, -- not null + unique
    author_name varchar(100) not null,
    author_desc varchar(500) 
    );
    
-- 책 테이블 만들기
create table book (
	book_id int primary key,
    title varchar(100) not null,
    pubs varchar(100),
    pub_date datetime,
    author_id int,
	constraint book_fk foreign key(author_id)
    references author(author_id)
    );
    
-- 작가 등록
-- 묵시적 방법
insert into author 
values(1, '박경리', '토지 작가');

select *
from author;

-- 명시적 방법
insert into author(author_id, author_name)
values(2, '이문열');

insert into author(author_name, author_id )
values('이문열', 3 );

insert into author(author_id, author_name)
values(2,'정우성'); -- 2번값 이미 있는데 왜 또 넣냐고 에러줌
					# author_id primary key, -- not null + unique
		
insert into author(author_id, author_name)
values (4, '이문열');

insert into author(author_name)
values('박명수');

insert into author
values(5,'김종국', null);

-- ---------------------------
#조건을 만족하는 레코드를 변경
-- 컬럼 이름, 순서 지정하지 않음. 
-- 테이블 생성시 정의한 순서에 따라 값 지정
-- ----------------------------
-- 작가 수정
update author 
set author_name = '기안84', 
	author_desc = '웹툰작가'
where author_id = 3
;

update author
set author_desc = '영화배우'
where author_id = 4
;

-- 작가 삭제
delete from author
where author_id = 5
;

select *
from author;

select *
from book;

insert into book
values(1, '우리들의', '다림', '1998-02-02', 2);

insert into book
values(2, '삼국지', '민음사', '2002-03-01', 2);

insert into book
values(3,'토지', '마로니에북스', '2012-08-15', 1);

insert into book
values(4,'오직두사람', '문학동네', '2017-05-04', 6); -- 6번 없는데 나중에 어떻게 넣냐고.. 따라서 데이터도 넣는 순서가 있다.

select  b.title,
		b.pubs,
        b.pub_date,
        a.author_name,
        a.author_desc
from book b, author a
where b.author_id = a.author_id
;

drop table author;
drop table book; -- book 먼저 지우면 author 지워짐. 순서 이해 필요. 작가는 아무도 사용하지 않으면 지울 수 있음.

-- 작가 테이블 auto_increment
create table author(
author_id int auto_increment primary key,
author_name varchar(100) not null,
author_desc varchar(500)
);

insert into author(author_name, author_desc)
values('이문열', '경북 양양');

insert into author(author_name, author_desc)
values('박경리', '경상남도 통영');

insert into author
values(null, '유시민', '17대 국회의원');

select*
from author; -- run 실행 순서에 따라서 표 열거순서가 달라지기도 한다. 중복도 됨.

