<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Attendance System</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
    /* কার্ড এবং বাটনের স্মুথ অ্যানিমেশন */
    .card, .action-card, .stat-card {
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
    }
    .action-card:hover {
        transform: translateY(-6px) !important;
        box-shadow: 0 12px 24px rgba(0, 0, 0, 0.12) !important;
    }
    .btn, button, .action-card a {
        transition: all 0.2s ease !important;
    }
    .btn:hover, button:hover, .action-card a:hover {
        transform: scale(1.04);
        filter: brightness(1.1);
    }
    #liveClock {
        animation: pulseGlow 2s infinite alternate;
    }
    @keyframes pulseGlow {
        from { box-shadow: 0 0 2px rgba(255,255,255,0.2); }
        to { box-shadow: 0 0 8px rgba(255,255,255,0.6); }
    }
</style>
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

    <div class="main-container">
        <div class="card">
            <h2 class="card-title">Management Overview</h2>
            <%
                int totalStudents = 0;
                int totalPresentToday = 0;
                String todayDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_attendance_db?useSSL=false&allowPublicKeyRetrieval=true", "root", "");
                    
                    Statement st1 = con.createStatement();
                    ResultSet rs1 = st1.executeQuery("SELECT COUNT(*) AS total FROM students");
                    if (rs1.next()) totalStudents = rs1.getInt("total");

                    Statement st2 = con.createStatement();
                    ResultSet rs2 = st2.executeQuery("SELECT COUNT(*) AS total FROM attendance WHERE att_date = '" + todayDate + "' AND status = 'Present'");
                    if (rs2.next()) totalPresentToday = rs2.getInt("total");

                    con.close();
                } catch(Exception e) {
                    // ignore
                }
            %>
            <div style="display: flex; gap: 20px; margin-bottom: 20px;">
                <div style="flex:1; background: #ebf8ff; border: 1px solid #bee3f8; padding: 20px; border-radius: 8px;">
                    <h4 style="color: #2b6cb0;">Total Registered Students</h4>
                    <p style="font-size: 28px; font-weight: bold; color: #2c5282; margin-top: 5px;"><%= totalStudents %></p>
                </div>
                <div style="flex:1; background: #f0fff4; border: 1px solid #c6f6d5; padding: 20px; border-radius: 8px;">
                    <h4 style="color: #276749;">Present Today (<%= todayDate %>)</h4>
                    <p style="font-size: 28px; font-weight: bold; color: #22543d; margin-top: 5px;"><%= totalPresentToday %></p>
                </div>
               <div style="flex: 1; background: #fff1f2; border: 1px solid #fecdd3; padding: 20px; border-radius: 8px;">
    <h4 style="color: #e11d48; margin: 0;">Absent Today</h4>
    <p id="absentCountText" style="font-size: 28px; font-weight: bold; color: #be123c; margin-top: 5px; margin-bottom: 0;">
        1
    </p>
</div>
            </div>
        </div>

        <div class="grid-cards">
            <div class="action-card">
                <h3>📝 Mark Daily Attendance</h3>
                <p>Record daily student presence quickly with one-click bulk status options.</p>
                <a href="take_attendance.jsp" class="btn btn-primary">Take Attendance</a>
            </div>
            <div class="action-card">
                <h3>📊 View Reports</h3>
                <p>Filter attendance history by date and analyze student attendance sheets.</p>
                <a href="view_attendance.jsp" class="btn btn-primary">View Records</a>
            </div>
            <div class="action-card">
                <h3>👤 Add New Student</h3>
                <p>Register new diploma students into the database system.</p>
                <a href="add_student.jsp" class="btn btn-success">Add Student</a>
            </div>
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
