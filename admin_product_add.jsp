<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="admin_auth.jsp" %>
<%
    String error = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name = request.getParameter("p_name");
        String priceText = request.getParameter("p_price");
        String stockText = request.getParameter("p_stock");
        String category = request.getParameter("p_category");
        String desc = request.getParameter("p_desc");
        String image = request.getParameter("p_image");

        try {
            int price = Integer.parseInt(priceText);
            int stock = Integer.parseInt(stockText);
            if (name == null || name.trim().isEmpty() || category == null || category.trim().isEmpty() ||
                desc == null || desc.trim().isEmpty() || image == null || image.trim().isEmpty() ||
                price < 0 || stock < 0) {
                error = "請完整填寫商品資料，價格與庫存不可小於 0。";
            } else {
                String sql = "INSERT INTO products(p_name, p_price, p_stock, p_desc, p_category, p_image, is_active) VALUES (?, ?, ?, ?, ?, ?, 1)";
                try (Connection conn = getConnection();
                     PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, name.trim());
                    ps.setInt(2, price);
                    ps.setInt(3, stock);
                    ps.setString(4, desc.trim());
                    ps.setString(5, category.trim());
                    ps.setString(6, image.trim());
                    ps.executeUpdate();
                }
                response.sendRedirect("admin_products.jsp?msg=added");
                return;
            }
        } catch (Exception e) {
            error = "新增失敗：" + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head><meta charset="UTF-8"><title>新增商品</title></head>
<body>
<%@ include file="admin_header.jsp" %>
<main class="admin-shell">
  <div class="panel">
    <h1>新增商品</h1>
    <% if (error.length() > 0) { %><div class="message"><%= h(error) %></div><% } %>
    <form method="post" action="admin_product_add.jsp">
      <label>商品名稱<input name="p_name" required></label>
      <label>價格<input name="p_price" type="number" min="0" required></label>
      <label>庫存<input name="p_stock" type="number" min="0" required></label>
      <label>分類<input name="p_category" placeholder="例如：空氣清淨機" required></label>
      <label>商品描述<textarea name="p_desc" required></textarea></label>
      <label>圖片路徑<input name="p_image" placeholder="例如：image/air/air_1.jpg" required></label>
      <p><button class="btn" type="submit">新增商品</button> <a class="btn secondary" href="admin_products.jsp">取消</a></p>
    </form>
  </div>
</main>
</body>
</html>
