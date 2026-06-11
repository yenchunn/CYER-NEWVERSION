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
    <div class="experience-name">杜書瑋</div>
    <div class="experience-text">
      這是杜書瑋的心得內容。
    </div>
  </div>

  <div class="experience-box">
    <div class="experience-name">黃語芬</div>
    <div class="experience-text">
      這是黃語芬的心得內容。
    </div>
  </div>

  <div class="experience-box">
    <div class="experience-name">陳彥均</div>
    <div class="experience-text">
      這是陳彥均的心得內容。
    </div>
  </div>

  <div class="experience-box">
    <div class="experience-name">鍾其睿</div>
    <div class="experience-text">
      這是鍾其睿的心得內容。
    </div>
  </div>

  <a href="javascript:window.close();" class="btn-back">關閉此分頁</a>
</div>

</body>
</html>