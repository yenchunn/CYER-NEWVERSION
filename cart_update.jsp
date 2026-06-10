<%@ page import="java.sql.*" %>

<%
request.setCharacterEncoding("UTF-8");

String action = request.getParameter("action");
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

PreparedStatement ps = null;
ResultSet rs = null;   // ⭐⭐⭐ 就放這裡

if ("add".equals(action)) {

    ps = conn.prepareStatement(
        "UPDATE cart SET quantity = quantity + 1 WHERE member_id = ? AND p_id = ?"
    );
    ps.setInt(1, memberId);
    ps.setInt(2, p_id);
    ps.executeUpdate();

} else if ("minus".equals(action)) {

    ps = conn.prepareStatement(
        "SELECT quantity FROM cart WHERE member_id=? AND p_id=?"
    );
    ps.setInt(1, memberId);
    ps.setInt(2, p_id);
    rs = ps.executeQuery();

    if (rs.next() && rs.getInt("quantity") <= 1) {

        ps = conn.prepareStatement(
            "DELETE FROM cart WHERE member_id=? AND p_id=?"
        );

    } else {

        ps = conn.prepareStatement(
            "UPDATE cart SET quantity = quantity - 1 WHERE member_id=? AND p_id=?"
        );
    }

    ps.setInt(1, memberId);
    ps.setInt(2, p_id);
    ps.executeUpdate();
}

if (rs != null) rs.close();
if (ps != null) ps.close();
conn.close();

response.sendRedirect("shopping_cart.jsp");
%>