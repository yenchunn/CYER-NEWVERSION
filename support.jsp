<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    pageContext.setAttribute("currentPage", "support");
    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "faq";
    }
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CYER | 客服支援</title>
  <style>
/* ===== CYER — French Maison Style ===== */
@import url('https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300;1,400&family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Noto+Serif+TC:wght@300;400;600&display=swap');

:root {
  --cream:      #F9F5EF;
  --warm-white: #FDFAF5;
  --gold:       #B8945A;
  --gold-light: #D4AF7A;
  --gold-dark:  #8B6835;
  --charcoal:   #2C2825;
  --mid-grey:   #8A8278;
  --light-grey: #E8E2D9;
  --border:     #D6CCBC;
  --accent:     #6B4F3A;
  --shadow:     rgba(44,40,37,0.12);
}

*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

html { scroll-behavior: smooth; }

a.brand-logo {
  cursor: pointer;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  transition: opacity 0.3s ease;
}

a.brand-logo:hover {
  opacity: 0.85;
}

body {
  background: var(--cream);
  color: var(--charcoal);
  font-family: 'Noto Serif TC', 'Cormorant Garamond', serif;
  font-weight: 300;
  line-height: 1.8;
  min-height: 100vh;
}

/* ===== HEADER ===== */
.site-header {
  background: var(--warm-white);
  border-bottom: 1px solid var(--border);
  position: sticky;
  top: 0;
  z-index: 100;
  box-shadow: 0 2px 20px var(--shadow);
}

.header-top {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 18px 60px;
  border-bottom: 1px solid var(--light-grey);
}

.brand-logo {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}

.logo-text {
  font-family: 'Playfair Display', serif;
  font-size: 2.2rem;
  font-weight: 700;
  letter-spacing: 0.35em;
  color: var(--charcoal);
  line-height: 1;
}

.logo-sub {
  font-family: 'Cormorant Garamond', serif;
  font-size: 0.75rem;
  letter-spacing: 0.25em;
  color: var(--gold);
  margin-top: 2px;
}

.header-icons {
  display: flex;
  gap: 18px;
  align-items: center;
}

.icon-btn {
  color: var(--charcoal);
  text-decoration: none;
  position: relative;
  transition: color 0.3s;
  display: flex;
  align-items: center;
}
.icon-btn:hover { color: var(--gold); }

.cart-badge {
  position: absolute;
  top: -6px; right: -8px;
  background: var(--gold);
  color: white;
  font-size: 0.6rem;
  width: 16px; height: 16px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: 'Cormorant Garamond', serif;
}

/* ===== NAVBAR ===== */
.main-nav {
  background: var(--warm-white);
}

.nav-list {
  display: flex;
  list-style: none;
  justify-content: center;
  gap: 0;
  padding: 0 40px;
}

.nav-item {
  position: relative;
}

.nav-item a {
  display: block;
  padding: 14px 22px;
  text-decoration: none;
  color: var(--charcoal);
  font-family: 'Noto Serif TC', serif;
  font-size: 0.82rem;
  letter-spacing: 0.12em;
  font-weight: 400;
  transition: color 0.3s;
  white-space: nowrap;
}

.nav-item:hover a,
.nav-item.active a {
  color: var(--gold);
}

.nav-underline {
  position: absolute;
  bottom: 0; left: 50%;
  transform: translateX(-50%);
  width: 0;
  height: 2px;
  background: var(--gold);
  transition: width 0.3s ease;
}

.nav-item:hover .nav-underline,
.nav-item.active .nav-underline {
  width: 60%;
}

/* Dropdown hover zoom effect */
.nav-item {
  transition: transform 0.2s ease;
}
.nav-item:hover {
  transform: translateY(-2px);
}

/* ===== DIVIDER ORNAMENT ===== */
.ornament-divider {
  display: flex;
  align-items: center;
  gap: 16px;
  margin: 48px auto;
  max-width: 300px;
  justify-content: center;
}
.ornament-line {
  flex: 1;
  height: 1px;
  background: linear-gradient(to right, transparent, var(--border), transparent);
}
.ornament-diamond {
  width: 8px; height: 8px;
  background: var(--gold);
  transform: rotate(45deg);
}

/* ===== SECTION TITLE ===== */
.section-title {
  font-family: 'Playfair Display', serif;
  font-size: 1.8rem;
  font-weight: 400;
  letter-spacing: 0.08em;
  color: var(--charcoal);
  text-align: center;
  margin-bottom: 6px;
}
.section-subtitle {
  font-family: 'Cormorant Garamond', serif;
  font-size: 0.9rem;
  letter-spacing: 0.2em;
  color: var(--gold);
  text-align: center;
  margin-bottom: 40px;
}

/* ===== PRODUCT GRID ===== */
.product-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 32px;
  padding: 0 60px 60px;
  max-width: 1300px;
  margin: 0 auto;
}

.product-card {
  background: var(--warm-white);
  border: 1px solid var(--border);
  aspect-ratio: 3/4;
  position: relative;
  overflow: hidden;
  cursor: pointer;
  transition: box-shadow 0.4s, transform 0.4s;
}

.product-card:hover {
  box-shadow: 0 8px 40px var(--shadow);
  transform: translateY(-4px);
}

.product-card::after {
  content: '';
  position: absolute;
  inset: 8px;
  border: 1px solid var(--light-grey);
  pointer-events: none;
  transition: inset 0.4s;
}

.product-card:hover::after {
  inset: 4px;
  border-color: var(--gold-light);
}

/* ===== FOOTER ===== */
footer {
  background: var(--charcoal);
  color: var(--light-grey);
  padding: 60px;
}

.footer-grid {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr;
  gap: 48px;
  max-width: 1300px;
  margin: 0 auto 40px;
}

.footer-brand .logo-text {
  color: var(--warm-white);
  font-size: 1.6rem;
}
.footer-brand .logo-sub {
  color: var(--gold-light);
}
.footer-brand p {
  font-size: 0.8rem;
  color: var(--mid-grey);
  margin-top: 16px;
  line-height: 1.9;
}

.footer-col h4 {
  font-family: 'Cormorant Garamond', serif;
  font-size: 0.75rem;
  letter-spacing: 0.25em;
  color: var(--gold-light);
  margin-bottom: 16px;
  text-transform: uppercase;
}

.footer-col ul {
  list-style: none;
}
.footer-col ul li {
  margin-bottom: 10px;
}
.footer-col ul li a {
  color: var(--mid-grey);
  text-decoration: none;
  font-size: 0.82rem;
  letter-spacing: 0.06em;
  transition: color 0.3s;
}
.footer-col ul li a:hover { color: var(--gold-light); }

.footer-bottom {
  border-top: 1px solid #3C3835;
  padding-top: 28px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  max-width: 1300px;
  margin: 0 auto;
}

.footer-bottom p {
  font-size: 0.75rem;
  color: var(--mid-grey);
  letter-spacing: 0.08em;
}

.footer-legal {
  display: flex;
  gap: 24px;
}
.footer-legal a {
  color: var(--mid-grey);
  text-decoration: none;
  font-size: 0.75rem;
  transition: color 0.3s;
}
.footer-legal a:hover { color: var(--gold-light); }

/* ===== UTILITIES ===== */
.container {
  max-width: 1300px;
  margin: 0 auto;
  padding: 0 60px;
}

.page-section {
  padding: 64px 0;
}

/* ===== CYER dynamic JSP pages ===== */
.page-hero {
  background: linear-gradient(135deg, #2C2825 0%, #3E3530 50%, #2C2825 100%);
  padding: 72px 60px 60px;
  text-align: center;
}

.page-hero-fr {
  font-family: 'Cormorant Garamond', serif;
  font-size: 0.72rem;
  letter-spacing: 0.35em;
  color: var(--gold-light);
  text-transform: uppercase;
  margin-bottom: 12px;
}

.page-hero-title {
  font-family: 'Playfair Display', serif;
  font-size: 3rem;
  font-weight: 400;
  color: var(--warm-white);
  margin-bottom: 12px;
}

.page-hero-sub {
  color: rgba(249,245,239,0.72);
  letter-spacing: 0.08em;
}

.cyer-product-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 28px;
}

.cyer-product-card {
  background: var(--warm-white);
  border: 1px solid var(--border);
  overflow: hidden;
  box-shadow: 0 8px 28px var(--shadow);
}

.cyer-product-card img {
  width: 100%;
  aspect-ratio: 4 / 3;
  object-fit: contain;
  background: white;
  display: block;
  padding: 18px;
}

.cyer-product-body {
  padding: 22px;
}

.cyer-product-body h3 {
  font-size: 1.05rem;
  margin-bottom: 8px;
}

.price {
  color: var(--gold-dark);
  font-weight: 600;
  margin-bottom: 8px;
}

.btn-link,
.btn {
  display: inline-block;
  background: var(--gold);
  color: white;
  border: 0;
  padding: 10px 22px;
  margin-top: 16px;
  text-decoration: none;
  cursor: pointer;
}

.btn-link:hover,
.btn:hover {
  background: var(--gold-dark);
}

.form-card,
.content-card {
  max-width: 560px;
  margin: 56px auto;
  background: var(--warm-white);
  border: 1px solid var(--border);
  padding: 34px;
  box-shadow: 0 8px 30px var(--shadow);
}

.form-card input,
.form-card textarea,
.form-card select {
  width: 100%;
  padding: 12px;
  margin: 8px 0 14px;
  border: 1px solid var(--border);
  background: white;
  font-family: inherit;
}

.message {
  padding: 12px 14px;
  background: #fff6e5;
  border-left: 3px solid var(--gold);
  margin-bottom: 18px;
}

.detail-layout {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 42px;
  align-items: start;
}

.detail-image {
  width: 100%;
  background: white;
  border: 1px solid var(--border);
  padding: 24px;
  object-fit: contain;
}

.reviews {
  margin-top: 48px;
}

.review-item {
  background: white;
  border: 1px solid var(--border);
  padding: 18px;
  margin-bottom: 14px;
}

.empty-message {
  grid-column: 1 / -1;
  background: white;
  border: 1px solid var(--border);
  padding: 24px;
  text-align: center;
}

.member-grid {
  display: grid;
  grid-template-columns: 260px 1fr;
  gap: 30px;
  max-width: 1100px;
  margin: 56px auto;
  padding: 0 24px;
}

.member-menu,
.member-panel {
  background: var(--warm-white);
  border: 1px solid var(--border);
  padding: 28px;
  box-shadow: 0 8px 30px var(--shadow);
}

.member-menu a {
  display: block;
  color: var(--charcoal);
  text-decoration: none;
  padding: 10px 0;
  border-bottom: 1px solid var(--light-grey);
}

@media (max-width: 900px) {
  .header-top,
  .container {
    padding-left: 24px;
    padding-right: 24px;
  }

  .nav-list {
    flex-wrap: wrap;
    padding: 0 12px;
  }

  .cyer-product-grid,
  .detail-layout,
  .member-grid,
  .footer-grid {
    grid-template-columns: 1fr;
  }
}

</style>
</head>
<body>
<%
    String currentPage = (String) pageContext.getAttribute("currentPage");
    if (currentPage == null) {
        currentPage = "";
    }
%>
<header class="site-header">
  <div class="header-top">
    <a href="index.jsp" class="brand-logo" style="text-decoration: none;">
      <span class="logo-text">CYER</span>
      <span class="logo-sub">Electric House</span>
    </a>
    <div class="header-icons">
      <a href="member.jsp" class="icon-btn" title="會員中心">會員</a>
      <a href="shopping_cart.jsp" class="icon-btn cart-btn" title="購物車">購物車<span class="cart-badge">0</span></a>
    </div>
  </div>
  <nav class="main-nav">
    <ul class="nav-list">
      <li class="nav-item <%= "index".equals(currentPage) ? "active" : "" %>"><a href="index.jsp">首頁</a><span class="nav-underline"></span></li>
      <li class="nav-item <%= "ref".equals(currentPage) ? "active" : "" %>"><a href="refrigerator.jsp">冰箱</a><span class="nav-underline"></span></li>
      <li class="nav-item <%= "air".equals(currentPage) ? "active" : "" %>"><a href="air-purifier.jsp">空氣清淨機</a><span class="nav-underline"></span></li>
      <li class="nav-item <%= "fan".equals(currentPage) ? "active" : "" %>"><a href="fan.jsp">電風扇</a><span class="nav-underline"></span></li>
      <li class="nav-item <%= "hd".equals(currentPage) ? "active" : "" %>"><a href="hairdryer.jsp">吹風機</a><span class="nav-underline"></span></li>
      <li class="nav-item <%= "de".equals(currentPage) ? "active" : "" %>"><a href="dehumidifier.jsp">除濕機</a><span class="nav-underline"></span></li>
      <li class="nav-item <%= "vac".equals(currentPage) ? "active" : "" %>"><a href="vacuum.jsp">吸塵器</a><span class="nav-underline"></span></li>
      <li class="nav-item <%= "support".equals(currentPage) ? "active" : "" %>"><a href="support.jsp">客服支援</a><span class="nav-underline"></span></li>
      <li class="nav-item <%= "login".equals(currentPage) ? "active" : "" %>"><a href="login.jsp">登入</a><span class="nav-underline"></span></li>
    </ul>
  </nav>
</header>

<section class="page-hero">
  <p class="page-hero-fr">support</p>
  <h1 class="page-hero-title">客服支援</h1>
  <p class="page-hero-sub">訂單、配送、保固與常見問題</p>
</section>

<main class="member-grid">
  <aside class="member-menu">
    <a href="support.jsp?tab=order">訂單查詢</a>
    <a href="support.jsp?tab=shipping">配送說明</a>
    <a href="support.jsp?tab=returns">退換貨政策</a>
    <a href="support.jsp?tab=warranty">保固服務</a>
    <a href="support.jsp?tab=faq">常見問題</a>
    <a href="support.jsp?tab=contact">聯絡我們</a>
  </aside>
  <section class="member-panel">
    <% if ("order".equals(tab)) { %>

      <h2 style="font-family: 'Playfair Display', serif; font-size: 1.5rem; letter-spacing: 0.05em; margin-bottom: 24px; color: var(--charcoal); border-bottom: 2px solid var(--gold); padding-bottom: 8px;">訂單查詢</h2>
      
      <%@ page import="java.sql.*" %>

      <%
      request.setCharacterEncoding("UTF-8");
      response.setCharacterEncoding("UTF-8");
      
      Connection conn = null;
      PreparedStatement ps = null;
      ResultSet rs = null;
      
      // 宣告給明細查詢使用的 PreparedStatement 與 ResultSet
      PreparedStatement itemPs = null;
      ResultSet itemRs = null;
      
      try {
          Integer memberId = (Integer) session.getAttribute("m_id");
      
          if (memberId == null) {
              response.sendRedirect("login.jsp");
              return;
          }
      
          Class.forName("com.mysql.cj.jdbc.Driver");
      
          conn = DriverManager.getConnection(
              "jdbc:mysql://localhost:3306/cyer?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Taipei&useSSL=false",
              "root",
              "1234"
          );
      
          // 1. 先查出該會員的所有訂單，最新的排在最前面
          ps = conn.prepareStatement(
              "SELECT * FROM orders WHERE m_id = ? ORDER BY o_id DESC"
          );
      
          ps.setInt(1, memberId);
          rs = ps.executeQuery();
          
          boolean hasOrder = false;
          while (rs.next()) {
              hasOrder = true;
              int orderId = rs.getInt("o_id");
      %>
      
      <!-- 外層精美訂單大卡片 -->
      <div class="order-card" style="background: white; border: 1px solid var(--border); padding: 24px; margin-bottom: 24px; box-shadow: 0 6px 20px var(--shadow);">
          
          <!-- 訂單表頭資訊 -->
          <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--light-grey); padding-bottom: 12px; margin-bottom: 16px;">
              <div>
                  <span style="font-size: 0.85rem; color: var(--mid-grey);">訂單編號：</span>
                  <strong style="color: var(--charcoal); font-size: 1.1rem;">#<%= orderId %></strong>
                  <span style="margin-left: 16px; font-size: 0.85rem; color: var(--mid-grey);">成立日期：<%= rs.getTimestamp("o_date") %></span>
              </div>
              <div>
                  <!-- 根據狀態給予高質感顏色 -->
                  <span style="background: var(--cream); color: var(--gold-dark); border: 1px solid var(--gold); padding: 4px 12px; font-size: 0.8rem; font-weight: 600;">
                      <%= rs.getString("o_status") %>
                  </span>
              </div>
          </div>
          
          <!-- 訂單購買產品細項標題 -->
          <div style="font-size: 0.85rem; color: var(--mid-grey); margin-bottom: 8px; font-weight: 600;">商品明細：</div>
          
          <div style="background: var(--warm-white); padding: 12px 18px; border: 1px solid var(--light-grey); margin-bottom: 16px;">
          <%
              // 1. 新增一個變數，用來在迴圈裡默默加總這筆訂單的商品原價
              int originalItemsTotal = 0; 
              
              String itemSql = "SELECT oi.item_quantity, oi.item_unit_price, p.p_name " +
                               "FROM orders_items oi " +
                               "JOIN products p ON oi.p_id = p.p_id " +
                               "WHERE oi.o_id = ?";
              itemPs = conn.prepareStatement(itemSql);
              itemPs.setInt(1, orderId);
              itemRs = itemPs.executeQuery();
              
              while(itemRs.next()) {
                  String prodName = itemRs.getString("p_name");
                  int unitPrice = itemRs.getInt("item_unit_price");
                  int quantity = itemRs.getInt("item_quantity");
                  int subtotal = unitPrice * quantity;
                  
                  // 每跑一項商品，就把金額加進去原價總和裡
                  originalItemsTotal += subtotal; 
          %>
              <div style="display: flex; justify-content: space-between; align-items: center; padding: 6px 0; font-size: 0.9rem; border-bottom: 1px dashed var(--light-grey);">
                  <div style="color: var(--charcoal); font-weight: 400;"><%= prodName %></div>
                  <div style="color: var(--mid-grey);">
                      NT$ <%= unitPrice %> × <%= quantity %> 
                      <span style="margin-left: 12px; color: var(--charcoal); font-weight: 600;">小計: NT$ <%= subtotal %></span>
                  </div>
              </div>
          <%
              }
              if(itemRs != null) itemRs.close();
              if(itemPs != null) itemPs.close();
              
              // 2. 自動計算這筆訂單當時到底折了多少錢（原價總和 - 資料庫紀錄的實付總額）
              int orderDiscount = originalItemsTotal - rs.getInt("o_total_price");
          %>
          </div>
          
          <div style="font-size: 0.85rem; color: var(--mid-grey); margin-bottom: 12px;">
              配送地址：<span style="color: var(--charcoal);"><%= rs.getString("o_address") %></span>
          </div>
          
          <div style="text-align: right; border-top: 1px solid var(--light-grey); padding-top: 12px; line-height: 1.8;">
              <p style="font-size: 0.88rem; color: var(--mid-grey);">
                  商品小計：<span style="color: var(--charcoal);font-weight: 600;">NT$ <%= originalItemsTotal %></span>
              </p>
              
              <% // 如果這筆訂單算出來有折扣（大於 0），畫面上才秀出這一行紅字，沒打折的訂單會自動隱藏！ %>
              <% if (orderDiscount > 0) { %>
                  <p style="font-size: 0.88rem; color: #a94442; font-weight: 400;">
                      會員優惠（滿萬折千）：- NT$ <%= orderDiscount %></span>
                  </p>
              <% } %>
              
              <div style="margin-top: 6px;">
                  <span style="font-size: 0.9rem; color: var(--charcoal); font-weight: 400;">訂單總額：</span>
                  <strong style="font-size: 1.3rem; color: var(--gold-dark);">
                      NT$ <%= rs.getInt("o_total_price") %>
                  </strong>
              </div>
          </div>
      </div>
      
      <%
          }
          if (!hasOrder) {
      %>
          <div style="text-align: center; padding: 48px; background: white; border: 1px solid var(--border);">
              <p style="color: var(--mid-grey);">您目前尚無任何訂單紀錄。</p>
              <a href="index.jsp" class="btn" style="margin-top: 16px; text-decoration: none;">前往選購商品</a>
          </div>
      <%
          }
      
      } catch(Exception e) {
          out.println("<div style='color:red; padding:10px;'>系統撈取訂單失敗：" + e.getMessage() + "</div>");
      } finally {
          try { if (itemRs != null) itemRs.close(); } catch(Exception e) {}
          try { if (itemPs != null) itemPs.close(); } catch(Exception e) {}
          try { if (rs != null) rs.close(); } catch(Exception e) {}
          try { if (ps != null) ps.close(); } catch(Exception e) {}
          try { if (conn != null) conn.close(); } catch(Exception e) {}
      }
      %>
 
    <% } else if ("shipping".equals(tab)) { %>
      <h2>配送說明</h2>
      <p>一般商品於付款完成後 3 至 5 個工作天安排出貨，大型家電將另行電話確認配送時間。</p>
    <% } else if ("returns".equals(tab)) { %>
      <h2>退換貨政策</h2>
      <p>商品如需退換，請保持外箱、配件與保固文件完整，並於鑑賞期內聯繫客服。</p>
    <% } else if ("warranty".equals(tab)) { %>
      <h2>保固服務</h2>
      <p>CYER 商品依原廠規範提供保固，請保留購買證明以利後續服務。</p>
    <% } else if ("contact".equals(tab)) { %>
      <h2>聯絡我們</h2>
      <p>Email：cyer@gmail.com</p>
      <p>電話：02-1234-5678</p>
    <% } else { %>
      <h2>常見問題</h2>
      <p>若商品頁顯示庫存不足，代表目前無法直接下單；可稍後回來查看補貨狀態。</p>
    <% } %>
  </section>
</main>

<footer>
  <div class="footer-grid">
    <div class="footer-brand">
      <div class="brand-logo">
        <span class="logo-text">CYER</span>
        <span class="logo-sub">Electric House</span>
      </div>
      <p>CYER 提供質感家電選品，讓日常空間更舒適、更安靜，也更容易照顧。</p>
    </div>
    <div class="footer-col">
      <h4>商品分類</h4>
      <ul>
        <li><a href="refrigerator.jsp">冰箱</a></li>
        <li><a href="air-purifier.jsp">空氣清淨機</a></li>
        <li><a href="fan.jsp">電風扇</a></li>
        <li><a href="hairdryer.jsp">吹風機</a></li>
        <li><a href="dehumidifier.jsp">除濕機</a></li>
        <li><a href="vacuum.jsp">吸塵器</a></li>
      </ul>
    </div>
    <div class="footer-col">
      <h4>客服支援</h4>
      <ul>
        <li><a href="support.jsp?tab=order">訂單查詢</a></li>
        <li><a href="support.jsp?tab=shipping">配送說明</a></li>
        <li><a href="support.jsp?tab=returns">退換貨政策</a></li>
        <li><a href="support.jsp?tab=warranty">保固服務</a></li>
      </ul>
    </div>
    <div class="footer-col">
      <h4>會員服務</h4>
      <ul>
        <li><a href="login.jsp">會員登入</a></li>
        <li><a href="register.jsp">會員註冊</a></li>
        <li><a href="member.jsp">會員中心</a></li>
        <li><a href="shopping_cart.jsp">購物車</a></li>
      </ul>
    </div>
  </div>
  <div class="footer-bottom">
    <p>© 2026 CYER Electric House. All rights reserved.</p>
  </div>
</footer>
</body>
</html>
