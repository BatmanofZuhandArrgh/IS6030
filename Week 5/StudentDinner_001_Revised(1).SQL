CREATE DATABASE Week5Exercise001
USE Week5Exercise001

/* first table*/
IF OBJECT_ID('dbo.Restaurant', 'U') IS NOT NULL DROP TABLE dbo.Restaurant;


CREATE TABLE dbo.Restaurant (
RID INT NOT NULL PRIMARY KEY,
RName VARCHAR(100),
Address VARCHAR(500),
Phone VARCHAR (14),
LCBDistance DECIMAL (3,1),
);

/* second table */
IF OBJECT_ID('dbo.Major', 'U') IS NOT NULL DROP TABLE dbo.Major;

CREATE TABLE dbo.Major (
MID INT NOT NULL PRIMARY KEY,
Major VARCHAR(50) NOT NULL,
);

/* third table */
IF OBJECT_ID('dbo.Student', 'U') IS NOT NULL DROP TABLE dbo.Student;

CREATE TABLE dbo.Student (
SID INT NOT NULL PRIMARY KEY,
SName VARCHAR(50) NOT NULL,
Section CHAR(3),
MID INT FOREIGN KEY REFERENCES dbo.Major (MID),
);



/* fourth table */
IF OBJECT_ID('dbo.Dinner', 'U') IS NOT NULL DROP TABLE dbo.Dinner;

CREATE TABLE dbo.Dinner (
DinnerID INT IDENTITY PRIMARY KEY,
SID INT NOT NULL FOREIGN KEY REFERENCES dbo.Student (SID),
RID INT NOT NULL FOREIGN KEY REFERENCES dbo.Restaurant (RID),
DinnerDay VARCHAR (10),
Cost DECIMAL,
Rating INT
);


/*  Insert Restaurant */

INSERT INTO Restaurant VALUES (101,'Fortune Noodle House','349 Calhoun St. Cincinnati, OH 45219','(513) 281-1800',1);
INSERT INTO Restaurant VALUES (102,'Conscious Kitchen','2516 Clifton Ave Cincinnati, OH 45219','(513) 979-4062',1);
INSERT INTO Restaurant VALUES (103,'Noodles & Company','7 Martin Luther King Dr E Cincinnati, OH 45219','(513) 221-5100',0.7);
INSERT INTO Restaurant VALUES (104,'Cilantro Vietnamese Bistro','235 W McMillan Ave Cincinnati, OH 45219',NULL,1);
INSERT INTO Restaurant VALUES (105,'Tucker’s Restaurant','1637 Vine St Cincinnati, OH 45202','(513) 954-8920',1.8);
INSERT INTO Restaurant VALUES (106,'Fireside Pizza','773 E McMillan St Cincinnati, OH 45206',NULL,1.9);
INSERT INTO Restaurant VALUES (107,'Krueger’s Tavern','1211 Vine St Cincinnati, OH 45202','(513) 834-8670',2.2);
INSERT INTO Restaurant VALUES (108,'Zula','1400 Race St Cincinnati, OH 45202','(513) 744-9852',2.2);
INSERT INTO Restaurant VALUES (109,'Sushi Lounge','200 West Mcmillan Cincinnati, OH 45219','(513) 421-2666',1.1);
INSERT INTO Restaurant VALUES (110,'CrepeGuys','121 Calhoun St Cincinnati, OH 45219','(513) 221-0899',1.3);
INSERT INTO Restaurant VALUES (111,'Bagel Brothers','347 Calhoun St Cincinnati, OH 45219','(513) 221-4000',1);
INSERT INTO Restaurant VALUES (112,'Fresh Table','1801 Race St Cincinnati, OH 45202',NULL,1.8);
INSERT INTO Restaurant VALUES (113,'J. Gumbo','286 Ludlow Ave Cincinnati, OH 45220','(513) 407-6930',0.9);
INSERT INTO Restaurant VALUES (114,'Liwei Frozen Yogurt','1324 Race St Cincinnati, OH 45202',NULL,2.1);

/*  Insert Major */
INSERT INTO Major VALUES (1,'Business Analytics');
INSERT INTO Major VALUES (2,'Data Analytics Certificate');
INSERT INTO Major VALUES (3,'Information Systems');
INSERT INTO Major VALUES (4,'Marketing');
INSERT INTO Major VALUES (5,'MBA');
INSERT INTO Major VALUES (6,'Open Program');
INSERT INTO Major VALUES (7,'Accounting');
INSERT INTO Major VALUES (8,'Education');
INSERT INTO Major VALUES (9,'Environmental Health');



/*  Insert Student */
INSERT INTO Student VALUES (1,'Nikki','001',2);
INSERT INTO Student VALUES (2,'Diksha','001',4);
INSERT INTO Student VALUES (3,'Kevin D.','001',1);
INSERT INTO Student VALUES (4,'Allison','001',2);
INSERT INTO Student VALUES (5,'Brenda','001',2);
INSERT INTO Student VALUES (6,'Sneha','001',5);
INSERT INTO Student VALUES (7,'Kevin G.','001',6);
INSERT INTO Student VALUES (8,'Onward','001',5);
INSERT INTO Student VALUES (9,'Sahil','001',5);
INSERT INTO Student VALUES (10,'Samantha','001',7);
INSERT INTO Student VALUES (11,'Natalia','001',4);
INSERT INTO Student VALUES (12,'Heather','001',4);
INSERT INTO Student VALUES (13,'Keanen','001',8);
INSERT INTO Student VALUES (14,'Morgan','001',3);
INSERT INTO Student VALUES (15,'Lauren','001',5);
INSERT INTO Student VALUES (16,'Robert','001',5);
INSERT INTO Student VALUES (17,'Rasika','001',4);
INSERT INTO Student VALUES (18,'Mike','001',5);
INSERT INTO Student VALUES (19,'Amy','001',5);
INSERT INTO Student VALUES (20,'Matt','001',5);
INSERT INTO Student VALUES (21,'Eunsun','001',9);
INSERT INTO Student VALUES (22,'Can','001',2);
INSERT INTO Student VALUES (23,'Lisa','001',5);
INSERT INTO Student VALUES (24,'Menaleza','001',1);
INSERT INTO Student VALUES (25,'Erisson','001',1);
INSERT INTO Student VALUES (26,'Yuejie','001',1);
INSERT INTO Student VALUES (27,'Vu','001',3);
INSERT INTO Student VALUES (28,'Cameron','001',1);
INSERT INTO Student VALUES (29,'Lori','001',1);
INSERT INTO Student VALUES (30,'Rucha','001',1);
INSERT INTO Student VALUES (31,'Ricki','001',1);




/*  Insert Dinner */
INSERT INTO Dinner VALUES (1,106,'Monday',10,2);
INSERT INTO Dinner VALUES (1,102,'Tuesday',8,5);
INSERT INTO Dinner VALUES (1,113,'Wednesday',12,2);
INSERT INTO Dinner VALUES (1,110,'Thursday',10,3);
INSERT INTO Dinner VALUES (1,103,'Friday',10,2);
INSERT INTO Dinner VALUES (1,101,'Saturday',9,5);
INSERT INTO Dinner VALUES (2,104,'Monday',12,4);
INSERT INTO Dinner VALUES (2,104,'Tuesday',10,3);
INSERT INTO Dinner VALUES (2,113,'Thursday',11,3);
INSERT INTO Dinner VALUES (2,112,'Friday',11,4);
INSERT INTO Dinner VALUES (2,112,'Saturday',9,3);
INSERT INTO Dinner VALUES (3,104,'Sunday',11,4);
INSERT INTO Dinner VALUES (3,106,'Monday',11,4);
INSERT INTO Dinner VALUES (3,103,'Tuesday',10,4);
INSERT INTO Dinner VALUES (3,104,'Wednesday',11,4);
INSERT INTO Dinner VALUES (3,105,'Friday',11,2);
INSERT INTO Dinner VALUES (3,103,'Saturday',8,4);
INSERT INTO Dinner VALUES (4,104,'Sunday',12,2);
INSERT INTO Dinner VALUES (4,108,'Monday',8,4);
INSERT INTO Dinner VALUES (4,110,'Tuesday',9,2);
INSERT INTO Dinner VALUES (4,107,'Wednesday',10,3);
INSERT INTO Dinner VALUES (4,113,'Thursday',9,5);
INSERT INTO Dinner VALUES (4,110,'Friday',10,2);
INSERT INTO Dinner VALUES (4,109,'Saturday',10,5);
INSERT INTO Dinner VALUES (5,112,'Sunday',11,5);
INSERT INTO Dinner VALUES (5,110,'Monday',8,3);
INSERT INTO Dinner VALUES (5,113,'Tuesday',12,5);
INSERT INTO Dinner VALUES (5,101,'Wednesday',9,4);
INSERT INTO Dinner VALUES (6,102,'Friday',12,2);
INSERT INTO Dinner VALUES (6,110,'Monday',9,4);
INSERT INTO Dinner VALUES (6,108,'Tuesday',10,5);
INSERT INTO Dinner VALUES (6,102,'Wednesday',12,3);
INSERT INTO Dinner VALUES (6,105,'Friday',8,2);
INSERT INTO Dinner VALUES (6,104,'Saturday',12,3);
INSERT INTO Dinner VALUES (7,104,'Sunday',10,4);
INSERT INTO Dinner VALUES (7,105,'Monday',9,2);
INSERT INTO Dinner VALUES (7,109,'Tuesday',11,2);
INSERT INTO Dinner VALUES (7,112,'Wednesday',12,3);
INSERT INTO Dinner VALUES (7,109,'Saturday',9,2);
INSERT INTO Dinner VALUES (8,111,'Sunday',12,4);
INSERT INTO Dinner VALUES (8,107,'Thursday',11,2);
INSERT INTO Dinner VALUES (8,113,'Friday',11,4);
INSERT INTO Dinner VALUES (8,105,'Saturday',9,5);
INSERT INTO Dinner VALUES (9,102,'Sunday',11,5);
INSERT INTO Dinner VALUES (9,113,'Monday',11,4);
INSERT INTO Dinner VALUES (9,112,'Tuesday',8,5);
INSERT INTO Dinner VALUES (10,104,'Wednesday',10,3);
INSERT INTO Dinner VALUES (10,113,'Sunday',10,5);
INSERT INTO Dinner VALUES (10,110,'Monday',10,2);
INSERT INTO Dinner VALUES (10,105,'Tuesday',12,4);
INSERT INTO Dinner VALUES (11,107,'Friday',11,4);
INSERT INTO Dinner VALUES (11,106,'Sunday',12,4);
INSERT INTO Dinner VALUES (11,105,'Monday',9,4);
INSERT INTO Dinner VALUES (12,105,'Tuesday',10,5);
INSERT INTO Dinner VALUES (12,111,'Monday',12,4);
INSERT INTO Dinner VALUES (12,113,'Friday',9,4);
INSERT INTO Dinner VALUES (12,104,'Wednesday',11,3);
INSERT INTO Dinner VALUES (12,106,'Thursday',11,2);
INSERT INTO Dinner VALUES (12,110,'Sunday',11,3);
INSERT INTO Dinner VALUES (12,101,'Saturday',12,5);
INSERT INTO Dinner VALUES (13,104,'Sunday',8,5);
INSERT INTO Dinner VALUES (13,109,'Tuesday',10,2);
INSERT INTO Dinner VALUES (13,109,'Wednesday',17,4);
INSERT INTO Dinner VALUES (13,102,'Thursday',11,3);
INSERT INTO Dinner VALUES (13,106,'Friday',14,5);
INSERT INTO Dinner VALUES (14,105,'Saturday',29,5);
INSERT INTO Dinner VALUES (14,110,'Monday',19,2);
INSERT INTO Dinner VALUES (14,110,'Tuesday',11,5);
INSERT INTO Dinner VALUES (14,105,'Wednesday',26,4);
INSERT INTO Dinner VALUES (14,101,'Friday',25,3);
INSERT INTO Dinner VALUES (14,104,'Sunday',21,2);
INSERT INTO Dinner VALUES (15,104,'Sunday',20,3);
INSERT INTO Dinner VALUES (15,108,'Monday',16,5);
INSERT INTO Dinner VALUES (15,101,'Tuesday',13,2);
INSERT INTO Dinner VALUES (15,104,'Wednesday',23,5);
INSERT INTO Dinner VALUES (15,108,'Friday',22,4);
INSERT INTO Dinner VALUES (15,107,'Saturday',16,5);
INSERT INTO Dinner VALUES (16,103,'Sunday',16,4);
INSERT INTO Dinner VALUES (16,107,'Monday',12,4);
INSERT INTO Dinner VALUES (16,101,'Tuesday',23,5);
INSERT INTO Dinner VALUES (16,101,'Wednesday',29,4);
INSERT INTO Dinner VALUES (16,111,'Thursday',28,2);
INSERT INTO Dinner VALUES (16,111,'Friday',23,4);
INSERT INTO Dinner VALUES (16,101,'Saturday',23,5);
INSERT INTO Dinner VALUES (17,109,'Sunday',26,4);
INSERT INTO Dinner VALUES (17,108,'Monday',24,2);
INSERT INTO Dinner VALUES (17,108,'Tuesday',13,2);
INSERT INTO Dinner VALUES (17,103,'Wednesday',13,2);
INSERT INTO Dinner VALUES (17,105,'Thursday',20,4);
INSERT INTO Dinner VALUES (18,101,'Friday',14,5);
INSERT INTO Dinner VALUES (18,113,'Monday',29,3);
INSERT INTO Dinner VALUES (18,106,'Tuesday',23,1);
INSERT INTO Dinner VALUES (18,109,'Wednesday',26,3);
INSERT INTO Dinner VALUES (18,103,'Thursday',25,4);
INSERT INTO Dinner VALUES (18,103,'Saturday',26,4);
INSERT INTO Dinner VALUES (19,103,'Saturday',22,4);
INSERT INTO Dinner VALUES (19,108,'Monday',24,3);
INSERT INTO Dinner VALUES (19,103,'Tuesday',18,3);
INSERT INTO Dinner VALUES (19,111,'Wednesday',12,2);
INSERT INTO Dinner VALUES (19,104,'Friday',10,1);
INSERT INTO Dinner VALUES (19,111,'Sunday',25,4);
INSERT INTO Dinner VALUES (20,104,'Sunday',24,2);
INSERT INTO Dinner VALUES (20,110,'Monday',29,2);
INSERT INTO Dinner VALUES (20,110,'Tuesday',12,5);
INSERT INTO Dinner VALUES (20,102,'Wednesday',21,2);
INSERT INTO Dinner VALUES (20,110,'Friday',15,3);
INSERT INTO Dinner VALUES (21,110,'Saturday',25,4);
INSERT INTO Dinner VALUES (21,105,'Monday',30,5);
INSERT INTO Dinner VALUES (21,113,'Tuesday',11,4);
INSERT INTO Dinner VALUES (21,108,'Wednesday',23,5);
INSERT INTO Dinner VALUES (21,106,'Thursday',27,4);
INSERT INTO Dinner VALUES (21,111,'Sunday',22,4);
INSERT INTO Dinner VALUES (22,113,'Sunday',27,5);
INSERT INTO Dinner VALUES (22,112,'Monday',16,5);
INSERT INTO Dinner VALUES (22,113,'Tuesday',12,2);
INSERT INTO Dinner VALUES (22,106,'Wednesday',25,5);
INSERT INTO Dinner VALUES (22,103,'Friday',9,3);
INSERT INTO Dinner VALUES (22,112,'Saturday',10,2);
INSERT INTO Dinner VALUES (23,102,'Sunday',12,5);
INSERT INTO Dinner VALUES (23,104,'Monday',9,5);
INSERT INTO Dinner VALUES (23,110,'Tuesday',11,2);
INSERT INTO Dinner VALUES (23,111,'Wednesday',8,3);
INSERT INTO Dinner VALUES (23,103,'Friday',11,3);
INSERT INTO Dinner VALUES (23,108,'Saturday',8,2);
INSERT INTO Dinner VALUES (24,104,'Sunday',11,2);
INSERT INTO Dinner VALUES (24,111,'Monday',12,4);
INSERT INTO Dinner VALUES (24,108,'Tuesday',11,4);
INSERT INTO Dinner VALUES (24,110,'Wednesday',11,4);
INSERT INTO Dinner VALUES (24,112,'Friday',10,2);
INSERT INTO Dinner VALUES (24,102,'Saturday',9,3);
INSERT INTO Dinner VALUES (25,112,'Sunday',10,3);
INSERT INTO Dinner VALUES (25,111,'Monday',12,5);
INSERT INTO Dinner VALUES (25,101,'Tuesday',10,2);
INSERT INTO Dinner VALUES (25,103,'Wednesday',12,2);
INSERT INTO Dinner VALUES (25,110,'Friday',15,4);
INSERT INTO Dinner VALUES (25,108,'Thursday',27,4);
INSERT INTO Dinner VALUES (26,102,'Sunday',19,4);
INSERT INTO Dinner VALUES (26,103,'Monday',22,2);
INSERT INTO Dinner VALUES (26,104,'Tuesday',23,5);
INSERT INTO Dinner VALUES (26,112,'Wednesday',30,5);
INSERT INTO Dinner VALUES (26,112,'Friday',24,3);
INSERT INTO Dinner VALUES (26,109,'Saturday',14,3);
INSERT INTO Dinner VALUES (27,105,'Sunday',25,2);
INSERT INTO Dinner VALUES (27,112,'Monday',21,5);
INSERT INTO Dinner VALUES (27,106,'Tuesday',26,4);
INSERT INTO Dinner VALUES (27,110,'Wednesday',16,3);
INSERT INTO Dinner VALUES (27,110,'Friday',12,3);
INSERT INTO Dinner VALUES (28,101,'Saturday',19,3);
INSERT INTO Dinner VALUES (28,104,'Sunday',22,3);
INSERT INTO Dinner VALUES (28,107,'Tuesday',17,4);
INSERT INTO Dinner VALUES (28,102,'Wednesday',19,5);
INSERT INTO Dinner VALUES (28,110,'Friday',19,2);
INSERT INTO Dinner VALUES (29,104,'Saturday',10,4);
INSERT INTO Dinner VALUES (29,101,'Sunday',25,4);
INSERT INTO Dinner VALUES (29,102,'Tuesday',24,2);
INSERT INTO Dinner VALUES (29,106,'Wednesday',27,4);
INSERT INTO Dinner VALUES (29,113,'Saturday',27,2);
INSERT INTO Dinner VALUES (29,109,'Thursday',26,5);
INSERT INTO Dinner VALUES (30,106,'Monday',12,3);
INSERT INTO Dinner VALUES (30,102,'Tuesday',8,5);
INSERT INTO Dinner VALUES (30,101,'Wednesday',10,4);
INSERT INTO Dinner VALUES (30,113,'Thursday',12,3);
INSERT INTO Dinner VALUES (30,109,'Saturday',10,5);
INSERT INTO Dinner VALUES (30,101,'Sunday',12,2);
INSERT INTO Dinner VALUES (31,113,'Monday',9,4);
INSERT INTO Dinner VALUES (31,106,'Tuesday',10,4);
INSERT INTO Dinner VALUES (31,101,'Friday',8,5);
INSERT INTO Dinner VALUES (31,106,'Saturday',12,2);
INSERT INTO Dinner VALUES (31,105,'Sunday',9,4);
