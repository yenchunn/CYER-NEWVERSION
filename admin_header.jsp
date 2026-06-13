<%@ page pageEncoding="UTF-8" %>
<%
    response.setContentType("text/html; charset=UTF-8");
%>
<style>
body { margin: 0; background: #f7f3ec; color: #2c2825; font-family: Arial, "Noto Sans TC", sans-serif; }
.admin-shell { max-width: 1180px; margin: 0 auto; padding: 28px 20px 56px; }
.admin-nav { background: #2c2825; color: #fff; padding: 16px 22px; display: flex; gap: 18px; align-items: center; flex-wrap: wrap; }
.admin-nav strong { letter-spacing: 0.12em; margin-right: 12px; }
.admin-nav a { color: #fff; text-decoration: none; padding: 6px 10px; border: 1px solid rgba(255,255,255,.2); }
.admin-nav a:hover { background: #b8945a; }
.panel { background: #fffdf8; border: 1px solid #d6ccbc; padding: 24px; margin-top: 22px; box-shadow: 0 8px 24px rgba(44,40,37,.08); }
table { width: 100%; border-collapse: collapse; background: #fff; }
th, td { border-bottom: 1px solid #e8e2d9; padding: 10px; text-align: left; vertical-align: top; }
th { background: #f0e7d8; }
.btn { display: inline-block; border: 0; background: #b8945a; color: #fff; padding: 8px 14px; text-decoration: none; cursor: pointer; }
.btn.secondary { background: #6b4f3a; }
.btn.danger { background: #a33; }
.message { background: #fff6e5; border-left: 4px solid #b8945a; padding: 12px; margin: 12px 0; }
label { display: block; margin-top: 12px; font-weight: bold; }
input, textarea, select { width: 100%; box-sizing: border-box; padding: 10px; border: 1px solid #d6ccbc; margin-top: 6px; }
textarea { min-height: 110px; }
.actions { display: flex; gap: 8px; align-items: center; flex-wrap: wrap; }
</style>
<div class="admin-nav">
  <strong>CYER ADMIN</strong>
  <a href="admin_index.jsp">後台首頁</a>
  <a href="admin_members.jsp">會員管理</a>
  <a href="admin_orders.jsp">訂單管理</a>
  <a href="admin_products.jsp">商品管理</a>
  <a href="index.jsp">回前台</a>
  <a href="logout.jsp">登出</a>
</div>
