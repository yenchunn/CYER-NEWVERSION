<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="admin_auth.jsp" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head><meta charset="UTF-8"><title>訂單管理</title></head>
<body>
<%@ include file="admin_header.jsp" %>
<main class="admin-shell">
  <div class="panel">
    <h1>訂單管理</h1>
    <table>
      <thead>
        <tr><th>訂單編號</th><th>會員</th><th>訂單日期</th><th>總金額</th><th>狀態</th><th>操作</th></tr>
      </thead>
      <tbody>
<%
    String sql = "SELECT o.o_id, o.m_id, m.m_email, o.o_date, o.o_total_price, o.o_status " +
                 "FROM orders o JOIN members m ON o.m_id = m.m_id ORDER BY o.o_id DESC";
    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        boolean hasOrder = false;
        while (rs.next()) {
            hasOrder = true;
%>
        <tr>
          <td>#<%= rs.getInt("o_id") %></td>
          <td><%= h(rs.getString("m_email")) %> (ID: <%= rs.getInt("m_id") %>)</td>
          <td><%= rs.getTimestamp("o_date") %></td>
          <td>NT$ <%= rs.getInt("o_total_price") %></td>
          <td><%= h(rs.getString("o_status")) %></td>
          <td><a class="btn" href="admin_order_detail.jsp?o_id=<%= rs.getInt("o_id") %>">查看明細</a></td>
        </tr>
<%
        }
        if (!hasOrder) {
%>
        <tr><td colspan="6">目前沒有訂單。</td></tr>
<%
        }
    } catch (Exception e) {
%>
        <tr><td colspan="6"><%= h(e.getMessage()) %></td></tr>
<%
    }
%>
      </tbody>
    </table>
  </div>
</main>
</body>
</html>
