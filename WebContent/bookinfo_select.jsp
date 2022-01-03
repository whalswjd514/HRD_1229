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
<h1>도서정보 목록</h1>
<hr>
<table border=1 id="tab2">
	<tr>
		<th id="th2">no</th>
		<th id="th2">도서코드</th>
		<th id="th2">저자</th>
		<th id="th2">도서명</th>
		<th id="th2">구분</th>
	</tr>
<%
	request.setCharacterEncoding("utf-8");
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	int no=0;
	
	try{
		String sql="select * from bookinfo1229";
		pstmt=conn.prepareStatement(sql);
		rs=pstmt.executeQuery();
		while(rs.next()){
			String bookno=rs.getString(1);
			String author=rs.getString(2);
			String bookname=rs.getString(3);
			no++;
			System.out.println("테이블 조회 성공");
%>
	<tr>
		<td><%=no %></td>
		<td><a href="bookinfo_update.jsp?bookno=<%=bookno %>" id="a1"><%=bookno %></a></td>
		<td><%=author %></td>
		<td><%=bookname %></td>
		<td><a href="bookinfo_delete.jsp?bookno=<%=bookno %>" id="a1" onclick="if(!confirm('정말로 삭제하시겠습니까?')) return false;">삭제</a></td>
	</tr>
<%
			}
	}catch(SQLException e){
		System.out.println("테이블 조회 실패");
		e.printStackTrace();
	}
%>
</table>
<div class="btn_group" align=center>
	<button type="button" onclick="location.href='bookinfo_insert.jsp'">도서 정보 추가</button>
</div>
</section>
<%@ include file="footer.jsp" %>
</body>
</html>