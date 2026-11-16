<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String selectedDate = request.getParameter("view_date");
    if (selectedDate == null || selectedDate.trim().isEmpty()) {
        selectedDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Attendance Records</title>
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

    <div class="main-container">
        <div class="card">
            <h2 class="card-title">Daily Attendance Sheet Report</h2>

            <form method="get" action="view_attendance.jsp" style="margin-bottom: 20px; display:flex; gap: 15px; align-items: center;">
                <label><b>Select Date:</b></label>
                <input type="date" name="view_date" value="<%= selectedDate %>" class="form-control" style="width: 200px;">
                <button type="submit" class="btn btn-primary">Filter Records</button>
                <button type="button" onclick="window.print()" class="btn" style="background-color: #4b5563; color: white; padding: 8px 16px; border: none; border-radius: 6px; font-weight: 600; cursor: pointer; margin-left: 8px;">
    🖨️ Print / Download PDF
</button>
            </form>

            <div class="table-responsive">
                <table class="custom-table">
                    <thead>
                        <tr>
                            <th>Roll No</th>
                            <th>Student Name</th>
                            <th>Department</th>
                            <th>Semester</th>
                            <th>Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_attendance_db?useSSL=false&allowPublicKeyRetrieval=true", "root", "");
                                
                                String sql = "SELECT s.roll_no, s.name, s.department, s.semester, a.att_date, a.status "
                                           + "FROM students s "
                                           + "LEFT JOIN attendance a ON s.student_id = a.student_id AND a.att_date = ? "
                                           + "ORDER BY s.roll_no ASC";
                                
                                PreparedStatement ps = con.prepareStatement(sql);
                                ps.setString(1, selectedDate);
                                ResultSet rs = ps.executeQuery();

                                int count = 0;
                                while(rs.next()) {
                                    count++;
                                    String status = rs.getString("status");
                                    if(status == null) status = "Not Marked";
                        %>
                        <tr>
                            <td><b><%= rs.getString("roll_no") %></b></td>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("department") %></td>
                            <td><%= rs.getString("semester") %></td>
                            <td><%= selectedDate %></td>
                            <td>
                                <% if ("Present".equalsIgnoreCase(status)) { %>
                                    <span class="badge-present">PRESENT</span>
                                <% } else if ("Absent".equalsIgnoreCase(status)) { %>
                                    <span class="badge-absent">ABSENT</span>
                                <% } else { %>
                                    <span style="color:#a0aec0; font-size:12px; font-style:italic;">NOT MARKED</span>
                                <% } %>
                            </td>
                        </tr>
                        <%
                                }
                                con.close();
                            } catch(Exception e) {
                                out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
                            }
                        %>
                    </tbody>
                </table>
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
