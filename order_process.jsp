<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");

Integer memberId = (Integer) session.getAttribute("m_id");
String address = request.getParameter("address");
String payment = request.getParameter("payment");

if (memberId == null) {
    response.sendRedirect("login.jsp");
    return;
}

Connection conn = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/cyer?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Taipei&useSSL=false",
        "root",
        "1234"
    );

    // =========================
    // 檢查購物車是否為空
    // =========================
    PreparedStatement checkPs = conn.prepareStatement(
        "SELECT COUNT(*) FROM cart c JOIN products p ON c.p_id = p.p_id WHERE c.member_id = ? AND p.is_active = 1"
    );
    checkPs.setInt(1, memberId);

    ResultSet checkRs = checkPs.executeQuery();
    checkRs.next();

    if (checkRs.getInt(1) == 0) {
        response.sendRedirect("shopping_cart.jsp?msg=empty");
        return;
    }

    checkRs.close();
    checkPs.close();

    // =========================
    // 讀購物車
    // =========================
    String cartSql =
        "SELECT c.p_id, SUM(c.quantity) AS quantity, p.p_price, p.p_stock " +
        "FROM cart c JOIN products p ON c.p_id = p.p_id " +
        "WHERE c.member_id = ? AND p.is_active = 1 " +
        "GROUP BY c.p_id, p.p_price, p.p_stock";

    PreparedStatement cartPs = conn.prepareStatement(cartSql);
    cartPs.setInt(1, memberId);

    ResultSet cartRs = cartPs.executeQuery();

    int total = 0;
    // =========================
    // 計算總價，加入會員滿萬折千優惠
    // =========================
    while (cartRs.next()) {
        if (cartRs.getInt("quantity") > cartRs.getInt("p_stock")) {
            response.sendRedirect("shopping_cart.jsp?msg=stock");
            return;
        }
        total += cartRs.getInt("p_price") * cartRs.getInt("quantity");
    }

    // 宣告並計算折扣
    int discount = 0; 
    if (total >= 10000) {
        discount = (total / 10000) * 1000; 
    }
    int finalTotal = total - discount; // 折抵後的最終應付總額

    // reset cursor
    cartRs.close();
    cartPs.close();

    // 用明細與扣庫存
    cartPs = conn.prepareStatement(cartSql);
    cartPs.setInt(1, memberId);
    cartRs = cartPs.executeQuery();

    // =========================
    // 建立訂單（已完美融合滿萬折千 finalTotal）
    // =========================
    PreparedStatement orderPs = conn.prepareStatement(
        "INSERT INTO orders(m_id, o_date, o_total_price, o_shupping, o_address, o_payment, o_status) " +
        "VALUES (?, NOW(), ?, '宅配', ?, '貨到付款', '已成立')",
        Statement.RETURN_GENERATED_KEYS
    );

    orderPs.setInt(1, memberId);
    orderPs.setInt(2, finalTotal); // 精準寫入折扣後的實付金額
    orderPs.setString(3, address);

    orderPs.executeUpdate();

    ResultSet orderRs = orderPs.getGeneratedKeys();

    int orderId = 0;
    if (orderRs.next()) {
        orderId = orderRs.getInt(1);
    }

    orderRs.close();
    orderPs.close();

    // =========================
    // 寫 order_items + 扣庫存
    // =========================
    while (cartRs.next()) {

        int pid = cartRs.getInt("p_id");
        int qty = cartRs.getInt("quantity");
        int price = cartRs.getInt("p_price");

        // 寫入訂單明細
        PreparedStatement itemPs = conn.prepareStatement(
            "INSERT INTO orders_items(o_id, p_id, item_quantity, item_unit_price) " +
            "VALUES (?, ?, ?, ?)"
        );

        itemPs.setInt(1, orderId);
        itemPs.setInt(2, pid);
        itemPs.setInt(3, qty);
        itemPs.setInt(4, price);
        itemPs.executeUpdate();
        itemPs.close();

        // 扣庫存，防超賣
        PreparedStatement stockPs = conn.prepareStatement(
            "UPDATE products SET p_stock = p_stock - ? " +
            "WHERE p_id = ? AND p_stock >= ?"
        );

        stockPs.setInt(1, qty);
        stockPs.setInt(2, pid);
        stockPs.setInt(3, qty);
        stockPs.executeUpdate();
        stockPs.close();
    }

    cartRs.close();
    cartPs.close();

    // =========================
    // 清空購物車
    // =========================
    PreparedStatement clearPs = conn.prepareStatement(
        "DELETE FROM cart WHERE member_id = ?"
    );

    clearPs.setInt(1, memberId);
    clearPs.executeUpdate();
    clearPs.close();

    // =========================
    // 導向歷史訂單查詢頁面
    // =========================
    response.sendRedirect("support.jsp?tab=order");

} catch(Exception e) {
    out.println("錯誤：" + e.getMessage());
} finally {
    if (conn != null) conn.close();
}
%>
