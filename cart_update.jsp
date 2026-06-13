<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");

String action = request.getParameter("action");
int p_id = 0;
try {
    p_id = Integer.parseInt(request.getParameter("p_id"));
} catch (Exception e) {
    response.sendRedirect("shopping_cart.jsp");
    return;
}

Integer memberId = (Integer) session.getAttribute("m_id");

if (memberId == null) {
    response.sendRedirect("login.jsp");
    return;
}

Class.forName("com.mysql.cj.jdbc.Driver");

try (Connection conn = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/cyer?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Taipei",
    "root",
    "1234"
)) {
    if ("add".equals(action)) {
        String sql =
            "UPDATE cart c JOIN products p ON c.p_id = p.p_id " +
            "SET c.quantity = c.quantity + 1 " +
            "WHERE c.member_id = ? AND c.p_id = ? AND p.is_active = 1 AND c.quantity < p.p_stock";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, memberId);
            ps.setInt(2, p_id);
            ps.executeUpdate();
        }
    } else if ("minus".equals(action)) {
        int quantity = 0;
        try (PreparedStatement ps = conn.prepareStatement(
                 "SELECT quantity FROM cart WHERE member_id=? AND p_id=?")) {
            ps.setInt(1, memberId);
            ps.setInt(2, p_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    quantity = rs.getInt("quantity");
                }
            }
        }

        String sql = quantity <= 1
            ? "DELETE FROM cart WHERE member_id=? AND p_id=?"
            : "UPDATE cart SET quantity = quantity - 1 WHERE member_id=? AND p_id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, memberId);
            ps.setInt(2, p_id);
            ps.executeUpdate();
        }
    }
}

response.sendRedirect("shopping_cart.jsp");
%>
