CREATE TABLE department(
    department_dept_name VARCHAR(50) PRIMARY KEY,
    department_building VARCHAR(50),
    department_budget NUMERIC(14,2)
);
CREATE TABLE course(
    course_id VARCHAR(10) PRIMARY KEY,
    course_title VARCHAR(100),
    course_dept_name VARCHAR(50) REFERENCES department(department_dept_name),
    course_credits INTEGER
);
CREATE TABLE instructor(
    instructor_ID VARCHAR(20) PRIMARY KEY,
    instructor_name VARCHAR(100),
    instructor_dept_name VARCHAR(50) REFERENCES department(department_dept_name),
    instructor_salary NUMERIC(10, 2)
);
CREATE TABLE _section(
    section_course_id VARCHAR(10) REFERENCES course(course_id),
    section_id INTEGER,
    section_semester VARCHAR(10),
    section_year INTEGER,
    section_building VARCHAR(50),
    section_room_number VARCHAR(10),
    section_time_slot_id INTEGER,
    PRIMARY KEY(section_course_id,section_id,section_semester,section_year)
);
CREATE TABLE teaches(
    teaches_ID VARCHAR(20) REFERENCES instructor(instructor_ID),
    teaches_course_id VARCHAR(10),
    teaches_sec_id INTEGER,
    teaches_semester VARCHAR(10),
    teaches_year INTEGER,
    PRIMARY KEY(teaches_ID,teaches_course_id,teaches_sec_id,teaches_semester,teaches_year)
);
CREATE TABLE student(
    student_ID VARCHAR(20) PRIMARY KEY,
    student_name VARCHAR(100),
    student_dept_name VARCHAR(50) REFERENCES department(department_dept_name),
    student_tot_cred INTEGER
);
CREATE TABLE takes(
    takes_ID VARCHAR(20) REFERENCES student(student_ID),
    takes_course_id VARCHAR(10),
    takes_sec_id INTEGER,
    takes_semester VARCHAR(10),
    takes_year INTEGER,
    takes_grade VARCHAR(2),
    PRIMARY KEY(takes_ID,takes_course_id,takes_sec_id,takes_semester,takes_year)
);

INSERT INTO department(department_dept_name,department_building,department_budget)
VALUES
    ('CSE', 'CSE Building', 1500000.00),
    ('Pharmacy', 'Pharmacy Building', 2000000.00);
	
INSERT INTO course(course_id,course_title,course_dept_name,course_credits)
VALUES
    ('CSE-1121','Computer Programming I','CSE', 3),
    ('PHAR-2107','Organic Chemistry','Pharmacy', 3),
    ('CSE-2423','Database Management Systems','CSE', 3),
    ('CSE-2424','Database Management Systems Lab','CSE', 1);
	
INSERT INTO instructor(instructor_ID,instructor_name,instructor_dept_name,instructor_salary)
VALUES
    ('C172051', 'Nayeem Mahmood', 'CSE', 60000.00),
    ('P152100', 'Dr. Abdur Rashid', 'Pharmacy', 70000.00);
	
INSERT INTO _section(section_course_id,section_id,section_semester,section_year,section_building,section_room_number,section_time_slot_id)
VALUES
    ('CSE-1121', 1, 'Spring', 2023,'CSE Building','102', 1),
    ('PHAR-2107', 1, 'Spring', 2023,'Pharmacy Building','102', 2),
    ('CSE-2423', 2, 'Spring', 2023,'CSE Building','502', 2),
    ('CSE-2424', 2, 'Spring', 2023,'CSE Building','101', 4);
	
INSERT INTO teaches(teaches_ID,teaches_course_id,teaches_sec_id,teaches_semester,teaches_year)
VALUES
    ('C172051', 'CSE-1121', 1, 'Spring', 2023),
    ('P152100', 'PHAR-2407', 1, 'Spring', 2023),
    ('C172051', 'CSE-2423', 2, 'Spring', 2023);
	
INSERT INTO student(student_ID,student_name,student_dept_name,student_tot_cred)
VALUES
    ('C221051','Nahian Nazeeb','CSE', 65),
    ('C213090','Ashraf Ali','CSE', 94),
    ('P221015','Mehedi Hasan','Pharmacy', 68);
	
INSERT INTO takes(takes_ID,takes_course_id,takes_sec_id,takes_semester,takes_year,takes_grade)
VALUES
    ('C221051', 'CSE-2423', 2, 'Spring', 2023, 'A+'),
    ('C213090', 'CSE-1121', 1, 'Spring', 2023, 'A'),
    ('P221015', 'PHAR-2107', 1, 'Spring', 2023, 'A+');
	
-- 1
SELECT * FROM department;
-- 2
SELECT * FROM course WHERE course_credits <> 3;
-- 3
SELECT * FROM student ORDER BY student_ID ASC;
-- 4
SELECT course_credits, COUNT(*) AS course_count FROM course GROUP BY course_credits; 
-- 5
SELECT instructor_dept_name, COUNT(*) AS instructor_count FROM instructor GROUP BY instructor_dept_name;
-- 6
SELECT sn.student_name , cn.course_title , si.section_id
	FROM student sn
		JOIN takes t ON sn.student_ID = t.takes_ID
		JOIN _section si ON t.takes_course_id = si.section_course_id AND t.takes_sec_id = si.section_id AND t.takes_semester = si.section_semester AND t.takes_year = si.section_year
		JOIN course cn ON t.takes_course_id = cn.course_id
	WHERE sn.student_ID = 'C221051';
-- 7
SELECT * FROM _section WHERE section_course_id = 'CSE-2423';