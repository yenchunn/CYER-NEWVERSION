<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="admin_auth.jsp" %>
<%
    int pId = 0;
    try { pId = Integer.parseInt(request.getParameter("p_id")); } catch (Exception ignored) {}
    String error = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            String name = request.getParameter("p_name");
            int price = Integer.parseInt(request.getParameter("p_price"));
            int stock = Integer.parseInt(request.getParameter("p_stock"));
            String category = request.getParameter("p_category");
            String desc = request.getParameter("p_desc");
            String image = request.getParameter("p_image");
            int isActive = "1".equals(request.getParameter("is_active")) ? 1 : 0;

            if (pId <= 0 || name == null || name.trim().isEmpty() || category == null || category.trim().isEmpty() ||
                desc == null || desc.trim().isEmpty() || image == null || image.trim().isEmpty() ||
                price < 0 || stock < 0) {
                error = "請完整填寫商品資料，價格與庫存不可小於 0。";
            } else {
                String updateSql = "UPDATE products SET p_name=?, p_price=?, p_stock=?, p_desc=?, p_category=?, p_image=?, is_active=? WHERE p_id=?";
                try (Connection conn = getConnection();
                     PreparedStatement ps = conn.prepareStatement(updateSql)) {
                    ps.setString(1, name.trim());
                    ps.setInt(2, price);
                    ps.setInt(3, stock);
                    ps.setString(4, desc.trim());
                    ps.setString(5, category.trim());
                    ps.setString(6, image.trim());
                    ps.setInt(7, isActive);
                    ps.setInt(8, pId);
                    ps.executeUpdate();
                }
                response.sendRedirect("admin_products.jsp?msg=updated");
                return;
            }
        } catch (Exception e) {
            error = "修改失敗：" + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head><meta charset="UTF-8"><title>修改商品</title></head>
<body>
<%@ include file="admin_header.jsp" %>
<main class="admin-shell">
  <div class="panel">
    <h1>修改商品</h1>
    <% if (error.length() > 0) { %><div class="message"><%= h(error) %></div><% } %>
<%
    String selectSql = "SELECT p_id, p_name, p_price, p_stock, p_desc, p_category, p_image, is_active FROM products WHERE p_id = ?";
    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(selectSql)) {
        ps.setInt(1, pId);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
%>
    <form method="post" action="admin_product_edit.jsp?p_id=<%= pId %>">
      <label>商品名稱<input name="p_name" value="<%= h(rs.getString("p_name")) %>" required></label>
      <label>價格<input name="p_price" type="number" min="0" value="<%= rs.getInt("p_price") %>" required></label>
      <label>庫存<input name="p_stock" type="number" min="0" value="<%= rs.getInt("p_stock") %>" required></label>
      <label>分類<input name="p_category" value="<%= h(rs.getString("p_category")) %>" required></label>
      <label>商品描述<textarea name="p_desc" required><%= h(rs.getString("p_desc")) %></textarea></label>
      <label>圖片路徑<input name="p_image" value="<%= h(rs.getString("p_image")) %>" required></label>
      <label>狀態
        <select name="is_active">
          <option value="1" <%= rs.getInt("is_active") == 1 ? "selected" : "" %>>上架</option>
          <option value="0" <%= rs.getInt("is_active") == 0 ? "selected" : "" %>>下架</option>
        </select>
      </label>
      <p><button class="btn" type="submit">儲存修改</button> <a class="btn secondary" href="admin_products.jsp">取消</a></p>
    </form>
<%
            } else {
%>
    <div class="message">查無此商品。</div>
<%
            }
        }
    } catch (Exception e) {
%>
    <div class="message"><%= h(e.getMessage()) %></div>
<%
    }
%>
  </div>
</main>
</body>
</html>
