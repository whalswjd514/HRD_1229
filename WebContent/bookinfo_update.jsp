<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="header.jsp" %>
<%@ include file="nav.jsp" %>
<section>
<%@ include file="DBConn.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String bookno=request.getParameter("bookno");
	try{
		String sql="select * from bookinfo1229 where bookno=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, bookno);
		rs=pstmt.executeQuery();
		if(rs.next()){
			String author=rs.getString("author");
			String bookname=rs.getString("bookname");
%>
<form name=form method="post" action="bookinfo_updateProcess.jsp">
<h1>도서 정보 수정 화면</h1>
<table border=1 id="tab1">
	<tr>
		<th id="th1">도서코드</th>
		<td><input type="text" name="bookno" value="<%=bookno %>" id="in1"></td>
	</tr>
	<tr>
		<th id="th1">저자</th>
		<td><input type="text" name="author" value="<%=author %>" id="in1"></td>
	</tr>
	<tr>
		<th id="th1">도서이름</th>
		<td><input type="text" name="bookname" value="<%=bookname %>" id="in1"></td>
	</tr>
	<tr>
		<td colspan=2 align=center>
			<input type="button" value="수정" onclick="check()" id="btn1">
			<input type="reset" value="취소" id="btn1">
		</td>
	</tr>
</table>
<%
		}
	}catch(SQLException e){
		System.out.println("데이터 조회 실패");
	}
%>
</form>
<script>
	function check(){
		if(document.form.bookno.value==""){
			alert("도서코드가 입력되지 않았습니다.");
			document.form.bookno.focus();
		}else if(document.form.author.value==""){
			alert("작가가 입력되지 않았습니다.");
			document.form.author.focus();
		}else if(document.form.bookname.value==""){
			alert("도서이름 입력되지 않았습니다.");
			document.form.bookname.focus();
		}else{
			document.form.submit();
			alert("수정이 완료되었습니다.");
		}
	}
</script>
</section>
<%@ include file="footer.jsp" %>
</body>
</html>