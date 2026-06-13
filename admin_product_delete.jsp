<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="admin_auth.jsp" %>
<%
    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        response.sendRedirect("admin_products.jsp");
        return;
    }

    int pId = 0;
    try { pId = Integer.parseInt(request.getParameter("p_id")); } catch (Exception ignored) {}

    if (pId > 0) {
        String sql = "UPDATE products SET is_active = 0 WHERE p_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pId);
            ps.executeUpdate();
        }
    }
    response.sendRedirect("admin_products.jsp?msg=inactive");
%>
