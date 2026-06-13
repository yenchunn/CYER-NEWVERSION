<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="admin_auth.jsp" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head><meta charset="UTF-8"><title>CYER 後台首頁</title></head>
<body>
<%@ include file="admin_header.jsp" %>
<main class="admin-shell">
  <div class="panel">
    <h1>後台管理</h1>
    <p>管理員：<%= h((String) session.getAttribute("m_name")) %>（<%= h((String) session.getAttribute("m_email")) %>）</p>
    <div class="actions">
      <a class="btn" href="admin_members.jsp">查看所有會員</a>
      <a class="btn" href="admin_orders.jsp">查看所有訂單</a>
      <a class="btn" href="admin_products.jsp">管理商品</a>
      <a class="btn secondary" href="admin_product_add.jsp">新增商品</a>
    </div>
  </div>
</main>
</body>
</html>
