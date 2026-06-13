<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CYER | 組員介紹與心得</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600&family=Playfair+Display:ital,wght@0,400;0,700&family=Noto+Serif+TC:wght@300;400;600&display=swap');

    :root {
      --cream:      #F9F5EF;
      --warm-white: #FDFAF5;
      --gold:       #B8945A;
      --gold-dark:  #8B6835;
      --charcoal:   #2C2825;
      --mid-grey:   #8A8278;
      --border:     #D6CCBC;
      --shadow:     rgba(44,40,37,0.08);
    }

    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      background: var(--cream); /* 底色完全與網站首頁一樣 */
      color: var(--charcoal);
      font-family: 'Noto Serif TC', 'Cormorant Garamond', serif;
      font-weight: 300;
      line-height: 1.8;
      padding: 60px 24px;
    }

    .container {
      max-width: 800px;
      margin: 0 auto;
      background: var(--warm-white);
      border: 1px solid var(--border);
      padding: 48px;
      box-shadow: 0 8px 30px var(--shadow);
      position: relative;
    }

    .container::after {
      content: '';
      position: absolute;
      inset: 12px;
      border: 1px solid #E8E2D9;
      pointer-events: none;
    }

    h1 {
      font-family: 'Playfair Display', serif;
      font-size: 2.2rem;
      text-align: center;
      letter-spacing: 0.1em;
      margin-bottom: 6px;
    }

    .subtitle {
      font-family: 'Cormorant Garamond', serif;
      font-size: 0.9rem;
      color: var(--gold);
      text-align: center;
      letter-spacing: 0.2em;
      text-transform: uppercase;
      margin-bottom: 40px;
    }

    h2 {
      font-size: 1.25rem;
      border-bottom: 1px solid var(--gold);
      padding-bottom: 6px;
      margin-top: 36px;
      margin-bottom: 20px;
      letter-spacing: 0.05em;
      color: var(--charcoal);
    }

    .member-list {
      list-style: none;
      background: var(--cream);
      padding: 20px;
      border: 1px dashed var(--border);
    }

    .member-list li {
      font-size: 0.95rem;
      padding: 6px 0;
      display: flex;
      justify-content: space-between;
    }

    .experience-box {
      margin-bottom: 24px;
    }

    .experience-name {
      font-weight: 600;
      color: var(--gold-dark);
      font-size: 1.05rem;
      margin-bottom: 8px;
    }

    .experience-text {
      font-size: 0.95rem;
      color: #4A443F;
      text-align: justify;
      background: white;
      padding: 16px;
      border: 1px solid #E8E2D9;
    }

    .btn-back {
      display: block;
      width: 150px;
      margin: 40px auto 0;
      background: var(--gold);
      color: white;
      text-align: center;
      padding: 10px;
      text-decoration: none;
      font-size: 0.85rem;
      letter-spacing: 0.1em;
      transition: background 0.3s;
    }
    .btn-back:hover {
      background: var(--gold-dark);
    }
  </style>
</head>
<body>

<div class="container">
  <h1>PROJECT TEAM</h1>
  <div class="subtitle">組員介紹與開發心得</div>

  <h2>組員介紹</h2>
  <ul class="member-list">
    <li><span>資管二乙 11344204</span> <strong>杜書瑋</strong></li>
    <li><span>資管二乙 11344216</span> <strong>黃語芬</strong></li>
    <li><span>資管二乙 11344245</span> <strong>陳彥均</strong></li>
    <li><span>資管二乙 11344246</span> <strong>鍾其睿</strong></li>
  </ul>

  <h2>組員心得</h2>

  <div class="experience-box">
    <div class="experience-name">杜書瑋(25%)</div>
    <div class="experience-text">
      在這次專案中，我參與了會員登入與購物車功能的開發。會員登入部分主要負責前端介面設計與資料庫調整，而購物車部分則參與前端、後端、JSP 與資料庫的建置與整合。對我而言，最具挑戰性的部分並非程式撰寫本身，而是如何規劃整體的運作邏輯。很高興的是，我和組員們都十分投入，從需求討論到共同解決問題，每週都會固定花至少兩個小時討論功能運作方式、工作分配，以及是否有需要協助的地方。
      在開發過程中，我們也逐漸發現實際成果與最初的設計之間難免會出現落差。原本以為完成架構規劃後，問題就能迎刃而解，但實際執行時仍會遇到許多需要調整與修正的地方。這讓我更真實地體會到專案開發的不容易，以及理論與實務之間的差異。<br><br>
      
      我認為這次專案中最有趣的部分在於：「有時候功能本身沒有問題，真正需要調整的是運作邏輯。」例如，使用者在將商品加入購物車前，以及查看購物車內容前，都必須先完成登入。這些細節看似簡單，卻會影響整體使用流程與系統設計。我也深刻體會到「當局者迷，旁觀者清」的道理，因此每當完成功能設計後，我都會請組員協助測試與確認，以確保功能運作符合預期。<br><br>
      
      總而言之，這個專案讓我同時感受到挫折與成就感，不僅提升了技術能力，也讓我學習到團隊合作與溝通的重要性。
    </div>
  </div>

  <div class="experience-box">
    <div class="experience-name">黃語芬(25%)</div>
    <div class="experience-text">
      這是黃語芬的心得內容。
    </div>
  </div>

  <div class="experience-box">
    <div class="experience-name">陳彥均(25%)</div>
    <div class="experience-text">
      這是陳彥均的心得內容。
    </div>
  </div>

  <div class="experience-box">
    <div class="experience-name">鍾其睿(25%)</div>
    <div class="experience-text">
      這是鍾其睿的心得內容。
    </div>
  </div>

  <a href="javascript:window.close();" class="btn-back">關閉此分頁</a>
</div>

</body>
</html>