-- creating database 
CREATE DATABASE "UniversityDB";

-- creating nessary tables
CREATE TABLE "department" (
    dept_name VARCHAR(60) PRIMARY KEY, 
    building VARCHAR(60) NOT NULL,
    budget BIGINT CHECK (budget >= 0) DEFAULT 0
);

CREATE TABLE "course" (
    course_code VARCHAR(10) PRIMARY KEY,
    title VARCHAR(60) UNIQUE NOT NULL,
    dept_name VARCHAR(60) NOT NULL REFERENCES department(dept_name),
    credit INT CHECK (credit >= 0) NOT NULL 
);

CREATE TABLE "instructor" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    dept_name VARCHAR(60) NOT NULL REFERENCES department(dept_name),
    salary BIGINT CHECK (salary > 0) DEFAULT 0
);

CREATE TABLE "section" (
    id SERIAL PRIMARY KEY,
    course_code VARCHAR(60) NOT NULL REFERENCES course(course_code),
    semester INT NOT NULL,
    year INT NOT NULL,
    building VARCHAR(60) NOT NULL,
    room_number VARCHAR(10) NOT NULL,
    time_slot TIME NOT NULL
);

CREATE TABLE "teaches" (
    instructor_id BIGINT NOT NULL REFERENCES instructor(id),
    course_code VARCHAR(60) NOT NULL REFERENCES course(course_code),
    section_id BIGINT NOT NULL REFERENCES section(id)
);

CREATE TABLE "student" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(60) NOT NULL,
    dept_name VARCHAR(60) NOT NULL REFERENCES department(dept_name)
);

CREATE TABLE "takes" (
    student_id BIGINT NOT NULL REFERENCES student(id),
    course_code VARCHAR(60) NOT NULL REFERENCES course(course_code),
    section_id BIGINT NOT NULL REFERENCES section(id),
    grade FLOAT CHECK(grade >= 0 AND grade <= 4 OR grade = NULL)
);

-- Inserting data
INSERT INTO "department" (
	dept_name, building, budget
) VALUES (
	'CSE', 'South', 100000
), (
	'English', 'South', 100000
), (
	'EEE', 'South', 100000
), (
	'BBA', 'South', 100000
), (
	'LAW', 'South', 100000
);

INSERT INTO "course" (
	course_code, title, dept_name, credit
) VALUES (
	'CSE-2421', 'Computer Algorithms', 'CSE', 3
), (
	'CSE-2422', 'Computer Algorithms Lab', 'CSE', 1
), (
	'CSE-2423', 'Database Management Systems', 'CSE', 3
), (
	'CSE-2424', 'Database Management Systems Lab', 'CSE', 2
), (
	'CSE-2425', 'Theory of Computing', 'CSE', 2
), (
	'CSE-2430', 'Competitive Programming II', 'CSE', 1
), (
	'MATH-2407', 'Mathematics IV', 'CSE', 3
), (
	'ME-2412', 'Engineering Drawing Lab', 'CSE', 1
), (
	'GEBL-2401', 'Bangla Language and Literature', 'CSE', 2
), (
	'ACC-2401', 'Financial and Management Accounting', 'CSE', 2
);

INSERT INTO "instructor" (
	id, name, dept_name, salary
) VALUES (
	1, 'Tanvir Ahsan', 'CSE', 100000
), (
	2, 'Nayeem Mahmud', 'CSE', 100000
), (
	3, 'Akash', 'CSE', 100000
), (
	4, 'Shafiullah', 'CSE', 100000
), (
	5, 'Fahim', 'CSE', 100000
), (
	6, 'Dr. Mohammad Razaul Karim', 'CSE', 100000
), (
	7, 'Yeasin Arafat', 'CSE', 100000
), (
	8, 'Jawad Awal', 'CSE', 100000
), (
	9, 'Jamil As-Sad', 'CSE', 100000
), (
	10, 'Amir Khan', 'English', 100000
), (
	11, 'Sulaiman Ali', 'English', 100000
), (
	12, 'Abbas Ullah', 'English', 100000
), (
	13, 'Jaber Hossain', 'English', 100000
);

INSERT INTO "section" (
	id, course_code, semester, year, building, room_number, time_slot
) VALUES (
	1, 'CSE-2421', 4, 2023, 'CSE', 'C-105', '11:40:00'
), (
	2, 'CSE-2422', 4, 2023, 'CSE', 'C-104', '12:30:00'
), (
	3, 'CSE-2423', 4, 2023, 'CSE', 'C-103', '14:00:00'
), (
	4, 'CSE-2424', 4, 2023, 'CSE', 'C-102', '14:40:00'
), (
	5, 'ME-2412', 4, 2023, 'CSE', 'C-205', '15:20:00'
), (
	6, 'MATH-2407', 4, 2023, 'CSE', 'C-204', '16:00:00'
);

INSERT INTO "teaches" (
	instructor_id, course_code, section_id
) VALUES (
	2, 'CSE-2430', 5
), (
	3, 'CSE-2423', 3
), (
	3, 'CSE-2424', 4
), (
	4, 'CSE-2421', 1
), (
	5, 'ME-2412', 5
);

INSERT INTO "student" (
	id, name, dept_name
) VALUES (
	1, 'Mohammad Sayem', 'CSE'
), (
	2, 'Mohammad Rayhan Uddain', 'CSE'
), (
	3, 'Mamun Mahmud', 'CSE'
), (
	4, 'Mohammad Faisal Fardin Choudhury', 'CSE'
), (
	5, 'Faisal Haque Rifat', 'CSE'
), (
	6, 'Parba Das', 'CSE'
), (
	7, 'MD. Jobayer Hossain Arafat', 'CSE'
);

INSERT INTO "takes" (
	student_id, course_code, section_id, grade
) VALUES (
	1, 'CSE-2421', 1, 3.00
), (
	2, 'CSE-2421', 1, 4.00
), (
	3, 'CSE-2421', 1, 4.00
), (
	4, 'CSE-2421', 1, 4.00
), (
	5, 'CSE-2421', 1, 4.00
), (
	6, 'CSE-2421', 1, 4.00
), (
	7, 'CSE-2421', 1, 4.00
), (
	1, 'CSE-2422', 2, 3.00
), (
	2, 'CSE-2422', 2, 4.00
), (
	3, 'CSE-2422', 2, 4.00
), (
	4, 'CSE-2422', 2, 4.00
), (
	5, 'CSE-2422', 2, 4.00
), (
	6, 'CSE-2422', 2, 4.00
), (
	7, 'CSE-2422', 2, 4.00
);

-- 1. Show all department
SELECT * FROM "department";

-- 2. Show all courses except credits equal 3
SELECT * FROM "course"
WHERE credit != 3;

-- 3. Show all students order by ascending according to id
SELECT * FROM "student"
ORDER BY id ASC;

-- 4. Count the courses according to credits
SELECT "credit", COUNT("course_code") AS "courses" FROM "course"
GROUP BY "credit";

-- 5. Count the instructor according to department
SELECT "dept_name", COUNT("id") AS "instructors" FROM "instructor"
GROUP BY "dept_name"
-- or
SELECT "department".dept_name, COUNT("instructor".name) as "instructors" FROM "instructor"
INNER JOIN "department" ON "instructor".dept_name = "department".dept_name
GROUP BY "department".dept_name;

-- 6. Print student name, course name, section_id of a specific student
SELECT "name", "title" as "course_name", "section_id" FROM "takes"
INNER JOIN "student" ON "id" = "student_id"
INNER JOIN "course" ON "takes".course_code = "course".course_code
WHERE "student_id" = 1;

-- 7. Show the all sections which are appointed to a specific course
SELECT * FROM "section" WHERE "course_code" = 'CSE-2422';