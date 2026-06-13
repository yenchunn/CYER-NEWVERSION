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

    String mEmail = request.getParameter("m_email");
    String mPwd = request.getParameter("m_pwd");
    String sql = "SELECT m_id, m_email, m_name, m_phone, m_address, m_role FROM members WHERE m_email = ? AND m_pwd = ?";

    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, mEmail);
        ps.setString(2, mPwd);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                session.setAttribute("m_id", rs.getInt("m_id"));
                session.setAttribute("m_email", rs.getString("m_email"));
                session.setAttribute("m_name", rs.getString("m_name"));
                session.setAttribute("m_phone", rs.getString("m_phone"));
                session.setAttribute("m_address", rs.getString("m_address"));
                session.setAttribute("m_role", rs.getInt("m_role"));
                boolean isAdmin = rs.getInt("m_role") == 1;
                session.setAttribute("is_admin", isAdmin);
                if (isAdmin) {
                    response.sendRedirect("admin_index.jsp");
                } else {
                    response.sendRedirect("member.jsp");
                }
            } else {
                response.sendRedirect("login.jsp?error=1");
            }
        }
    } catch (Exception e) {
        response.sendRedirect("login.jsp?error=1");
    }
%>
