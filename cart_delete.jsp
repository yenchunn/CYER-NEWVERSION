<%@ page import="java.sql.*" %>

<%
int p_id = Integer.parseInt(request.getParameter("p_id"));
Integer memberId = (Integer) session.getAttribute("m_id");

if (memberId == null) {
    response.sendRedirect("login.jsp");
    return;
}

Connection conn = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/cyer?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Taipei",
    "root",
    "1234"
);

PreparedStatement ps = conn.prepareStatement(
    "DELETE FROM cart WHERE member_id = ? AND p_id = ?"
);

ps.setInt(1, memberId);
ps.setInt(2, p_id);
ps.executeUpdate();

conn.close();

response.sendRedirect("shopping_cart.jsp");
%>