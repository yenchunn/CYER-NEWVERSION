<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
response.setContentType("text/html; charset=UTF-8");
response.setCharacterEncoding("UTF-8");

Integer memberId = (Integer) session.getAttribute("m_id");



if (memberId == null) {

    response.sendRedirect("login.jsp");

    return;

}



Connection conn = null;

PreparedStatement ps = null;

ResultSet rs = null;



int total = 0;



try {

    Class.forName("com.mysql.cj.jdbc.Driver");



    conn = DriverManager.getConnection(

        "jdbc:mysql://localhost:3306/cyer?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Taipei&useSSL=false",

        "root",

        "1234"

    );



    // 1. 取得購物車

    String cartSql =

        "SELECT c.p_id, p.p_price, c.quantity " +

        "FROM cart c JOIN products p ON c.p_id = p.p_id " +

        "WHERE c.member_id = ?";



    ps = conn.prepareStatement(cartSql);

    ps.setInt(1, memberId);

    rs = ps.executeQuery();



    // 2. 計算總價

    while (rs.next()) {

        total += rs.getInt("p_price") * rs.getInt("quantity");

    }



    rs.close();

    ps.close();



    // 3. 建立訂單

    String orderSql =

        "INSERT INTO orders(m_id, o_date, o_total_price, o_shupping, o_address, o_payment, o_status) " +

        "VALUES (?, NOW(), ?, '宅配', '', '現金', '已成立')";



    ps = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);

    ps.setInt(1, memberId);

    ps.setInt(2, total);

    ps.executeUpdate();



    rs = ps.getGeneratedKeys();

    int orderId = 0;



    if (rs.next()) {

        orderId = rs.getInt(1);

    }



    rs.close();

    ps.close();



    // 4. 寫入 order_items

    String itemSql =

        "SELECT c.p_id, c.quantity, p.p_price " +

        "FROM cart c JOIN products p ON c.p_id = p.p_id " +

        "WHERE c.member_id = ?";



    ps = conn.prepareStatement(itemSql);

    ps.setInt(1, memberId);

    rs = ps.executeQuery();



    while (rs.next()) {



        String insertItem =

            "INSERT INTO orders_items(o_id, p_id, item_quantity, item_unit_price) " +

            "VALUES (?, ?, ?, ?)";



        PreparedStatement ps2 = conn.prepareStatement(insertItem);

        ps2.setInt(1, orderId);

        ps2.setInt(2, rs.getInt("p_id"));

        ps2.setInt(3, rs.getInt("quantity"));

        ps2.setInt(4, rs.getInt("p_price"));

        ps2.executeUpdate();

        ps2.close();

    }



    rs.close();

    ps.close();



    // 5. 清空購物車

    String clearSql = "DELETE FROM cart WHERE member_id = ?";

    ps = conn.prepareStatement(clearSql);

    ps.setInt(1, memberId);

    ps.executeUpdate();



    // 6. 導向訂單查詢

    response.sendRedirect("support.jsp?tab=order");



} catch(Exception e) {

    out.println("錯誤：" + e.getMessage());

} finally {

    if (conn != null) conn.close();

}

%>
