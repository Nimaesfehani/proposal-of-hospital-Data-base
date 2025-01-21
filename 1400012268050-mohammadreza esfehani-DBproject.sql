DROP DATABASE IF EXISTS Hospital;
CREATE DATABASE Hospital;
USE Hospital;

CREATE TABLE Doctor (
    Doctor_ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Experience INT NOT NULL,
    Status ENUM('On Duty', 'Off Duty') NOT NULL
);

-- Creating the PATIENT table
CREATE TABLE Patient (
    Patient_ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Status ENUM('Active', 'Inactive') NOT NULL,
    Health_Condition VARCHAR(255) NOT NULL,
    Admission_Status ENUM('Admitted', 'Discharged') NOT NULL,
    Doctor_ID INT,
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID)
);

-- Creating the MEDICAL_RECORD table
CREATE TABLE Medical_Record (
    Record_ID INT PRIMARY KEY,
    Patient_ID INT UNIQUE,
    Diagnosis TEXT NOT NULL,
    Treatment_Plan TEXT NOT NULL,
    Prescription_Details TEXT NOT NULL,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);

-- Creating the NURSE table
CREATE TABLE Nurse (
    Nurse_ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Shift ENUM('Morning', 'Evening', 'Night') NOT NULL
);

-- Creating the HOSPITAL_STAFF table
CREATE TABLE Hospital_Staff (
    Staff_ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Role VARCHAR(255) NOT NULL
);

-- Creating the INSURANCE table
CREATE TABLE Insurance (
    Insurance_ID INT PRIMARY KEY,
    Provider VARCHAR(255) NOT NULL,
    Coverage_Details TEXT NOT NULL
);


-- Creating the BILLING table
CREATE TABLE Billing (
    Bill_ID INT PRIMARY KEY,
    Patient_ID INT,
    Amount DECIMAL(10,2) NOT NULL,
    Payment_Status ENUM('Covered', 'Paid', 'Pending') NOT NULL,
    Insurance_ID INT,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Insurance_ID) REFERENCES Insurance(Insurance_ID)
);

-- Creating the APPOINTMENT table
CREATE TABLE Appointment (
    Appointment_ID INT PRIMARY KEY,
    Patient_ID INT,
    Doctor_ID INT,
    Scheduled_Date DATE NOT NULL,
    Status ENUM('Scheduled', 'Completed', 'Cancelled') NOT NULL,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID)
);

-- Creating the PRESCRIPTION table
CREATE TABLE Prescription (
    Prescription_ID INT PRIMARY KEY,
    Doctor_ID INT,
    Patient_ID INT,
    Medication_Details TEXT NOT NULL,
    Date_Issued DATE NOT NULL,
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);

-- Creating the VISIT table
CREATE TABLE Visit (
    Visit_ID INT PRIMARY KEY,
    Patient_ID INT,
    Doctor_ID INT,
    Nurse_ID INT,
    Visit_Date DATE NOT NULL,
    Treatment_Details TEXT NOT NULL,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID),
    FOREIGN KEY (Nurse_ID) REFERENCES Nurse(Nurse_ID)
);

-- Creating RELATIONSHIPS
-- Doctors can issue multiple prescriptions
ALTER TABLE Prescription ADD CONSTRAINT FK_Doctor_Prescription FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID);

-- Patients can have multiple appointments
ALTER TABLE Appointment ADD CONSTRAINT FK_Patient_Appointment FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID);

-- Nurses and staff can assist in multiple visits
ALTER TABLE Visit ADD CONSTRAINT FK_Nurse_Visit FOREIGN KEY (Nurse_ID) REFERENCES Nurse(Nurse_ID);
