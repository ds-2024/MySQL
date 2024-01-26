create user 'webdb'@'%' identified by '1234';

alter user 'webdb'@'%' identified by 'webdb';

grant all privileges on web_db.* to 'webdb'@'%';

drop user 'webdb'@'%';

flush privileges;

create database web_db
default character set utf8mb4
collate utf8mb4_general_ci
default encryption='n'
;

show databases;

drop database web_db;

show databases;

create user 'bookbook'@'%' identified by '1234';

alter user 'bookbook'@'%' identified by 'book';

grant all privileges on book_db.* to 'bookbook'@'%';