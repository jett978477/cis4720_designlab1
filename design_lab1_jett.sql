/* ==========================================================================
   design_lab1_starter.sql
   CIS 4720 Database Management and SQL
   Design Lab 1, From a Spreadsheet to Tables

   WHAT THIS FILE IS
   The campus tutoring center keeps its records in a spreadsheet. This file
   loads that spreadsheet into a table called tutoring_sheet, exactly as the
   center keeps it, and has a numbered heading for every step of the lab.

   HOW TO RUN IT
   One statement at a time. Put the cursor on it and press Ctrl + E twice.

   LABELING AND COMMENTING IS REQUIRED
   Above every statement you write, put a short comment in your own words
   saying what it does. Some steps also ask you to answer a question in a
   comment. The comments are graded.
   ========================================================================== */


-- =================================================================
-- SETUP. Run these three first, one at a time, while you are still
-- connected to information_schema.
-- =================================================================

-- every schema on this server. tutoring_db will not be in the list yet.
show databases;

-- make yours. IF NOT EXISTS means it is safe to run twice.
create database if not exists tutoring_db;

-- switch into it, so everything below lands in the right place.
use tutoring_db;


-- ======================================================================
-- THE SPREADSHEET. One row per tutoring session. Look at the students
-- column: every student who came is crammed into one cell.
-- ======================================================================

CREATE TABLE tutoring_sheet (
    session_id   INT,
    session_date DATE,
    room         VARCHAR(10),
    tutor_id     INT,
    tutor_name   VARCHAR(40),
    tutor_email  VARCHAR(60),
    course_code  VARCHAR(10),
    course_title VARCHAR(40),
    students     VARCHAR(200)
);
INSERT INTO tutoring_sheet VALUES (101, '2026-09-08', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', '1001 Ana Lopez (CIS), 1003 Chloe Nguyen (CIS)');
INSERT INTO tutoring_sheet VALUES (102, '2026-09-08', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', '1002 Ben Ortiz (Accounting)');
INSERT INTO tutoring_sheet VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', '1001 Ana Lopez (CIS), 1004 Dev Patel (Biology), 1005 Elena Ruiz (Undeclared)');
INSERT INTO tutoring_sheet VALUES (104, '2026-09-15', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', '1002 Ben Ortiz (Accounting), 1005 Elena Ruiz (Undeclared)');
INSERT INTO tutoring_sheet VALUES (105, '2026-09-17', 'LIB 110', 503, 'Priya Shah', 'priya.shah@tutor.edu', 'CIS 2000', 'Information Systems', '1003 Chloe Nguyen (CIS), 1004 Dev Patel (Biology)');
INSERT INTO tutoring_sheet VALUES (106, '2026-09-22', 'LIB 114', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', '1001 Ana Lopez (CIS)');

-- CHECK. Six rows, sessions 101 to 106.
SELECT * FROM tutoring_sheet;


-- ######################################################################
-- YOUR DESIGN LAB 1 WORK STARTS BELOW THIS LINE
--
-- LABELING AND COMMENTING IS REQUIRED. It is worth a full point.
-- ######################################################################


-- =================================================================
-- STEP 3. Ask the spreadsheet two questions
--
-- Copy the queries from the handout. Answer the question in a comment.
-- =================================================================

-- how many sessions did Ana come to? search inside the text
SELECT COUNT(*) FROM tutoring_sheet WHERE students LIKE '%Ana Lopez%';
-- how many student visits were there in total?
SELECT COUNT(*) FROM tutoring_sheet;

-- why can COUNT not see the students?
--the students column holds a list, so 
--the database sees one value per row, not one value per student. That is what 1NF forbids.
-- =================================================================
-- STEP 4. First normal form, one value per cell
--
-- Write the CREATE TABLE. Then run the DATA FOR STEP 4 block below it.
-- =================================================================
--creating tutoring_1nf table with a composite primary key. 
create table tutoring_1nf (
    session_id    int not null,
    session_date  date,
    room          varchar(10),
    tutor_id      int,
    tutor_name    varchar(40),
    tutor_email   varchar(60),
    course_code   varchar(10),
    course_title  varchar(40),
    student_id    int not null,
    student_name  varchar(40),
    student_major varchar(30),
    rating        int,
    primary key (session_id, student_id)
);

-- ----------------------------------------------------------------------
-- DATA FOR STEP 4. Run these eleven INSERTs AFTER your CREATE TABLE for
-- tutoring_1nf. They only work if your columns are in the same order as
-- the table in the handout. One row per student per session.
-- ----------------------------------------------------------------------

INSERT INTO tutoring_1nf VALUES (101, '2026-09-08', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', 1001, 'Ana Lopez', 'CIS', 5);
INSERT INTO tutoring_1nf VALUES (101, '2026-09-08', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', 1003, 'Chloe Nguyen', 'CIS', 4);
INSERT INTO tutoring_1nf VALUES (102, '2026-09-08', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', 1002, 'Ben Ortiz', 'Accounting', 3);
INSERT INTO tutoring_1nf VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', 1001, 'Ana Lopez', 'CIS', 4);
INSERT INTO tutoring_1nf VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', 1004, 'Dev Patel', 'Biology', 5);
INSERT INTO tutoring_1nf VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', 1005, 'Elena Ruiz', 'Undeclared', 2);
INSERT INTO tutoring_1nf VALUES (104, '2026-09-15', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', 1002, 'Ben Ortiz', 'Accounting', 4);
INSERT INTO tutoring_1nf VALUES (104, '2026-09-15', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', 1005, 'Elena Ruiz', 'Undeclared', 3);
INSERT INTO tutoring_1nf VALUES (105, '2026-09-17', 'LIB 110', 503, 'Priya Shah', 'priya.shah@tutor.edu', 'CIS 2000', 'Information Systems', 1003, 'Chloe Nguyen', 'CIS', 5);
INSERT INTO tutoring_1nf VALUES (105, '2026-09-17', 'LIB 110', 503, 'Priya Shah', 'priya.shah@tutor.edu', 'CIS 2000', 'Information Systems', 1004, 'Dev Patel', 'Biology', 4);
INSERT INTO tutoring_1nf VALUES (106, '2026-09-22', 'LIB 114', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', 1001, 'Ana Lopez', 'CIS', 5);



-- =================================================================
-- STEP 5. Make a copy to break
-- =================================================================

--creating a copy of tutoring_1nf for testingg
create table anomaly_copy as select * from tutoring_1nf;

--testing the row count
select count(*) from anomaly_copy;
-- =================================================================
-- STEP 6. The update problem
--
-- Copy the UPDATE from the handout. Answer the question in a comment.
-- =================================================================

update anomaly_copy
set tutor_email = 'maya.chen@campus.edu'
where session_id = 101;

---checking the email in the db
select distinct tutor_id, tutor_name, tutor_email
from anomaly_copy
where tutor_id = 501;

-- =================================================================
-- STEP 7. The insert problem
--
-- Write the INSERT. Copy the error into a comment.
-- =================================================================

-- inserting a new course without a session or student
insert into anomaly_copy (course_code, course_title) 
values ('CIS 4720', 'Database Management');

-- Error: Field 'session_id' doesn't have a default value


-- =================================================================
-- STEP 8. The delete problem
--
-- Write the DELETE and the check. Answer the question in a comment.
-- =================================================================

-- deleting all rows related to session 103
delete from anomaly_copy where session_id = 103;

-- checking remaining courses
select distinct course_code, course_title from anomaly_copy;

--what fact did you mean to delete, and what other fact went with it?
--meant to delete session 103 but it took math 1600 out with it.

-- =================================================================
-- STEP 9. Find the dependencies, and design third normal form
--
-- Answer in comments. Use the template in the handout.
-- =================================================================

-- your comment goes here
-- your statements go here


-- =================================================================
-- STEP 10. Build the five tables
--
-- Order matters: a table that is pointed at must exist first.
-- =================================================================

-- one row per student. student_id is the key
create table student (
    student_id    int primary key,
    student_name  varchar(40) not null,
    student_major varchar(30)
);

--tutor table
create table tutor (
    tutor_id    int primary key,
    tutor_name  varchar(40) not null,
    tutor_email varchar(60) unique
);

--course table
create table course (
    course_code  varchar(10) primary key,
    course_title varchar(40) not null
);

--session table
create table session (
    session_id   int primary key,
    session_date date not null,
    room         varchar(10),
    tutor_id     int not null,
    course_code  varchar(10) not null,
    foreign key (tutor_id) references tutor (tutor_id),
    foreign key (course_code) references course (course_code)
);

--attendance table
create table attendance (
    session_id int not null,
    student_id int not null,
    rating     int,
    primary key (session_id, student_id),
    foreign key (session_id) references session (session_id),
    foreign key (student_id) references student (student_id)
);



-- =================================================================
-- STEP 11. Load the five tables from tutoring_1nf
-- =================================================================


-- one row per student, taken from the 1NF table
insert into student (student_id, student_name, student_major)
select distinct student_id, student_name, student_major
from tutoring_1nf;

--loading tutor
insert into tutor (tutor_id, tutor_name, tutor_email)
select distinct tutor_id, tutor_name, tutor_email
from tutoring_1nf;

--loading course
insert into course (course_code, course_title)
select distinct course_code, course_title
from tutoring_1nf;
--loading session
insert into session (session_id, session_date, room, tutor_id, course_code)
select distinct session_id, session_date, room, tutor_id, course_code
from tutoring_1nf;

--loading attendance
insert into attendance (session_id, student_id, rating)
select session_id, student_id, rating
from tutoring_1nf;


-- =================================================================
-- STEP 12. Put the spreadsheet back together
--
-- Copy the view and the check from the handout.
-- =================================================================


-- the five tables joined back into the 1NF shape
create view tutoring_rebuilt as
select se.session_id, se.session_date, se.room,
       t.tutor_id, t.tutor_name, t.tutor_email,
       c.course_code, c.course_title,
       st.student_id, st.student_name, st.student_major,
       a.rating
from attendance a
join session se on a.session_id = se.session_id
join tutor t on se.tutor_id = t.tutor_id
join course c on se.course_code = c.course_code
join student st on a.student_id = st.student_id;

-- how many rows match tutoring_1nf on every column? It should return 11,
-- which shows the split was lossless and nothing was lost.
select count(*)
from tutoring_1nf o
join tutoring_rebuilt r
  on o.session_id = r.session_id and o.student_id = r.student_id
where o.session_date = r.session_date and o.room = r.room
  and o.tutor_email = r.tutor_email and o.course_title = r.course_title
  and o.student_name = r.student_name and o.student_major = r.student_major
  and o.rating = r.rating;



-- =================================================================
-- STEP 13. Show the three problems are gone
-- =================================================================
-- fixing the update error
update tutor 
set tutor_email = 'maya.chen@campus.edu' 
where tutor_id = 501;

select distinct tutor_email 
from tutoring_rebuilt 
where tutor_id = 501;
-- the email is stored in one place so if you update it, it will update it everywhere

-- insert issue fix: insert a course without needing a session
insert into course (course_code, course_title) 
values ('CIS 4720', 'Database Management');
--courses have their own table seprate from sessions.

-- =================================================================
-- STEP 14 and 15. Push to GitHub and submit the URL
--
-- Nothing to write here. Follow the handout.
-- =================================================================

-- your comment goes here
-- your statements go here
