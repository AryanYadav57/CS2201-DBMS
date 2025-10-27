CREATE DATABASE Hospital;
USE Hospital;

-- Table: Patients
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(50),
    gender VARCHAR(10),
    dob DATE,
    city VARCHAR(30)
);

-- Table: Doctors
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(50),
    specialization VARCHAR(50),
    fees DECIMAL(10,2)
);

-- Table: Appointments
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    diagnosis VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

INSERT INTO Patients VALUES
(1, 'Asha Rao', 'Female', '2000-04-12', 'Bangalore'),
(2, 'Rahul Kumar', 'Male', '1999-10-05', 'Mysore'),
(3, 'Sneha Patil', 'Female', '2001-07-22', 'Mangalore'),
(4, 'Rohit Sharma', 'Male', '1998-12-11', 'Hubli'),
(5, 'Neha Singh', 'Female', '2000-01-25', 'Udupi');

INSERT INTO Doctors VALUES
(101, 'Dr. Meena Joshi', 'Cardiologist', 800.00),
(102, 'Dr. Ravi Das', 'Dentist', 500.00),
(103, 'Dr. Arjun Rao', 'Neurologist', 1200.00),
(104, 'Dr. Priya Shetty', 'Dermatologist', 700.00);

INSERT INTO Appointments VALUES
(1, 1, 101, '2024-06-10', 'Check-up'),
(2, 2, 103, '2024-07-01', 'Headache'),
(3, 3, 104, '2024-06-15', 'Skin Allergy'),
(4, 4, 102, '2024-05-20', 'Tooth Pain'),
(5, 5, 101, '2024-07-05', 'Chest Pain');

-- Total number of patients
SELECT COUNT(*) AS Total_Patients FROM Patients;
-- OUTPUT: 5

-- Average doctor fee
SELECT AVG(fees) AS Avg_Doctor_Fee FROM Doctors;
-- OUTPUT: 800.000000

-- Maximum and Minimum doctor fee
SELECT MAX(fees) AS Max_Fee, MIN(fees) AS Min_Fee FROM Doctors;
/* OUTPUT:
# Max_Fee	Min_Fee
1200.00	500.00
*/

-- Appointments with year and month
SELECT appointment_id, YEAR(appointment_date) AS Year, 
MONTH(appointment_date) AS Month
FROM Appointments;
/* OUTPUT:
# appointment_id	Year	Month
1	2024	6
2	2024	7
3	2024	6
4	2024	5
5	2024	7
*/

SELECT p.patient_name, d.doctor_name, a.diagnosis
FROM Patients p
INNER JOIN Appointments a ON p.patient_id = a.patient_id
INNER JOIN Doctors d ON a.doctor_id = d.doctor_id;
/* OUTPUT:
# patient_name	doctor_name	diagnosis
Asha Rao	Dr. Meena Joshi	Check-up
Neha Singh	Dr. Meena Joshi	Chest Pain
Rohit Sharma	Dr. Ravi Das	Tooth Pain
Rahul Kumar	Dr. Arjun Rao	Headache
Sneha Patil	Dr. Priya Shetty	Skin Allergy
*/

-- Number of patients per doctor
SELECT d.doctor_name, COUNT(a.patient_id) AS Total_Patients
FROM Doctors d
JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_name;
/* OUTPUT:
# doctor_name	Total_Patients
Dr. Meena Joshi	2
Dr. Ravi Das	1
Dr. Arjun Rao	1
Dr. Priya Shetty	1
*/

DELIMITER //
CREATE PROCEDURE InsertAppointment(
    IN aid INT,
    IN pid INT,
    IN did INT,
    IN adate DATE,
    IN diag VARCHAR(50)
)
BEGIN
    INSERT INTO Appointments VALUES (aid, pid, did, adate, diag);
END //
DELIMITER ;

CALL InsertAppointment(6, 1, 104, '2024-08-01', 'Rash');

DELIMITER //
CREATE PROCEDURE UpdateDoctorFee(
    IN did INT,
    IN new_fee DECIMAL(10,2)
)
BEGIN
    UPDATE Doctors SET fees = new_fee WHERE doctor_id = did;
END //
DELIMITER ;

CALL UpdateDoctorFee(102, 600.00);