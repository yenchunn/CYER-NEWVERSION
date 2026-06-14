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
      ​這次在網路程式設計的專案裡，我主要負責家電購物網站的資料庫建置與規劃。<br><br>
​一開始在規劃時，其實對實際需求的掌握還不夠具體，直到後來跟組員深入討論、正式開發後，才明確了方向。我們並沒有去刪減原本的架構，而是針對核心需求，精準地新增了「產品圖片資料表」與「購物車資料表」。產品圖片讓我們能順利呈現家電商品的細節，而購物車則是讓整個購物流程能夠真正跑通的關鍵。<br><br>
​這次的經驗讓我學到，資料庫規劃必須要隨著實際應用的開發不斷調整。比起一開始就想做出完美的結構，能夠配合專案進度，靈活且精準地擴充核心功能資料表，才是讓網站能順利運作的關鍵。
    </div>
  </div>

  <div class="experience-box">
    <div class="experience-name">陳彥均(25%)</div>
    <div class="experience-text">
      在電商平台專案中，我們藉由 JSP 前端與後端資料庫的串接，打造出一個完整的購物網站。我主要負責核心後端邏輯與管理系統的開發，包含商品資料的動態導入、會員註冊與登入的權限控制，以及後台管理員增刪查改（CRUD）商品與查看訂單的功能；同時，為了確保網站安全，我也針對資料庫存取實作了防範 SQL 注入（SQL Injection）的資安防護。<br><br>
專案初期，我們採取前後端分工，由後端主導整體電商的運作邏輯與庫存扣減機制，前端則專注於優化使用者操作介面，雙方緊密配合以防止使用者購買到庫存不足的商品。測試階段，我們遇到了傳統上只能在各自電腦本地端（Localhost）操作、且 GitHub 難以同步動態資料庫內容的痛點。為了提升協作效率，我們導入ngrok API。我將自己的電腦作為伺服器，產生遠端連線 URL 分享給組員，讓他們能直接透過該連結進行下單與註冊測試。這時我電腦中的 MySQL Workbench 便能即時變更與運作。這次額外探索出的解決方案，成功幫團隊克服了跨環境測試的限制。<br><br>
在團隊協作方面，我非常享受與組員共同討論、互相激盪的過程。因為網站架設的每一步都環環相扣，我們在提出想法時都會理性分析優缺點。這次的專案不僅讓我深化了技術，更讓我深刻體會到團隊溝通與解決問題的成就感。
    </div>
  </div>

  <div class="experience-box">
    <div class="experience-name">鍾其睿(25%)</div>
    <div class="experience-text">
      這次的網路程式設計期末專題，是繼上次多媒體程式設計後，第二次的團隊合作專案。回顧上一次的開發經驗，當時彼此間的合作默契還在磨合，在分工與時限掌控上出了些許問題，導致最終的專案呈現不如預期，甚至出了些程式上的錯誤。<br><br>

然而，歷經了先前的教訓，本次專案的組別，在其他課程已累積了豐富的合作經驗。為了能繳出良好的成果，我們這次採取了不同的策略，提早了至少一個月開始著手進行專案規劃，因此我們在時間進度上顯得游刃有餘。無論是前端遇到排版混亂，或是後端程式碼出現錯誤404，甚至是商品連接到資料庫，這種較複雜的問題，我們團隊都能在第一時間即時修正程式碼。<br><br>

最終，這個功能完善、前後端有高度一致性的CYER電商網站順利完成。看著順利運作的成果，內容讓我們十分滿意，也為這次的專案畫下最完美的期末句點。
    </div>
  </div>

  <a href="javascript:window.close();" class="btn-back">關閉此分頁</a>
</div>

</body>
</html>
