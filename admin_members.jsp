<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="admin_auth.jsp" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head><meta charset="UTF-8"><title>會員管理</title></head>
<body>
<%@ include file="admin_header.jsp" %>
<main class="admin-shell">
  <div class="panel">
    <h1>會員管理</h1>
    <table>
      <thead>
        <tr><th>會員編號</th><th>Email / 帳號</th><th>姓名</th><th>電話</th><th>地址</th><th>角色</th><th>註冊時間</th></tr>
      </thead>
      <tbody>
<%
    String sql = "SELECT m_id, m_email, m_name, m_phone, m_address, m_role FROM members ORDER BY m_id";
    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
%>
        <tr>
          <td><%= rs.getInt("m_id") %></td>
          <td><%= h(rs.getString("m_email")) %></td>
          <td><%= h(rs.getString("m_name")) %></td>
          <td><%= h(rs.getString("m_phone")) %></td>
          <td><%= h(rs.getString("m_address")) %></td>
          <td><%= rs.getInt("m_role") == 1 ? "管理員" : "一般會員" %></td>
          <td>資料表未提供</td>
        </tr>
<%
        }
    } catch (Exception e) {
%>
        <tr><td colspan="7"><%= h(e.getMessage()) %></td></tr>
<%
    }
%>
      </tbody>
    </table>
  </div>
</main>
</body>
</html>
