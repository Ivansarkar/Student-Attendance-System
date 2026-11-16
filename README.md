# 🎓 Student Attendance Management System (JSP + MySQL + HTML/CSS/JS)

**West Bengal State Council of Technical & Vocational Education and Skill Development (WBSCTVESD)**  
*Diploma in Computer Science & Technology (CST) — 5th Semester Major Lab Project (Topic 01)*

---

## 📌 Project Overview
A full-stack, web-based **Student Attendance Management System** developed using **Java Server Pages (JSP), JDBC, MySQL, HTML5, CSS3, and JavaScript**. Designed to streamline daily classroom attendance tracking, multi-department student registration, and printable report generation.

### ✨ Key Features
1. **Secure Admin Authentication:** Session-based login and logout system (`login_process.jsp` / `logout.jsp`).
2. **Real-Time Interactive Dashboard:** Displays live counts of registered students and daily attendance statistics (`dashboard.jsp`).
3. **Smart Daily Attendance Entry (`take_attendance.jsp`):**
   - Interactive date picker with live system clock.
   - One-click batch selection (**All Present** / **All Absent**) powered by JavaScript (`script.js`).
   - Single-click batch synchronization with the MySQL database (`save_attendance.jsp`).
4. **Attendance History & Printable Reports (`view_attendance.jsp`):** Filter historical attendance records by date with clean status badges and built-in **Print / Download PDF** support.
5. **Multi-Department Student Registration (`add_student.jsp`):** Register students with Roll Number, Name, Semester, and Department (supports **CST**, **RE - Renewable Energy Engineering**, and more).

---

## 📂 Project Structure
```text
Student_Attendance_System/
├── WebContent/
│   ├── css/
│   │   └── style.css              # Custom UI & Responsive Styling
│   ├── js/
│   │   └── script.js              # Batch Attendance & UI Interactivity
│   ├── WEB-INF/
│   │   ├── lib/
│   │   │   └── mysql-connector-j-8.0.33.jar
│   │   └── web.xml
│   ├── add_student.jsp            # Student Registration Form
│   ├── dashboard.jsp              # Main Admin Dashboard
│   ├── index.jsp                  # Portal Login Page
│   ├── login_process.jsp          # Authentication Handler
│   ├── logout.jsp                 # Session Termination
│   ├── save_attendance.jsp        # Batch Attendance Database Saver
│   ├── take_attendance.jsp        # Daily Attendance Marking Sheet
│   └── view_attendance.jsp        # Date-wise Reports & PDF Export
├── database.sql                   # Complete MySQL Schema & Default Admin Setup
└── README.md                      # Project Documentation
```

---

## 🚀 Step-by-Step Setup & Installation Guide

### Step 1: Database Setup (MySQL / XAMPP)
1. Open **XAMPP Control Panel** and start **Apache** and **MySQL**.
2. Open your browser and navigate to `http://localhost/phpmyadmin/`.
3. Go to the **Import** tab, select `database.sql` from this repository, and click **Go** (or copy-paste the SQL script into the **SQL** tab and execute it).
   - *This creates the `student_attendance_db` database along with `users`, `students`, and `attendance` tables.*

### Step 2: Server & IDE Configuration

#### Option A: Using VS Code (Community Server Connector)
1. Open the `Student_Attendance_System` folder in **VS Code**.
2. Install the **Community Server Connectors** extension.
3. Expand the **Servers** panel in the bottom-left sidebar, right-click **Apache Tomcat 9.0**, and deploy `WebContent`.
4. Start the server and wait for `Server startup in [X] ms` in the Output console.
5. Open: `http://localhost:8080/WebContent/index.jsp`

#### Option B: Using Eclipse IDE (Recommended for Lab Exam)
1. Open **Eclipse IDE for Enterprise Java and Web Developers**.
2. Create a **Dynamic Web Project** named `StudentAttendanceSystem` with **Apache Tomcat v9.0** as Target Runtime.
3. Copy all contents of `WebContent/` into the project's `src/main/webapp/` (or `WebContent/`) directory.
4. Ensure `mysql-connector-j-8.0.33.jar` is present inside `WEB-INF/lib/`.
5. Right-click the project -> **Run As -> Run on Server**.
6. Open: `http://localhost:8080/StudentAttendanceSystem/index.jsp`

#### Option C: Direct Tomcat `webapps` Deployment
1. Copy the `WebContent` folder, rename it to `StudentAttendanceSystem`, and paste it inside `Tomcat 9.0/webapps/`.
2. Start Tomcat via `startup.bat` and access `http://localhost:8080/StudentAttendanceSystem/index.jsp`.

---

## 🔐 Default Login Credentials
- **Username:** `admin`
- **Password:** `admin123`

---

## 🛠️ Tech Stack
- **Frontend:** HTML5, CSS3 (`style.css`), Vanilla JavaScript (`script.js`)
- **Backend:** Java Server Pages (JSP), JDBC
- **Database:** MySQL (MariaDB via XAMPP)
- **Web Server:** Apache Tomcat 9.0.41

---

## 🔧 Common Troubleshooting
- **Port 3306 in use / MySQL fails to start:** Open Windows Task Manager (`Ctrl + Shift + Esc`), locate `mysqld.exe`, click **End Task**, and restart MySQL from XAMPP.
- **Database Connection Failure:** Ensure MySQL is running on port `3306` with default username `root` and blank password `""` (or update credentials in your JSP connection blocks).

---

## 👨‍💻 Author
**Ivan Sarkar**  
Diploma in Computer Science & Technology (CST)  
*Sir Rajendra Nath Mukherjee Government Polytechnic*