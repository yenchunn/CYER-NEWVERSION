<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    // 1. 設定編碼，防止中文變亂碼
    request.setCharacterEncoding("UTF-8");

    // 2. 檢查 Session 確保會員必須是登入狀態
    Integer loggedInMemberId = (Integer) session.getAttribute("m_id");

    // 3. 安全防禦：若未登入，跳出警告視窗並退回
    if (loggedInMemberId == null) {
        out.println("<script type='text/javascript'>");
        out.println("alert('需登入會員以使用留言功能');");
        out.println("history.back();");
        out.println("</script>");
        return; 
    }

    // 4. 已登入，接收前台表單傳過來的文字參數
    String pIdStr = request.getParameter("p_id");
    String mName = request.getParameter("m_name"); // 會員姓名(可匿名) 的輸入值
    String rStarsStr = request.getParameter("r_stars");
    String rContent = request.getParameter("r_content");

    if (pIdStr != null && mName != null && rStarsStr != null && rContent != null) {
        
        String url = "jdbc:mysql://localhost:3306/cyer?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Taipei";
        String user = "root";
        String password = "1234";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(url, user, password)) {
                
                int finalMemberId = 0;
                
                // 檢查資料庫 members 表裡有沒有使用者剛才輸入的這個名字
                String checkMemberSql = "SELECT m_id FROM members WHERE m_name = ?";
                try (PreparedStatement checkPs = conn.prepareStatement(checkMemberSql)) {
                    checkPs.setString(1, mName.trim());
                    try (ResultSet rs = checkPs.executeQuery()) {
                        if (rs.next()) {
                            finalMemberId = rs.getInt("m_id"); // 有找到就拿他的 m_id
                        }
                    }
                }
                

                // 如果是新名字或使用者輸入了新的匿名名稱，自動創立該身份，並一次補齊所有限制欄位
                if (finalMemberId == 0) {
                    
                    // 用當前時間的千分之一秒（System.currentTimeMillis()），動態製造絕對不重複的隨機信箱
                    String randomEmail = "guest_" + System.currentTimeMillis() + "@cyer.com";

                    // 把所有 NOT NULL 的欄位（信箱、密碼、電話、地址、權限）通通加進來
                    String insertMemberSql = "INSERT INTO members (m_name, m_email, m_pwd, m_phone, m_address, m_role) VALUES (?, ?, ?, ?, ?, ?)";
                    try (PreparedStatement insertMemPs = conn.prepareStatement(insertMemberSql, Statement.RETURN_GENERATED_KEYS)) {
                        insertMemPs.setString(1, mName.trim());
                        insertMemPs.setString(2, randomEmail);         // 改帶入動態產生的不重複信箱
                        insertMemPs.setString(3, "default123");       
                        insertMemPs.setString(4, "0900000000");       
                        insertMemPs.setString(5, "台灣美學空間");        
                        insertMemPs.setInt(6, 0);                      
                        
                        insertMemPs.executeUpdate();
                        try (ResultSet generatedKeys = insertMemPs.getGeneratedKeys()) {
                            if (generatedKeys.next()) {
                                finalMemberId = generatedKeys.getInt(1);
                            }
                        }
                    }
                }
                
                // 5. 正式將評論寫入 reviews 表，r_date 帶入 NOW() 排序自動置頂
                String insertReviewSql = "INSERT INTO reviews (p_id, m_id, r_stars, r_content, r_date) VALUES (?, ?, ?, ?, NOW())";
                try (PreparedStatement pstmt = conn.prepareStatement(insertReviewSql)) {
                    pstmt.setInt(1, Integer.parseInt(pIdStr));
                    pstmt.setInt(2, finalMemberId);
                    pstmt.setInt(3, Integer.parseInt(rStarsStr));
                    pstmt.setString(4, rContent);
                    
                    int result = pstmt.executeUpdate();
                    if (result > 0) {
                        // 成功後重導回原商品頁
                        response.sendRedirect("product_detail.jsp?p_id=" + pIdStr);
                    } else {
                        out.println("<script>alert('留言失敗'); history.back();</script>");
                    }
                }
            }
        } catch (Exception e) {
            out.println("資料庫運作發生錯誤：" + e.getMessage());
        }
    } else {
        response.sendRedirect("index.jsp");
    }
%>