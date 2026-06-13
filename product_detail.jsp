<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%!
    private static final String DB_URL = "jdbc:mysql://localhost:3306/cyer?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Taipei";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";

    public Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    public String h(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#39;");
    }
%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    pageContext.setAttribute("currentPage", "");
    String cartError = request.getParameter("cart_error");
    int pId = 0;
    try {
        pId = Integer.parseInt(request.getParameter("p_id"));
    } catch (Exception ignored) {
        pId = 0;
    }
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CYER | 商品詳情</title>
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

<main class="container page-section">
<%
    String detailSql = "SELECT p_id, p_name, p_price, p_stock, p_desc, p_category, p_image FROM products WHERE p_id = ? AND is_active = 1";
    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(detailSql)) {
        ps.setInt(1, pId);
        try (ResultSet product = ps.executeQuery()) {
            if (product.next()) {
%>
  <div class="detail-layout">
    <img class="detail-image" src="<%= h(product.getString("p_image")) %>" alt="<%= h(product.getString("p_name")) %>">
    <section>
      <% if ("stock".equals(cartError)) { %>
        <div class="message">購買數量超過庫存，請重新輸入購買數量!</div>
      <% } else if ("invalid".equals(cartError)) { %>
        <div class="message">購買數量必須是大於 0 的數字，請重新輸入。</div>
      <% } else if ("notfound".equals(cartError)) { %>
        <div class="message">商品不存在或已下架。</div>
      <% } %>
      <p class="section-subtitle" style="text-align:left;margin-bottom:10px;"><%= h(product.getString("p_category")) %></p>
      <h1><%= h(product.getString("p_name")) %></h1>
      <p class="price">NT$ <%= product.getInt("p_price") %></p>
      <% 
      // 1. 先將該產品的即時庫存數量存入 Java 變數中
      int currentStock = product.getInt("p_stock"); 
  %>
  
  <!-- 2. 呈現庫存，若為 0 則顯示紅字警示 -->
  <p>庫存數量：
      <% if (currentStock > 0) { %>
          <span style="color: var(--charcoal); font-weight: 400;"><%= currentStock %></span>
      <% } else { %>
          <span style="color: #a94442; font-weight: 600;">已售罄 (缺貨中)</span>
      <% } %>
  </p>
  
  <p style="margin-bottom: 20px;"><%= h(product.getString("p_desc")) %></p>
  
  <!-- 3. 【防呆按鈕】若庫存大於 0 才允許導向購物車 -->
  <% if (currentStock > 0) { %>
      <form action="add_to_cart.jsp" method="post" style="max-width:250px;">
        <input type="hidden" name="p_id" value="<%= pId %>">
        <label for="quantity">購買數量</label>
        <input id="quantity" name="quantity" type="number" min="1" max="<%= currentStock %>" value="1" required
               style="width:100%; padding:10px; margin:8px 0 0; border:1px solid var(--border);">
        <button class="btn-link" type="submit" style="text-align: center; width: 100%; max-width: 250px;">加入購物車</button>
      </form>
  <% } else { %>
      <a class="btn-link" href="javascript:void(0);" onclick="alert('目前沒有庫存，無法加入購物車！');" 
         style="background: #D1C9BC; color: #FFFFFF; cursor: not-allowed; text-align: center; width: 100%; max-width: 250px;">
          目前沒有庫存
      </a>
  <% } %>
    </section>
  </div>

  <section class="reviews">
    <h2 class="section-title">留言板 / 評論區</h2>
    <!-- 新增評論表單區塊 -->
  <div class="form-card" style="margin: 24px auto 48px; max-width: 100%;">
    <h3 style="font-family: 'Playfair Display', serif; font-size: 1.2rem; letter-spacing: 0.05em; margin-bottom: 16px; color: var(--charcoal);">發表您的產品評論</h3>
    
    <form action="add_review_process.jsp" method="post">
      <input type="hidden" name="p_id" value="<%= pId %>">
      
      <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
        <div>
          <!-- 標題成功修改為：會員姓名(可匿名) -->
          <label style="font-size: 0.85rem; color: var(--mid-grey);">會員姓名(可匿名)</label>
          <input type="text" name="m_name" placeholder="例如：王小明 或 匿名" required style="margin-top: 4px;">
        </div>
        <div>
          <label style="font-size: 0.85rem; color: var(--mid-grey);">產品評分</label>
          <select name="r_stars" style="margin-top: 4px;">
            <option value="5">★★★★★ (5分)</option>
            <option value="4">★★★★☆ (4分)</option>
            <option value="3">★★★☆☆ (3分)</option>
            <option value="2">★★☆☆☆ (2分)</option>
            <option value="1">★☆☆☆☆ (1分)</option>
          </select>
        </div>
      </div>
      
      <div style="margin-top: 12px;">
        <label style="font-size: 0.85rem; color: var(--mid-grey);">評論內容</label>
        <textarea name="r_content" rows="4" placeholder="分享您使用此質感家電的心得..." required style="margin-top: 4px; resize: none;"></textarea>
      </div>
      
      <button type="submit" class="btn" style="width: 100%; margin-top: 16px; font-family: inherit; letter-spacing: 0.1em;">送出評論</button>
    </form>
  </div>
<%
                String reviewSql = "SELECT members.m_name, reviews.r_stars, reviews.r_content, reviews.r_date " +
                                   "FROM reviews JOIN members ON reviews.m_id = members.m_id " +
                                   "WHERE reviews.p_id = ? ORDER BY reviews.r_date DESC";
                try (PreparedStatement rps = conn.prepareStatement(reviewSql)) {
                    rps.setInt(1, pId);
                    try (ResultSet reviews = rps.executeQuery()) {
                        boolean hasReview = false;
                        while (reviews.next()) {
                            hasReview = true;
%>
    <article class="review-item">
      <strong><%= h(reviews.getString("m_name")) %></strong>
      <p>評分：<%= reviews.getInt("r_stars") %> / 5</p>
      <p><%= h(reviews.getString("r_content")) %></p>
      <p><small><%= reviews.getTimestamp("r_date") %></small></p>
    </article>
<%
                        }
                        if (!hasReview) {
%>
    <p class="empty-message">目前尚無留言</p>
<%
                        }
                    }
                }
%>
  </section>
<%
            } else {
%>
  <p class="empty-message">找不到此商品。</p>
<%
            }
        }
    } catch (Exception e) {
%>
  <p class="empty-message">資料庫讀取失敗：<%= h(e.getMessage()) %></p>
<%
    }
%>
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
