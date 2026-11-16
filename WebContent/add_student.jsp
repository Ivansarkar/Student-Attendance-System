<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String msg = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String roll = request.getParameter("roll_no");
        String name = request.getParameter("name");
        String dept = request.getParameter("department");
        String sem = request.getParameter("semester");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_attendance_db?useSSL=false&allowPublicKeyRetrieval=true", "root", "");
            
            PreparedStatement ps = con.prepareStatement("INSERT INTO students (roll_no, name, department, semester) VALUES (?, ?, ?, ?)");
            ps.setString(1, roll);
            ps.setString(2, name);
            ps.setString(3, dept);
            ps.setString(4, sem);
            
            ps.executeUpdate();
            con.close();
            msg = "<div style='color:green; margin-bottom:15px;'>Student Registered Successfully!</div>";
        } catch(Exception e) {
            msg = "<div style='color:red; margin-bottom:15px;'>Error: " + e.getMessage() + "</div>";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Student</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <div class="navbar">
        <div class="brand">🏛️ CST Department | Student Attendance Portal</div>
        <div class="nav-links">
            <span id="liveClock" style="margin-right: 15px; background: rgba(255,255,255,0.15); padding: 5px 12px; border-radius: 20px; font-size: 0.85rem; color: #f1f5f9; font-weight: 500;"></span>
<span style="margin-right: 15px; color: white;">Welcome, <b><%= session.getAttribute("user") != null ? session.getAttribute("user") : "Admin" %></b></span>
            <a href="dashboard.jsp">Dashboard</a>
            <a href="take_attendance.jsp">Take Attendance</a>
            <a href="view_attendance.jsp">View Records</a>
            <a href="add_student.jsp">Add Student</a>
            <a href="logout.jsp" class="logout-btn">Logout</a>
        </div>
    </div>

    <div class="main-container" style="max-width: 600px;">
        <div class="card">
            <h2 class="card-title">Register New Student</h2>
            <%= msg %>

            <form method="post" action="add_student.jsp">
                <div class="form-group">
                    <label>Roll Number / Enrollment No</label>
                    <input type="text" name="roll_no" class="form-control" placeholder="Enter Roll Number" required>
                </div>

                <div class="form-group">
                    <label>Student Full Name</label>
                    <input type="text" name="name" class="form-control" placeholder="Enter Student Full Name" required>
                </div>

                <div class="form-group">
                    <label>Department</label>
                    <select name="department" class="form-control" required>
                        <option value="CST">Computer Science & Technology (CST)</option>
                        <option value="RE">RE (Renewable Energy Engineering)</option>
                        <option value="IT">Information Technology (IT)</option>
                        <option value="ETCE">ETCE</option>
                        <option value="EE">Electrical Engg</option>
                        <option value="ME">Mechanical Engg</option>
                        <option value="CE">Civil Engg</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Semester</label>
                    <select name="semester" class="form-control" required>
                        <option value="1st">1st Sem</option>
                        <option value="2nd">2nd Sem</option>
                        <option value="3rd">3rd Sem</option>
                        <option value="4th">4th Sem</option>
                        <option value="5th" selected>5th Sem</option>
                        <option value="6th">6th Sem</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary btn-block" style="margin-top: 10px;">Register Student</button>
            </form>
        </div>
    </div>
    <script>
function updateClock() {
    const now = new Date();
    const options = { hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: true };
    const el = document.getElementById('liveClock');
    if (el) el.innerHTML = '🕒 ' + now.toLocaleTimeString('en-US', options);
}
setInterval(updateClock, 1000);
updateClock();
</script>
<footer style="margin-top: 40px; text-align: center; padding: 20px; color: #64748b; font-size: 0.85rem; border-top: 1px solid #e2e8f0; background: #ffffff;">
    <b>Department of Computer Science & Technology</b> | Sir Rajendra Nath Mukherjee Government Polytechnic<br>
    <span style="color: #94a3b8;">Major Academic Project © 2026 CST Attendance Management System</span>
</footer>
</body>
</html>
