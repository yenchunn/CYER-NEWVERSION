<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="admin_auth.jsp" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head><meta charset="UTF-8"><title>商品管理</title></head>
<body>
<%@ include file="admin_header.jsp" %>
<main class="admin-shell">
  <div class="panel">
    <h1>商品管理</h1>
    <% if ("added".equals(request.getParameter("msg"))) { %><div class="message">商品新增成功。</div><% } %>
    <% if ("updated".equals(request.getParameter("msg"))) { %><div class="message">商品修改成功。</div><% } %>
    <% if ("inactive".equals(request.getParameter("msg"))) { %><div class="message">商品已下架。</div><% } %>
    <p><a class="btn" href="admin_product_add.jsp">新增商品</a></p>
    <table>
      <thead>
        <tr><th>編號</th><th>圖片</th><th>商品名稱</th><th>分類</th><th>價格</th><th>庫存</th><th>狀態</th><th>操作</th></tr>
      </thead>
      <tbody>
<%
    String sql = "SELECT p_id, p_name, p_price, p_stock, p_category, p_image, is_active FROM products ORDER BY p_id DESC";
    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
%>
        <tr>
          <td><%= rs.getInt("p_id") %></td>
          <td><img src="<%= h(rs.getString("p_image")) %>" alt="" style="width:70px;height:55px;object-fit:contain;background:#fff;"></td>
          <td><%= h(rs.getString("p_name")) %></td>
          <td><%= h(rs.getString("p_category")) %></td>
          <td>NT$ <%= rs.getInt("p_price") %></td>
          <td><%= rs.getInt("p_stock") %></td>
          <td><%= rs.getInt("is_active") == 1 ? "上架" : "下架" %></td>
          <td>
            <div class="actions">
              <a class="btn" href="admin_product_edit.jsp?p_id=<%= rs.getInt("p_id") %>">修改</a>
              <% if (rs.getInt("is_active") == 1) { %>
              <form action="admin_product_delete.jsp" method="post" onsubmit="return confirm('確定要下架此商品？');">
                <input type="hidden" name="p_id" value="<%= rs.getInt("p_id") %>">
                <button class="btn danger" type="submit">下架</button>
              </form>
              <% } %>
            </div>
          </td>
        </tr>
<%
        }
    } catch (Exception e) {
%>
        <tr><td colspan="8"><%= h(e.getMessage()) %></td></tr>
<%
    }
%>
      </tbody>
    </table>
  </div>
</main>
</body>
</html>
