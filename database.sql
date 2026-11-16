-- Student Attendance System Database Script
-- WBSCTVESD Diploma 5th Sem Project

CREATE DATABASE IF NOT EXISTS student_attendance_db;
USE student_attendance_db;

-- 1. Users table (Admin/Teacher Login)
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
    full_name VARCHAR(100) NOT NULL
);

-- 2. Students table
CREATE TABLE IF NOT EXISTS students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    roll_no VARCHAR(20) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    semester VARCHAR(10) NOT NULL
);

-- 3. Attendance records table
CREATE TABLE IF NOT EXISTS attendance (
    att_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    att_date DATE NOT NULL,
    status ENUM('Present', 'Absent') NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    UNIQUE KEY unique_daily_att (student_id, att_date)
);

-- Insert Default Admin/Faculty
INSERT INTO users (username, password, full_name) VALUES 
('admin', 'admin123', 'Faculty Administrator')
ON DUPLICATE KEY UPDATE id=id;

-- Insert Sample CST Students
INSERT INTO students (roll_no, name, department, semester) VALUES 
('CST-501', 'Ivan Sarkar', 'CST', '5th'),
('CST-502', 'Rahul Das', 'CST', '5th'),
('CST-503', 'Sneha Roy', 'CST', '5th'),
('CST-504', 'Ankit Banerjee', 'CST', '5th'),
('CST-505', 'Priya Mondal', 'CST', '5th')
ON DUPLICATE KEY UPDATE student_id=student_id;
