<%@ page import="java.sql.*" %>

<html>
<head>
    <title>加入購物車</title>
</head>

<body>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
request.setCharacterEncoding("UTF-8");

Integer memberId = (Integer) session.getAttribute("m_id");

if (memberId == null) {
    response.sendRedirect("login.jsp");
    return;
}
int p_id = Integer.parseInt(request.getParameter("p_id"));

Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    // 1. JDBC Driver
    Class.forName("com.mysql.cj.jdbc.Driver");

    // 2. 連線
    conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/cyer?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Taipei",
        "root",
        "1234"   
    );

        String sql =
        "INSERT INTO cart(member_id, p_id, quantity) " +
        "VALUES (?, ?, 1) " +
        "ON DUPLICATE KEY UPDATE quantity = quantity + 1";

    ps = conn.prepareStatement(sql);
    ps.setInt(1, memberId);
    ps.setInt(2, p_id);
    ps.executeUpdate();

    response.sendRedirect("shopping_cart.jsp");

} catch(Exception e) {
    out.println(e.getMessage());
} finally {
    if (ps != null) ps.close();
    if (conn != null) conn.close();
}
%>

    String sql =
    "INSERT INTO cart(member_id, p_id, quantity) " +
    "VALUES (?, ?, 1) " +
    "ON DUPLICATE KEY UPDATE quantity = quantity + 1";

    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setInt(1, memberId);
    ps.setInt(2, p_id);
    ps.executeUpdate();

    // 5. 回購物車頁
    response.sendRedirect("shopping_cart.jsp");

} catch(Exception e) {
    out.println("錯誤：" + e.getMessage());
} finally {
    if (rs != null) rs.close();
    if (ps != null) ps.close();
    if (conn != null) conn.close();
}
%>

</body>
</html>
