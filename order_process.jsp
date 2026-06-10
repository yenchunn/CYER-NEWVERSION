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
    // STEP 0：檢查購物車是否為空
    // =========================
    PreparedStatement checkPs = conn.prepareStatement(
        "SELECT COUNT(*) FROM cart WHERE member_id = ?"
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
    // STEP 1：讀購物車（去重 SUM）
    // =========================
    String cartSql =
        "SELECT c.p_id, SUM(c.quantity) AS quantity, p.p_price " +
        "FROM cart c JOIN products p ON c.p_id = p.p_id " +
        "WHERE c.member_id = ? " +
        "GROUP BY c.p_id, p.p_price";

    PreparedStatement cartPs = conn.prepareStatement(cartSql);
    cartPs.setInt(1, memberId);

    ResultSet cartRs = cartPs.executeQuery();

    int total = 0;
    // =========================
    // STEP 2：計算總價
    // =========================
    while (cartRs.next()) {
        total += cartRs.getInt("p_price") * cartRs.getInt("quantity");
    }

    // reset cursor（MySQL 不一定支援，所以直接重查）
    cartRs.close();
    cartPs.close();

    // 重新查一次（給 step3/4 用）
    cartPs = conn.prepareStatement(cartSql);
    cartPs.setInt(1, memberId);
    cartRs = cartPs.executeQuery();

    // =========================
    // STEP 3：建立訂單
    // =========================
    PreparedStatement orderPs = conn.prepareStatement(
        "INSERT INTO orders(m_id, o_date, o_total_price, o_shupping, o_address, o_payment, o_status) " +
        "VALUES (?, NOW(), ?, '宅配', ?, '貨到付款', '已成立')",
        Statement.RETURN_GENERATED_KEYS
    );

    orderPs.setInt(1, memberId);
    orderPs.setInt(2, total);
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
    // STEP 4：寫 order_items + 扣庫存
    // =========================
    while (cartRs.next()) {

        int pid = cartRs.getInt("p_id");
        int qty = cartRs.getInt("quantity");
        int price = cartRs.getInt("p_price");

        // order_items
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

        // 扣庫存（防超賣）
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
    // STEP 5：清空購物車
    // =========================
    PreparedStatement clearPs = conn.prepareStatement(
        "DELETE FROM cart WHERE member_id = ?"
    );

    clearPs.setInt(1, memberId);
    clearPs.executeUpdate();
    clearPs.close();

    // =========================
    // STEP 6：導向訂單頁
    // =========================
    response.sendRedirect("support.jsp?tab=order");

} catch(Exception e) {
    out.println("錯誤：" + e.getMessage());
} finally {
    if (conn != null) conn.close();
}
%>