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

    String mName = request.getParameter("m_name");
    String mEmail = request.getParameter("m_email");
    String mPwd = request.getParameter("m_pwd");
    String mPhone = request.getParameter("m_phone");
    String mAddress = request.getParameter("m_address");

    if (mEmail == null || !mEmail.matches("^[A-Za-z0-9._%+-]+@gmail\\.com$")) {
        response.sendRedirect("register.jsp?error=invalid_email");
        return;
    }

    if (mPwd == null || mPwd.length() < 8) {
        response.sendRedirect("register.jsp?error=weak_pwd");
        return;
    }

    if (mPhone == null || !mPhone.matches("^\\d{10}$")) {
        response.sendRedirect("register.jsp?error=invalid_phone");
        return;
    }

    String sql = "INSERT INTO members (m_email, m_pwd, m_name, m_phone, m_address, m_role) VALUES (?, ?, ?, ?, ?, 0)";

    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
        ps.setString(1, mEmail);
        ps.setString(2, mPwd);
        ps.setString(3, mName);
        ps.setString(4, mPhone);
        ps.setString(5, mAddress);
        int rows = ps.executeUpdate();

        if (rows == 0) {
            response.sendRedirect("register.jsp?error=1");
            return;
        }
        
        try (ResultSet keys = ps.getGeneratedKeys()) {
            if (keys.next()) {
                session.setAttribute("m_id", keys.getInt(1));
            }
        }
        session.setAttribute("m_email", mEmail);
        session.setAttribute("m_name", mName);
        session.setAttribute("m_phone", mPhone);
        session.setAttribute("m_address", mAddress);
        session.setAttribute("m_role", 0);
        response.sendRedirect("member.jsp");
    } catch (SQLIntegrityConstraintViolationException duplicate) {
        response.sendRedirect("register.jsp?error=duplicate");
    } catch (Exception e) {
        response.sendRedirect("register.jsp?error=1");
    }
%>
