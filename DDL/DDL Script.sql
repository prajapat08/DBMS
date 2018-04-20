set search_path to public;
create schema project;
set search_path to project;

CREATE TABLE operators(
Name Varchar(50),
Operator_ID int,
Supervisor_Id int,
Address Varchar(50),
DOB date,
SEX char(1),
Primary key (Operator_ID),
Foreign key (Supervisor_Id) REFERENCES operators(Operator_ID) 
ON DELETE SET DEFAULT ON UPDATE CASCADE
);

CREATE TABLE ministries(
Name_of_ministery Varchar(100),
Head_of_ministery Varchar(50),
Ministry_code Varchar(10),
Primary key (Ministry_code)
);

CREATE TABLE sectors(
Name varchar(20),
Sector_code varchar(20),
Manager_Id int,
Ministry_Code Varchar(20),
primary key (Sector_code),
Foreign key (Ministry_Code) REFERENCES ministries(Ministry_code), 
Foreign key (Manager_Id) REFERENCES operators(Operator_ID) on delete set null
    
);

CREATE TABLE launchedby (
ID Varchar(10),
Name Varchar(40),
Primary key (ID)
);

CREATE TABLE districts(
Name varchar(20),
District_code Varchar(5),
Manager_Id int,
Primary key (District_Code),
Foreign Key (Manager_Id) REFERENCES operators(Operator_ID) on delete set null
);

CREATE TABLE scheme(
Name_of_scheme Varchar(70),
Scheme_code Varchar(20),
Status varchar(20),
Sector_code Varchar(20), 
Launched_Year Varchar(5),
Govt_Id Varchar(10),
Primary key (Scheme_code),
Foreign key (Sector_code) REFERENCES sectors(Sector_code) on delete set null, 
Foreign key (Govt_Id) REFERENCES launchedby(ID)   
);

CREATE TABLE location(
Location_Code Varchar(20),
Location_Name Varchar(20),
No_Males int,
No_Females int,
District_Code VARCHAR(5),
Pincode int,
Supervisor_Id int,
Primary Key (Location_Code),
Foreign Key (District_Code) REFERENCES districts(District_Code),
Foreign Key (Supervisor_Id) REFERENCES operators(Operator_ID) on delete set null 
);

CREATE TABLE beneficiary(
Enrollment_id int,
Enrollment_Date date,
City_code Varchar(20),
Primary Key (Enrollment_id), 
Foreign key  (City_code) REFERENCES location(Location_code)
);

CREATE TABLE individuals(
Enrollment_id int,
FName varchar(20),
Mname varchar(20),
Lname varchar(20),
DOB varchar(20),
Sex char(1),
Primary Key (Enrollment_id),
Foreign Key (Enrollment_id) REFERENCES benificiary(Enrollment_id) 
);

CREATE TABLE organisation(
Enrollment_id int,
Organisation_Name Varchar(50),
Primary Key (Enrollment_id),
Foreign Key (Enrollment_id) REFERENCES benificiary(Enrollment_id)
);

CREATE TABLE Identity_Cards(
Enrollment_id int(50),
ID_Name varchar(50),
ID_No int(50),
Primary Key (Enrollment_id),
Foreign Key (Enrollment_id) REFERENCES individuals(Enrollment_id)
);


CREATE TABLE audits(
Fund_alloted int,
Fund_Scheme_code varchar(20),
Fund_spent int,
Audited_by int,
Foreign key (Fund_Scheme_Code) REFERENCES scheme(Scheme_code) on delete set null,
Foreign key(Audited_by) REFERENCES  operators(Operator_ID)
);

CREATE TABLE benefittedby(
Fund_Status Varchar(10),
Fund int,
Scheme_code Varchar(20),
Enrollment_id int,
Primary Key (Scheme_code, Enrollment_id),
Foreign Key (Scheme_code) REFERENCES scheme(Scheme_code) on delete set null,
Foreign Key (Enrollment_id) REFERENCES benificiary(Enrollment_id)
);

CREATE TRIGGER upd_fund AFTER UPDATE ON Benefittedby
FOR EACH ROW
BEGIN
	UPDATE AUDITS SET FUND_SPENT=FUNS_SPENT+(NEW.FUND-OLD.FUND);
END;	

INSERT INTO operators VALUES('RAHUL MAKASRE','201501',NULL,'Indore','1971-08-23','M');
INSERT INTO operators VALUES('MALA BHAWSAR','201503',NULL,'Bhopal','1975-03-2','F');
INSERT INTO operators VALUES('MUKESH BHALSE','201502',NULL,'Jabalpur','1973-07-3','M');
INSERT INTO operators VALUES('RANJEET RAISINGH','201504',NULL,'Sagar','1971-06-24','M');
INSERT INTO operators VALUES('MUKESH CHOUHAN','201505',NULL,'Gwalior','1972-01-12','M');
INSERT INTO operators VALUES('GOPAL SOLANKI','201506',NULL,'Rewa','1976-09-28','M');
INSERT INTO operators VALUES('SUNITA CHOUHAN','201507',NULL,'Panna','1978-10-10','F');
INSERT INTO operators VALUES('NIKITA NITIN JOSHI','201508',NULL,'Khandwa','1975-02-18','F');
INSERT INTO operators VALUES('NIRMLA KOCHALE','201509',NULL,'Khargone','1972-01-12','F');
INSERT INTO operators VALUES('MAMTA SHARMA','201510',NULL,'Indore','1972-01-12','F');
INSERT INTO operators VALUES('Shah Rukh Khan','201521',NULL,'Chennai','1980-02-11','M');
INSERT INTO operators VALUES('Arijit Singh','201522',NULL,'Mangalore','1985-01-02','M');
INSERT INTO operators VALUES('Kanan Gill','201523',NULL,'Bangalore','1985-01-01','M');
INSERT INTO operators VALUES('Biswa Kalyan','201524',NULL,'Patna','1980-05-03','M');
INSERT INTO operators VALUES('Soniya Gandhi','201525',NULL,'Banaras','1974-03-02','F');
INSERT INTO operators VALUES('Raj Malhotra','201526',NULL,'Durgapur','1972-01-12','M');
INSERT INTO operators VALUES('Simran','201527',NULL,'Pune','1978-09-12','F');
INSERT INTO operators VALUES('Himesh Reshamiya','201528',NULL,'Pondicherry','1976-11-08','M');
INSERT INTO operators VALUES('Salman Khan','201529',NULL,'Mysore','1965-10-12','M');
INSERT INTO operators VALUES('CHETNA  CHOUHAN	','201551',NULL,'Chhindwara','1971-09-10','F');
INSERT INTO operators VALUES('ANITA  SOLANKI','201552',NULL,'Panna','1970-01-12','F');
INSERT INTO operators VALUES('RAMESH  KIRAR','201553',NULL,'Sagar','1977-11-25','M');
INSERT INTO operators VALUES('SANTOSH KUMRAWAT','201554',NULL,'Dhar','1962-07-11','M');
INSERT INTO operators VALUES('ABHILASHA KANOONGO','201555',NULL,'Bhopal','1974-12-25','F');
INSERT INTO operators VALUES('Sonu Nigam','201511','201501','Mumbai','1982-04-09','M');
INSERT INTO operators VALUES('Anu Malik','201512','201502','Bhopal','1962-12-06','M');
INSERT INTO operators VALUES('SHEELA  VANKHEDE','201513','201503','Mysore','1965-05-12','F');
INSERT INTO operators VALUES('AARTI  GUPTA','201514','201504','Mumbai','1982-11-09','F');
INSERT INTO operators VALUES('AMIT  PARSAI','201515','201505','Bhopal','1962-06-06','M');
INSERT INTO operators VALUES('ASHA  MANDLOI','201516','201506','KHANDWA','1972-05-16','F');
INSERT INTO operators VALUES('ARCHANA MANDLOI	','201517','201507','KHARGONE','1969-11-19','F');
INSERT INTO operators VALUES('MUKESH JADHAV','201518','201508','Jabalpur','1968-02-14','M');
INSERT INTO operators VALUES('JAYNARAYAN MEVADE','201519','201509','Gwalior','1975-08-05','M');
INSERT INTO operators VALUES('VIJAY  MANDLOI','201520','201510','Chhatarpur','1966-03-18','M');
INSERT INTO operators VALUES('KRASHANKUMAR  KHANDE','201541','201551','KHARGONE','1969-11-19','M');
INSERT INTO operators VALUES('PRAKASH  NIGWAL','201542','201552','Jabalpur','1968-02-14','F');
INSERT INTO operators VALUES('KAMINI MISHRA','201543','201553','Gwalior','1975-08-05','F');
INSERT INTO operators VALUES('GORI  KHANNA','201544','201554','Chhatarpur','1966-03-18','M');
INSERT INTO operators VALUES('RUPESH  GANGRADE','201545','201555','KHARGONE','1969-11-19','M');


INSERT INTO ministries VALUES('Ministry of Health and Family Welfare','Jagat Prakash Nadda','MoHFW');
INSERT INTO ministries VALUES('Ministry of Power','Piyush Goyal','MoP');
INSERT INTO ministries VALUES('Ministry of Rural Development','SHRI NARENDRA SINGH TOMAR','MoRD');
INSERT INTO ministries VALUES('Ministry of Human Resource Development','Prakash Javadekar','MoHRD');
INSERT INTO ministries VALUES('Ministry of Ministry of Agriculture & Farmers Welfare','Jagat Radha Mohan Singh','MoAFW');
INSERT INTO ministries VALUES('Ministry of Women and Child Development','Maneka Gandhi,','MoWCD');
INSERT INTO ministries VALUES('Ministry of Finance','Arun Jaitley','MoF');
INSERT INTO ministries VALUES('Ministry of Labour and Employment','Bandaru Dattatreya','MoLE');
INSERT INTO ministries VALUES('Ministry of Tourism','Shri Nitin Jairam Gadkari','MoT');
 
INSERT INTO sectors VALUES('Education','1','201521','MoHRD');
INSERT INTO sectors VALUES('Agriculture','2','201522','MoAFW');
INSERT INTO sectors VALUES('Rural Development','3','201523','MoHFW');
INSERT INTO sectors VALUES('Women Development','4','201524','MoWCD');
INSERT INTO sectors VALUES('Child Development','5','201525','MoWCD');
INSERT INTO sectors VALUES('Employment','6','201526','MoLE');
INSERT INTO sectors VALUES('Tourism','7','201527','MoT');
INSERT INTO sectors VALUES('Financial Assistance','8','201528','MoF');
INSERT INTO sectors VALUES('Health','9','201529','MoHFW');

INSERT INTO launchedby VALUES('SG','State Government');
INSERT INTO launchedby VALUES('CG','Central Government');
INSERT INTO launchedby VALUES('JOINT','State and Central Government');

INSERT INTO districts VALUES('Bhopal','BPL','201501');
INSERT INTO districts VALUES('Gwalior','GL','201502');  
INSERT INTO districts VALUES('Indore','IND','201503');
INSERT INTO districts VALUES('Rewa','RW','201504');
INSERT INTO districts VALUES('Sagar','SG','201505');
INSERT INTO districts VALUES('Khandwa','KHD','201506');
INSERT INTO districts VALUES('Khargone','KHG','201507');
INSERT INTO districts VALUES('Jabalpur','JBL','201508');
INSERT INTO districts VALUES('Tikamgarh','TGH','201509');
INSERT INTO districts VALUES('Barwani','BWN','201510');
INSERT INTO districts VALUES('Dhar','DHR','201551');
INSERT INTO districts VALUES('Satna','STN','201552');
INSERT INTO districts VALUES('Damoh','DMH','201553');
INSERT INTO districts VALUES('Vidisha','VSH','201554');
INSERT INTO districts VALUES('Guna','GNA','201555');

INSERT INTO location VALUES('MP01','KHARGONE','17000','10000','KHG','452001','201511');
INSERT INTO location VALUES('MP02','KHANDWA','18000','11000','KHD','452002','201512');
INSERT INTO location VALUES('MP03','Indore','17570','10890','IND','452003','201513');
INSERT INTO location VALUES('MP04','Bhopal','17800','12300','BPL','452004','201514');
INSERT INTO location VALUES('MP05','Barwani','13450','6709','BWN','452001','201515');
INSERT INTO location VALUES('MP06','Dhar','13450','6709','DHR','452011','201516');
INSERT INTO location VALUES('MP07','Satna','18570','10190','STN','452013','201517');
INSERT INTO location VALUES('MP08','Damoh','17800','12300','DMH','452004','201518');
INSERT INTO location VALUES('MP09','Vidisha','13450','6709','VSH','452001','201519');
INSERT INTO location VALUES('MP10','Guna','13450','6709','GNA','452011','201520');
INSERT INTO location VALUES('MP11','Gogawa','10450','4709','KHG','454011','201541');
INSERT INTO location VALUES('MP12','Bairagarh','10450','4709','BPL','454411','201542');
INSERT INTO location VALUES('MP13','Mhow','10490','9709','IND','455011','201543');
INSERT INTO location VALUES('MP14','Pandhana','13480','8759','KHD','454023','201544');
INSERT INTO location VALUES('MP15','Sendhwa','10450','4709','BWN','451031','201545');

INSERT INTO scheme VALUES('Atal Pension Yojana','APY','Y','8','2014','CG');
INSERT INTO scheme VALUES('Pradhan Mantri Aawas Yojana','PMAY','Y','4','2015','CG');
INSERT INTO scheme VALUES('Pradhan Mantri Fasal Bima Yojana','PMFBY','N','2','2013','CG');
INSERT INTO scheme VALUES('Pradhan Mantri Gram Sinchai Yojana','PMGSY','Y','2','2012','CG');
INSERT INTO scheme VALUES('Beti Bachao, Beti Padhao Yojana','BBBPY','Y','1','2014','SG');
INSERT INTO scheme VALUES('Pradhan Mantri Jan Kaushalya Yojana','PMJKY','Y','7','2013','CG');
INSERT INTO scheme VALUES('Skill India','SI','Y','7','2012','CG');
INSERT INTO scheme VALUES('Mission Indradhanush','MI','Y','5','2016','SG');
INSERT INTO scheme VALUES('Swadesh Darshan','SD','Y','3','2013','JOINT');
INSERT INTO scheme VALUES('Udaan Scheme','US','Y','1','2015','JOINT');
INSERT INTO scheme VALUES('Pradhan Mantri Jan Aushadhi Yojana','PMJAY','Y','9','2013','CG');

INSERT INTO beneficiary VALUES('10000001','2014-01-03','MP01');
INSERT INTO beneficiary VALUES('10000002','2015-08-01','MP05');
INSERT INTO beneficiary VALUES('10000003','2015-07-23','MP03');
INSERT INTO beneficiary VALUES('10000004','2013-06-04','MP04');
INSERT INTO beneficiary VALUES('10000005','2014-09-03','MP01');
INSERT INTO beneficiary VALUES('10000006','2014-01-03','MP02');
INSERT INTO beneficiary VALUES('10000007','2015-01-03','MP14');
INSERT INTO beneficiary VALUES('10000008','2016-01-03','MP03');
INSERT INTO beneficiary VALUES('10000009','2014-01-03','MP05');
INSERT INTO beneficiary VALUES('10000010','2013-01-03','MP04');
INSERT INTO beneficiary VALUES('10000011','2014-01-03','MP12');
INSERT INTO beneficiary VALUES('10000012','2014-01-03','MP01');
INSERT INTO beneficiary VALUES('10000013','2014-01-03','MP13');
INSERT INTO beneficiary VALUES('10000014','2014-01-03','MP05');
INSERT INTO beneficiary VALUES('10000015','2014-01-03','MP01');
INSERT INTO beneficiary VALUES('10000016','2014-01-03','MP02');
INSERT INTO beneficiary VALUES('10000021','2014-01-03','MP04');
INSERT INTO beneficiary VALUES('10000022','2016-01-03','MP02');
INSERT INTO beneficiary VALUES('10000023','2013-01-03','MP01');
INSERT INTO beneficiary VALUES('10000024','2015-01-03','MP11');
INSERT INTO beneficiary VALUES('10000025','2014-01-03','MP05');
INSERT INTO beneficiary VALUES('10000026','2014-06-13','MP06');
INSERT INTO beneficiary VALUES('10000027','2016-01-03','MP07');
INSERT INTO beneficiary VALUES('10000028','2013-01-03','MP07');
INSERT INTO beneficiary VALUES('10000029','2015-01-03','MP09');
INSERT INTO beneficiary VALUES('10000031','2014-01-03','MP10');
INSERT INTO beneficiary VALUES('10000032','2014-01-03','MP08');
INSERT INTO beneficiary VALUES('10000033','2014-01-03','MP15');
INSERT INTO beneficiary VALUES('10000034','2014-01-03','MP10');
INSERT INTO beneficiary VALUES('10000035','2014-01-03','MP12');
INSERT INTO beneficiary VALUES('10000036','2014-01-03','MP11');
INSERT INTO beneficiary VALUES('10000037','2014-01-03','MP01');

INSERT INTO individuals VALUES('10000001','RAJ','VEER','SINGH','1988-01-11','M');
INSERT INTO individuals VALUES('10000002','GAURAV','KUMAR','DAWAR','1999-01-11','M');
INSERT INTO individuals VALUES('10000003','DHEERAJ','KARAN','SINGH','1990-01-11','M');
INSERT INTO individuals VALUES('10000004','Shweta','BEGUM','Gupta','1991-01-11','F');
INSERT INTO individuals VALUES('10000005','SATYAM','KUMAR','RAJPOOT','1997-01-11','M');
INSERT INTO individuals VALUES('10000006','Sunita','-','Vyas','1993-01-11','F');
INSERT INTO individuals VALUES('10000007','Sunita','KR.','Khande','1999-01-11','F');
INSERT INTO individuals VALUES('10000008','JANVI','BEN','PATIL','1989-01-11','F');
INSERT INTO individuals VALUES('10000009','SHRADHA','KUMARI','SINGH','1999-01-11','F');
INSERT INTO individuals VALUES('10000010','Aman','Rakesh','Kumar','1968-01-11','M');
INSERT INTO individuals VALUES('10000011','Ramesh','Singh','Chauhan','1965-23-05','M');
INSERT INTO individuals VALUES('10000012','Neil','Nitin','Mukesh','1959-03-04','M');
INSERT INTO individuals VALUES('10000013','Sachin','Ramesh','Tendulkar','1963-02-09','M');
INSERT INTO individuals VALUES('10000014','Kamla','Singh','Yadav','1965-05-09','F');
INSERT INTO individuals VALUES('10000015','Sourav','Singh','Yadav','1969-01-04','M');
INSERT INTO individuals VALUES('10000016','Pratibha','Rakesh','Solanki','1962-03-08','F');
INSERT INTO individuals VALUES('10000026','Neelansh','Nitin','Bhide','1989-03-04','M');
INSERT INTO individuals VALUES('10000027','Rahul','Ramesh','Teja','1999-02-09','M');
INSERT INTO individuals VALUES('10000028','Shikhar','Singh','Yadv','1995-05-09','M');
INSERT INTO individuals VALUES('10000029','Neha','Singh','Chouhan','1979-01-04','F');
INSERT INTO individuals VALUES('10000030','Pratima','Rakesh','Solanki','1982-03-08','F');

INSERT INTO organisation VALUES('10000021','Kisan Kalyan Samiti');
INSERT INTO organisation VALUES('10000022','Rozgaar Kalyan Samiti');
INSERT INTO organisation VALUES('10000023','Swasthya Sanstha');
INSERT INTO organisation VALUES('10000024','Sarv Shiksha Sanstha');
INSERT INTO organisation VALUES('10000025','Kisan Kalyan Samiti');

INSERT INTO audits VALUES('100000','APY','500000','201501');
INSERT INTO audits VALUES('150000','PMAY','580000','201502');
INSERT INTO audits VALUES('100000','PMFBY','500000','201503');
INSERT INTO audits VALUES('150000','PMGSY','580000','201504');
INSERT INTO audits VALUES('100000','PMJKY','500000','201505');
INSERT INTO audits VALUES('150000','SI','580000','201506');
INSERT INTO audits VALUES('100000','MI','500000','201507');
INSERT INTO audits VALUES('150000','SD','580000','201508');
INSERT INTO audits VALUES('100000','US','500000','201509');
INSERT INTO audits VALUES('150000','PMJAY','580000','201510');
INSERT INTO audits VALUES('100000','APY','500000','201511');
INSERT INTO audits VALUES('100000','APY','500000','201551');
INSERT INTO audits VALUES('150000','PMAY','580000','201552');
INSERT INTO audits VALUES('100000','PMFBY','500000','201553');
INSERT INTO audits VALUES('150000','PMGSY','580000','201554');
INSERT INTO audits VALUES('100000','PMJKY','500000','201555');

INSERT INTO benefittedby VALUES('Y','12000','APY','10000016');
INSERT INTO benefittedby VALUES('Y','12000','PMAY','10000010');
INSERT INTO benefittedby VALUES('Y','12000','PMFBY','10000015');
INSERT INTO benefittedby VALUES('N','12000','PMGSY','10000020');
INSERT INTO benefittedby VALUES('N','12000','PMJKY','10000004');
INSERT INTO benefittedby VALUES('Y','12000','SI','10000013');
INSERT INTO benefittedby VALUES('N','12000','US','10000003');
INSERT INTO benefittedby VALUES('Y','12000','PMJAY','10000012');
INSERT INTO benefittedby VALUES('Y','12000','US','10000002');
INSERT INTO benefittedby VALUES('N','16000','PMJAY','10000013');