<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="DBConn.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	PreparedStatement pstmt=null;
	String bookno=request.getParameter("bookno");
	try{
		String sql="delete from bookinfo1229 where bookno=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, bookno);
		pstmt.executeUpdate();
		System.out.println("데이터 삭제 성공");
%>
		<script>
			alert("삭제가 완료되었습니다.");
			location.href="bookinfo_select.jsp";
		</script>
<%
	}catch(SQLException e){
		System.out.println("데이터 삭제 실패");
	}
%>
		<script>
			alert("삭제 실패");
			history.back(-1);
		</script>
</body>
</html>