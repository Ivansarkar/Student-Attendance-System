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
    <title>Take Attendance</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/script.js"></script>
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
            <h2 class="card-title">Mark Student Attendance</h2>
            
            <form action="save_attendance.jsp" method="post">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <label><b>Attendance Date:</b></label>
                        <input type="date" name="att_date" id="attDate" class="form-control" style="width: 200px;" required>
                    </div>
                    <div>
                        <button type="button" class="btn btn-primary" onclick="markAll('Present')" style="padding: 6px 12px; font-size: 13px;">All Present</button>
                        <button type="button" class="btn btn-danger" onclick="markAll('Absent')" style="padding: 6px 12px; font-size: 13px; background:#e53e3e; color:white; border:none; border-radius:4px; cursor:pointer;">All Absent</button>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="custom-table">
                        <thead>
                            <tr>
                                <th style="width: 15%;">Roll No</th>
                                <th style="width: 35%;">Student Name</th>
                                <th style="width: 20%;">Department & Sem</th>
                                <th style="width: 30%;">Attendance Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_attendance_db?useSSL=false&allowPublicKeyRetrieval=true", "root", "");
                                    Statement stmt = con.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT * FROM students ORDER BY roll_no ASC");

                                    int count = 0;
                                    while(rs.next()) {
                                        count++;
                                        int sId = rs.getInt("student_id");
                            %>
                            <tr>
                                <td><b><%= rs.getString("roll_no") %></b></td>
                                <td><%= rs.getString("name") %></td>
                                <td><%= rs.getString("department") %> (<%= rs.getString("semester") %>)</td>
                                <td>
                                    <input type="hidden" name="student_ids" value="<%= sId %>">
                                    <label class="radio-label">
                                        <input type="radio" name="status_<%= sId %>" value="Present" checked> Present
                                    </label>
                                    <label class="radio-label">
                                        <input type="radio" name="status_<%= sId %>" value="Absent"> Absent
                                    </label>
                                </td>
                            </tr>
                            <%
                                    }
                                    if(count == 0) {
                            %>
                            <tr>
                                <td colspan="4" style="text-align: center; color: #718096; padding: 20px;">No students found! Please add students first.</td>
                            </tr>
                            <%
                                    }
                                    con.close();
                                } catch(Exception e) {
                                    out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
                                }
                            %>
                        </tbody>
                    </table>
                </div>

                <div style="margin-top: 25px; text-align: right;">
                    <button type="submit" class="btn btn-success" style="padding: 12px 30px; font-size: 16px;">💾 Save Attendance Sheet</button>
                </div>
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
