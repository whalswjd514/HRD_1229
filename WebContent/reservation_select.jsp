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
<h1>도서 예약정보 조회</h1>
<hr>
<table border=1 id="tab2">
	<tr>
		<th id="th2">no</th>
		<th id="th2">대출번호</th>
		<th id="th2">고객성명</th>
		<th id="th2">도서코드</th>
		<th id="th2">도서명</th>
		<th id="th2">대출일자</th>
		<th id="th2">반납일자</th>
		<th id="th2">대출상태</th>
		<th id="th2">등급</th>
		<th id="th2">관리</th>
	</tr>
<%
	request.setCharacterEncoding("utf-8");
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	int no=0;
	
	try{
		String sql="select b.lentno,b.custname,b.bookno,a.bookname,to_char(outdate,'yyyy-mm-dd'),to_char(indate,'yyyy-mm-dd'),b.status,b.dunggub from bookinfo1229 a,reservation1229 b where a.bookno=b.bookno";
		pstmt=conn.prepareStatement(sql);
		rs=pstmt.executeQuery();
		while(rs.next()){
			String lentno=rs.getString(1);
			String custname=rs.getString(2);
			String bookno=rs.getString(3);
			String bookname=rs.getString(4);
			String outdate=rs.getString(5);
			String indate=rs.getString(6);
			String status=rs.getString(7);
			String dunggub=rs.getString(8);
			no++;
			System.out.println("테이블 조회 성공");
%>
	<tr>
		<td><%=no %></td>
		<td><a href="reservation_update.jsp?lentno=<%=lentno %>" id="a1"><%=lentno %></a></td>
		<td><%=custname %></td>
		<td><%=bookno %></td>
		<td><%=bookname %></td>
		<td><%=outdate %></td>
		<td><%=indate %></td>
		<td><%=status %></td>
		<td><%=dunggub %></td>
		<td><a href="reservation_delete.jsp?lentno=<%=lentno %>" id="a1" onclick="if(!confirm('정말로 삭제하시겠습니까?')) return false;">삭제</a></td>
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
	<button type="button" onclick="location.href='reservation_insert.jsp'">도서 정보 추가</button>
</div>
</section>
<%@ include file="footer.jsp" %>
</body>
</html>