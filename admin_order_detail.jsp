<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="admin_auth.jsp" %>
<%
    int orderId = 0;
    try { orderId = Integer.parseInt(request.getParameter("o_id")); } catch (Exception ignored) {}
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head><meta charset="UTF-8"><title>訂單明細</title></head>
<body>
<%@ include file="admin_header.jsp" %>
<main class="admin-shell">
  <div class="panel">
    <h1>訂單明細 #<%= orderId %></h1>
<%
    String orderSql = "SELECT o.o_id, o.m_id, m.m_email, o.o_date, o.o_total_price, o.o_status, o.o_address, o.o_payment, o.o_shupping " +
                      "FROM orders o JOIN members m ON o.m_id = m.m_id WHERE o.o_id = ?";
    try (Connection conn = getConnection();
         PreparedStatement orderPs = conn.prepareStatement(orderSql)) {
        orderPs.setInt(1, orderId);
        try (ResultSet orderRs = orderPs.executeQuery()) {
            if (orderRs.next()) {
%>
    <p>會員：<%= h(orderRs.getString("m_email")) %> (ID: <%= orderRs.getInt("m_id") %>)</p>
    <p>日期：<%= orderRs.getTimestamp("o_date") %>　狀態：<%= h(orderRs.getString("o_status")) %></p>
    <p>付款：<%= h(orderRs.getString("o_payment")) %>　配送：<%= h(orderRs.getString("o_shupping")) %></p>
    <p>地址：<%= h(orderRs.getString("o_address")) %></p>
    <table>
      <thead><tr><th>商品名稱</th><th>購買數量</th><th>單價</th><th>小計</th></tr></thead>
      <tbody>
<%
                String itemSql = "SELECT COALESCE(p.p_name, '商品資料不存在') AS p_name, oi.item_quantity, oi.item_unit_price " +
                                 "FROM orders_items oi LEFT JOIN products p ON oi.p_id = p.p_id WHERE oi.o_id = ? ORDER BY oi.item_id";
                try (PreparedStatement itemPs = conn.prepareStatement(itemSql)) {
                    itemPs.setInt(1, orderId);
                    try (ResultSet itemRs = itemPs.executeQuery()) {
                        boolean hasItem = false;
                        while (itemRs.next()) {
                            hasItem = true;
                            int qty = itemRs.getInt("item_quantity");
                            int price = itemRs.getInt("item_unit_price");
%>
        <tr>
          <td><%= h(itemRs.getString("p_name")) %></td>
          <td><%= qty %></td>
          <td>NT$ <%= price %></td>
          <td>NT$ <%= qty * price %></td>
        </tr>
<%
                        }
                        if (!hasItem) {
%>
        <tr><td colspan="4">此訂單沒有明細。</td></tr>
<%
                        }
                    }
                }
%>
      </tbody>
    </table>
    <p><strong>訂單總金額：NT$ <%= orderRs.getInt("o_total_price") %></strong></p>
<%
            } else {
%>
    <div class="message">查無此訂單。</div>
<%
            }
        }
    } catch (Exception e) {
%>
    <div class="message"><%= h(e.getMessage()) %></div>
<%
    }
%>
    <a class="btn secondary" href="admin_orders.jsp">回訂單列表</a>
  </div>
</main>
</body>
</html>
