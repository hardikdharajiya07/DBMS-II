INSERT INTO COURSE (CourseID,CourseName,CourseCredits,CourseDepartment,CourseSemester)
VALUES
('CS101','Programming Fundamentals',4,'CSE',1),
('CS201','Data Structures',4,'CSE',3),
('CS301','Database Management Systems',4,'CSE',5),
('IT101','Web Technologies',3,'IT',1),
('IT201','Software Engineering',4,'IT',3),
('EC101','Digital Electronics',3,'ECE',1),
('EC201','Microprocessors',4,'ECE',3),
('ME101','Engineering Mechanics',4,'MECH',1),
('CS202','Operating Systems',4,'CSE',4),
('CS302','Artificial Intelligence',3,'CSE',6);

SELECT * FROM COURSE

INSERT INTO FACULTY (FacultyID,FacultyName,FacultyEmail,FacultyDepartment,FacultyDesignation,FacultyJoiningDate)
VALUES
(101,'Dr. Sheth','Sheth@univ.edu','CSE','Professor','2010-07-15'),
(102,'Prof. Gupta','gupta@univ.edu','IT','Associate Prof','2012-08-20'),
(103,'Dr. Patel','patel@univ.edu','CSE','Assistant Prof','2015-06-10'),
(104,'Dr. Singh','singh@univ.edu','ECE','Professor','2008-03-25'),
(105,'Prof. Reddy','reddy@univ.edu','IT','Assistant Prof','2018-01-15'),
(106,'Dr. Iyer','iyer@univ.edu','MECH','Associate Prof','2013-09-05'),
(107,'Prof. Nair','nair@univ.edu','CSE','Assistant Prof','2019-07-20');

SELECT * FROM FACULTY

INSERT INTO ENROLLMENT (StudentID,CourseID,EnrollmentDate,Grade,EnrollmentStatus)
VALUES
(1,'CS101','2021-07-01','A','Completed'),
(1,'CS201','2022-01-05','B+','Completed'),
(1,'CS301','2023-07-01',NULL,'Active'),
(2,'IT101','2020-07-01','A','Completed'),
(2,'IT201','2021-07-01','A-','Completed'),
(3,'CS101','2021-07-01','B','Completed'),
(3,'CS201','2022-01-05','A','Completed'),
(4,'EC101','2022-07-01','B+','Completed'),
(5,'IT101','2021-07-01','A','Completed'),
(6,'CS201','2021-01-05','A','Completed'),
(1,'CS302','2023-07-01',NULL,'Active'),
(2,'IT201','2022-01-05',NULL,'Dropped');

SELECT * FROM ENROLLMENT

INSERT INTO COURSE_ASSIGNMENT (CourseID,FacultyID,Semester,Year,ClassRoom)
VALUES
('CS101',103,1,2024,'A-301'),
('CS201',101,3,2024,'B-205'),
('CS301',101,5,2024,'A-401'),
('IT101',102,1,2024,'C-102'),
('IT201',105,3,2024,'C-205'),
('EC101',104,1,2024,'D-101'),
('EC201',104,3,2024,'D-203'),
('ME101',106,1,2024,'E-101'),
('CS202',107,4,2024,'A-305'),
('CS302',101,6,2024,'B-401');

SELECT * FROM COURSE_ASSIGNMENT

select * from STUDENT


---Part – A 
---1.	Retrieve all unique departments from the STUDENT table.
		
		SELECT DISTINCT StuDepartment
		FROM STUDENT
		
---2.	Insert a new student record into the STUDENT table.
---(9, 'Neha Singh', 'neha.singh@univ.edu', '9876543218', 'IT', '2003-09-20', 2021)

		insert into STUDENT (StudentID,StuName,StuEmail,StuPhone,StuDepartment,StuDateOfBirth,StuEnrollmentYear)values (9, 'Neha Singh', 'neha.singh@univ.edu', '9876543218', 'IT', '2003-09-20', 2021)
		select * from STUDENT
---3.	Change the Email of student 'Raj Patel' to 'raj.p@univ.edu'. (STUDENT table)
		update STUDENT
		set StuEmail ='raj.p@univ.edu'
		where StuName='Raj Patel'
		select * from STUDENT

---4.	Add a new column 'CGPA' with datatype DECIMAL(3,2) to the STUDENT table.
		alter table student
		add CGPA DECIMAL(3,2)

---5.	Retrieve all courses whose CourseName starts with 'Data'. (COURSE table)
		SELECT CourseName
		FROM COURSE
		WHERE CourseName LIKE 'DATA%'
---6.	Retrieve all students whose Name contains 'Shah'. (STUDENT table)
		SELECT STUNAME
		FROM STUDENT
		WHERE STUNAME LIKE '%SHAH%'

		
---7.	Display all Faculty Names in UPPERCASE. (FACULTY table)
		SELECT FACULTYNAME
		FROM FACULTY
		
---8.	Find all faculty who joined after 2015. (FACULTY table)
		SELECT *
		FROM FACULTY
		WHERE FacultyJoiningDate >'2015'

---9.	Find the SQUARE ROOT of Credits for the course 'Database Management Systems'. (COURSE table)
	
		SELECT SQRT(CourseCredits) as creditroot
		from COURSE
		where CourseName='Database Management Systems'

---10.	Find the Current Date using SQL Server in-built function.
		select GETDATE() as curentdate
--11.	Find the top 3 students who enrolled earliest (by EnrollmentYear). (STUDENT table)

		select top 3 *
		from STUDENT
		order by StuEnrollmentYear asc
--12.	Find all enrollments that were made in the year 2022. (ENROLLMENT table)
		select * 
		from ENROLLMENT
		where year(EnrollmentDate)=2022

--13.	Find the number of courses offered by each department. (COURSE table)
		select CourseDepartment ,count(*) as total
		from COURSE
		group by CourseDepartment

		
--14.	Retrieve the CourseID which has more than 2 enrollments. (ENROLLMENT table)
		select COURSEID
		FROM ENROLLMENT
		GROUP BY COURSEID
		HAVING COUNT(*)>2
		
--15.	Retrieve all the student name with their enrollment status. (STUDENT & ENROLLMENT table)
		SELECT STUDENT.STUNAME,ENROLLMENT.EnrollmentStatus
		FROM STUDENT
		JOIN ENROLLMENT
		ON STUDENT.StudentID=ENROLLMENT.StudentID

--16.	Select all student names with their enrolled course names. (STUDENT, COURSE, ENROLLMENT table)
		SELECT STUDENT.STUNAME,COURSE.CourseName
		FROM STUDENT
		JOIN ENROLLMENT
		ON STUDENT.StudentID=ENROLLMENT.StudentID
		JOIN COURSE
		ON ENROLLMENT.CourseID=COURSE.CourseID


--17.	Create a view called 'ActiveEnrollments' showing only active enrollments with student name and  course name. (STUDENT, COURSE, ENROLLMENT,  table)
		CREATE VIEW ActiveEnrollments
		AS
		SELECT STUDENT.StuName,COURSE.CourseName
		FROM STUDENT
		JOIN ENROLLMENT
		ON STUDENT.StudentID= ENROLLMENT.StudentID
		JOIN COURSE
		ON ENROLLMENT.CourseID=COURSE.CourseID
		WHERE ENROLLMENT.EnrollmentStatus='ACTIVE'

		SELECT * FROM ACTIVEENROLLMENTS


--18.	Retrieve the student’s name who is not enrol in any course using subquery. (STUDENT, ENROLLMENT TABLE)
		SELECT STUDENT.StuName
		FROM STUDENT
		WHERE STUDENT.StudentID NOT IN (SELECT StudentID FROM ENROLLMENT)
--19.	Display course name having second highest credit. (COURSE table)
		SELECT COURSENAME
		FROM COURSE
		WHERE CourseCredits = (SELECT MAX(CourseCredits) FROM COURSE
		WHERE CourseCredits < (SELECT MAX(CourseCredits) FROM COURSE))
--Part – B 
--20.	Retrieve all courses along with the total number of students enrolled. (COURSE, ENROLLMENT table)
		SELECT 
		C.CourseID,
		C.CourseName,
		COUNT(E.StudentID) AS Total_Students
		FROM COURSE C
		LEFT JOIN ENROLLMENT E
		ON C.CourseID = E.CourseID
		GROUP BY C.CourseID, C.CourseName;

--21.	Retrieve the total number of enrollments for each status, showing only statuses that have more than 2 enrollments. (ENROLLMENT table)
		SELECT EnrollmentStatus,
			COUNT(*) AS Total_Enrollments
		FROM ENROLLMENT
		GROUP BY EnrollmentStatus
		HAVING COUNT(*) > 2;


--22.	Retrieve all courses taught by 'Dr. Sheth' and order them by Credits. (FACULTY, COURSE, COURSE_ASSIGNMENT table)

			SELECT 
				C.CourseID,
				C.CourseName,
				C.CourseCredits
			FROM COURSE C
			JOIN COURSE_ASSIGNMENT CA
			ON C.CourseID = CA.CourseID
			JOIN FACULTY F
			ON CA.FacultyID = F.FacultyID
			WHERE F.FacultyName = 'Dr. Sheth'
			ORDER BY C.CourseCredits;


--Lab-2	Stored Procedure

--PART A
--1.	INSERT Procedures: Create stored procedures to insert records into STUDENT tables (SP_INSERT_STUDENT)

		CREATE OR ALTER PROCEDURE PR_INSERT_STUDENT
			@StudentID	INT,
			@StuName	VARCHAR(100),
			@StuEmail	VARCHAR(100),
			@StuPhone	VARCHAR(15),
			@StuDepartment	VARCHAR(50),
			@StuDateOfBirth	DATE,
			@StuEnrollmentYear	INT
		AS
		BEGIN
				INSERT INTO STUDENT  (
        StudentID,StuName,StuEmail,StuPhone,StuDepartment,StuDateOfBirth,StuEnrollmentYear) VALUES(@StudentID,@StuName,@StuEmail,@StuPhone,@StuDepartment,@StuDateOfBirth,@StuEnrollmentYear)
		END
		EXEC PR_INSERT_STUDENT 10,'Harsh Parmar','harsh@univ.edu','9876543218','CSE','2005-09-18',2023
		EXEC PR_INSERT_STUDENT 20,'Om Patel','om@univ.edu','9876543211','IT','2002-08-22',2022
		SELECT * FROM STUDENT

--2.	INSERT Procedures: Create stored procedures to insert records into COURSE tables 
--(SP_INSERT_COURSE)
		CREATE OR ALTER PROCEDURE SP_INSERT_COURSE
			@CourseID	VARCHAR(10),
			@CourseName	VARCHAR(100),
			@Credits INT,
			@Dept	VARCHAR(100),
			@Semester INT
			AS
			BEGIN
				INSERT INTO COURSE VALUES(@CourseID,@CourseName,@Credits,@Dept,@Semester)
			END

			EXEC SP_INSERT_COURSE 'CS330','Computer Networks',4,'CSE',5

			EXEC SP_INSERT_COURSE 'EC120','Electronic Circuits',3,'ECE',2
			SELECT * FROM COURSE

--3.	UPDATE Procedures: Create stored procedure SP_UPDATE_STUDENT to update Email and Phone in STUDENT table. (Update using studentID)
		CREATE OR ALTER PROCEDURE SP_UPDATE_STUDENT
			@StudentID	INT,
			@StuEmail	VARCHAR(100),
			@StuPhone	VARCHAR(15)
		AS
		BEGIN
				UPDATE STUDENT
				SET StuEmail=@StuEmail,StuPhone=@StuPhone
				WHERE StudentID=@StudentID
		END
	EXEC SP_UPDATE_STUDENT 1,'hardik@gmail','1234567890'
	select * from student
--4.	DELETE Procedures: Create stored procedure SP_DELETE_STUDENT to delete records from STUDENT where Student Name is Om Patel.
		create or alter procedure sp_delete_student
		as
		begin
				delete from student
				where StuName='om patel'
		end
		exec sp_delete_student

--5.	SELECT BY PRIMARY KEY: Create stored procedures to select records by primary key (SP_SELECT_STUDENT_BY_ID) from Student table.
		CREATE OR ALTER PROCEDURE SP_SELECT_STUDENT_BY_ID
			@StudentID	INT
		AS
		BEGIN
				SELECT *
				FROM STUDENT
				WHERE StudentID=@StudentID
		END
	EXEC SP_SELECT_STUDENT_BY_ID 1
--6.	Create a stored procedure that shows details of the first 5 students ordered by EnrollmentYear.

		CREATE OR ALTER PROCEDURE SP_STUDENTS_ENROLLMENTYEAR
		AS
		BEGIN
			SELECT TOP 5 *
			FROM STUDENT
			ORDER BY StuEnrollmentYear;
		END	
		EXEC SP_STUDENTS_ENROLLMENTYEAR

--Part – B  
--7.	Create a stored procedure which displays faculty designation-wise count.
		CREATE OR ALTER PROCEDURE SP_FACYLTY_designation
		AS
		BEGIN 
				SELECT FacultyDesignation ,COUNT(*) AS DEDIGNATION_WISE
				from FACULTY
				GROUP BY FacultyDesignation
		end
		EXEC SP_FACYLTY_designation
--8.	Create a stored procedure that takes department name as input and returns all students in that department.
		CREATE OR ALTER PROCEDURE PR_ALL_STUDENT
		@StuDepatment varchar(50)
		AS
		BEGIN
				SELECT *
				FROM STUDENT
				WHERE StuDepartment = @StuDepatment
		END
		EXEC PR_ALL_STUDENT 'IT'
--Part – C 
--9.	Create a stored procedure which displays department-wise maximum, minimum, and average credits of courses.
		CREATE OR ALTER PROCEDURE PR_ALL_DISPLAY
		AS
		BEGIN
				SELECT STUDENT.StuDepartment,
				MIN(COURSE.CourseCredits) AS MIN_CREDIT,
				MAX(COURSE.CourseCredits) AS MAX_CREDIT,
				AVG(COURSE.CourseCredits) AS AVG_CREDIT
				FROM STUDENT
				JOIN ENROLLMENT
				ON STUDENT.StudentID=ENROLLMENT.StudentID
				JOIN COURSE
				ON ENROLLMENT.CourseID=COURSE.CourseID
				GROUP BY STUDENT.StuDepartment
		END
		EXEC PR_ALL_DISPLAY
--10.	Create a stored procedure that accepts StudentID as parameter and returns all courses the student is enrolled in with their grades.
		CREATE OR ALTER PROCEDURE SP_STUDENT_GRADE
		@StudentID INT
		AS
		BEGIN
			SELECT 
				C.CourseID,
				C.CourseName,
				E.GRADE
			FROM ENROLLMENT E
			JOIN COURSE C 
			ON E.CourseID = C.CourseID
			WHERE E.StudentID = @StudentID;
		END
		EXEC SP_STUDENT_GRADE 1


--Lab-3	Advanced Stored Procedure
--	Part – A 
--1.	Create a stored procedure that accepts a date and returns all faculty members who joined on that date.
		CREATE OR ALTER PROCEDURE PR_FACULTY
		@DATE DATE
		AS
		BEGIN
				SELECT *
				FROM FACULTY
				WHERE FacultyJoiningDate=@DATE
		END
		EXEC PR_FACULTY '2010-07-15'

--2.	Create a stored procedure for ENROLLMENT table where user enters either StudentID and returns EnrollmentID, EnrollmentDate, Grade, and Status.
		CREATE OR ALTER PROCEDURE PR_ENROLLMENT
		@STUID INT
		AS
		BEGIN
				SELECT E.ENROLLMENTID,E.EnrollmentDate,E.GRADE,E.EnrollmentStatus
				FROM ENROLLMENT E
				JOIN STUDENT S
				ON E.StudentID=S.StudentID
				WHERE S.StudentID=@STUID
		END
		EXEC PR_ENROLLMENT 1
		

--3.	Create a stored procedure that accepts two integers (min and max credits) and returns all courses whose credits fall between these values.
		CREATE OR ALTER PROCEDURE PR_ACCEPT_INT
		@MINCREDIT INT,
		@MAXCREDIT INT
		AS
		BEGIN
				SELECT CourseName,CourseCredits
				FROM COURSE
				WHERE CourseCredits BETWEEN @MINCREDIT AND @MAXCREDIT
		END
		EXEC PR_ACCEPT_INT 3,4


		

--4.	Create a stored procedure that accepts Course Name and returns the list of students enrolled in that course.
		CREATE OR ALTER PROCEDURE PR_ALL_STUDENT
		@COURSENAME VARCHAR(100)
		AS
		BEGIN 
				SELECT S.STUNAME,C.COURSENAME
				FROM STUDENT S
				JOIN ENROLLMENT E
				ON S.StudentID=E.StudentID
				JOIN COURSE C
				ON C.CourseID=E.CourseID
				WHERE C.CourseName=@COURSENAME
		END
		EXEC PR_ALL_STUDENT 'Web Technologies'
		
--5.	Create a stored procedure that accepts Faculty Name and returns all course assignments.
		CREATE OR ALTER PROCEDURE PR_COURSE_ASSIGNMENT
		@FacultyName VARCHAR(50)
		AS
		BEGIN
				SELECT C.COURSENAME,F.FACULTYNAME
				FROM COURSE C
				JOIN COURSE_ASSIGNMENT CA
				ON C.CourseID = CA.CourseID
				JOIN FACULTY F
				ON F.FacultyID = CA.FacultyID
				WHERE FacultyName=@FacultyName
		END
		EXEC PR_COURSE_ASSIGNMENT 'Dr. Singh'

--6.	Create a stored procedure that accepts Semester number and Year, and returns all course assignments with faculty and classroom details.
		CREATE OR ALTER PROCEDURE PR_ACC_SEM_YEAR
		@SEM INT,
		@YEAR INT
		AS
		BEGIN
				SELECT C.COURSENAME,F.FacultyName,CA.AssignmentID,CA.CLASSROOM
				FROM COURSE C
				JOIN COURSE_ASSIGNMENT CA
				ON C.CourseID = CA.CourseID
				JOIN FACULTY F
				ON F.FacultyID=CA.FacultyID
				WHERE CA.Semester=@SEM AND CA.Year=@YEAR
		END
		EXEC PR_ACC_SEM_YEAR 3,2024



--Part – B 
--7.	Create a stored procedure that accepts the first letter of Status ('A', 'C', 'D') and returns enrollment details.
		CREATE OR ALTER PROCEDURE PR_STATUS
		@LETTER VARCHAR(1)
		AS
		BEGIN 
				SELECT *
				FROM ENROLLMENT
				WHERE EnrollmentStatus LIKE @LETTER+'%'
		END
		EXEC PR_STATUS 'D'
			
--8.	Create a stored procedure that accepts either Student Name OR Department Name and returns student data accordingly.
		CREATE OR ALTER PROCEDURE PR_ACCORDINGIY
		@STUNAME VARCHAR(50)=NULL,
		@DEPTNAME VARCHAR(50)=NULL
		AS
		BEGIN 
				SELECT *
				FROM STUDENT
				WHERE StuName=@STUNAME OR StuDepartment=@DEPTNAME
		END
		EXEC PR_ACCORDINGIY 'Raj Patel'
				
--9.	Create a stored procedure that accepts CourseID and returns all students enrolled grouped by enrollment status with counts.
		CREATE OR ALTER PROCEDURE PR_ASS_COURSEID
		@COURSEID VARCHAR(50)
		AS
		BEGIN
				SELECT E.EnrollmentStatus,
						COUNT(*) AS COUNTSTU
						FROM ENROLLMENT E
						JOIN COURSE C
						ON E.CourseID=C.CourseID
						WHERE C.CourseID=@COURSEID
						GROUP BY E.EnrollmentStatus
		END
		EXEC PR_ASS_COURSEID 'CS101'
--Part – C 
--10.	Create a stored procedure that accepts a year as input and returns all courses assigned to faculty in that year with classroom details.

		CREATE OR ALTER PROCEDURE PR_ASS_YEAR
		@YEAR INT 
		AS
		BEGIN
				SELECT F.FacultyName,CA.CLASSROOM,C.COURSENAME
				FROM FACULTY F
				JOIN COURSE_ASSIGNMENT CA
				ON F.FacultyID=CA.FacultyID
				JOIN COURSE C
				ON C.CourseID=CA.CourseID



				
--11.	Create a stored procedure that accepts From Date and To Date and returns all enrollments within that range with student and course details.
--12.	Create a stored procedure that accepts FacultyID and calculates their total teaching load (sum of credits of all courses assigned).
