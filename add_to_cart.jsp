<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");

Integer memberId = (Integer) session.getAttribute("m_id");
if (memberId == null) {
    response.sendRedirect("login.jsp");
    return;
}

int p_id = 0;
int quantity = 1;
try {
    p_id = Integer.parseInt(request.getParameter("p_id"));
    String quantityParam = request.getParameter("quantity");
    if (quantityParam != null && quantityParam.trim().length() > 0) {
        quantity = Integer.parseInt(quantityParam.trim());
    }
} catch (Exception e) {
    response.sendRedirect("product_detail.jsp?p_id=" + p_id + "&cart_error=invalid");
    return;
}

if (p_id <= 0 || quantity <= 0) {
    response.sendRedirect("product_detail.jsp?p_id=" + p_id + "&cart_error=invalid");
    return;
}

Connection conn = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/cyer?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Taipei",
        "root",
        "1234"
    );

    int stock = 0;
    int cartQuantity = 0;

    try (PreparedStatement stockPs = conn.prepareStatement(
             "SELECT p_stock FROM products WHERE p_id = ? AND is_active = 1")) {
        stockPs.setInt(1, p_id);
        try (ResultSet stockRs = stockPs.executeQuery()) {
            if (!stockRs.next()) {
                response.sendRedirect("product_detail.jsp?p_id=" + p_id + "&cart_error=notfound");
                return;
            }
            stock = stockRs.getInt("p_stock");
        }
    }

    try (PreparedStatement cartPs = conn.prepareStatement(
             "SELECT quantity FROM cart WHERE member_id = ? AND p_id = ?")) {
        cartPs.setInt(1, memberId);
        cartPs.setInt(2, p_id);
        try (ResultSet cartRs = cartPs.executeQuery()) {
            if (cartRs.next()) {
                cartQuantity = cartRs.getInt("quantity");
            }
        }
    }

    if (quantity + cartQuantity > stock) {
        response.sendRedirect("product_detail.jsp?p_id=" + p_id + "&cart_error=stock");
        return;
    }

    String sql =
        "INSERT INTO cart(member_id, p_id, quantity) " +
        "VALUES (?, ?, ?) " +
        "ON DUPLICATE KEY UPDATE quantity = quantity + ?";

    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, memberId);
        ps.setInt(2, p_id);
        ps.setInt(3, quantity);
        ps.setInt(4, quantity);
        ps.executeUpdate();
    }

    response.sendRedirect("shopping_cart.jsp");

} catch(Exception e) {
    out.println(e.getMessage());
} finally {
    if (conn != null) conn.close();
}
%>
