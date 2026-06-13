<%@ page pageEncoding="UTF-8" import="java.sql.*" %>
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
    response.setContentType("text/html; charset=UTF-8");

    Object roleObj = session.getAttribute("m_role");
    boolean isAdminUser = Boolean.TRUE.equals(session.getAttribute("is_admin"));
    if (roleObj instanceof Integer) {
        isAdminUser = isAdminUser || ((Integer) roleObj).intValue() == 1;
    } else if (roleObj != null) {
        isAdminUser = isAdminUser || "1".equals(roleObj.toString());
    }

    if (!isAdminUser) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
