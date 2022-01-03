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
	int no=0;
	try{
		String sql="select lentno_seq.nextval from dual";
		pstmt=conn.prepareStatement(sql);
		rs=pstmt.executeQuery();
		
		if(rs.next()){
			no=rs.getInt(1);
		}else{
			no=0;
		}
	}catch(SQLException e){
		System.out.println("시퀀스 조회 실패");
	}
	
	String bookno=request.getParameter("bookno");
	String custname=request.getParameter("custname");
	String outdate=request.getParameter("outdate");
	String indate=request.getParameter("indate");
	String t_bookno="",t_bookname="";
	int sel=0;
	if(bookno==null){
		bookno="";
		custname="";
		outdate="";
		indate="";
	}else{
	try{
		String sql="select bookno,bookname from bookinfo1229 where bookno=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1,bookno);
		rs=pstmt.executeQuery();
		if(rs.next()){
			t_bookno=rs.getString(1);
			t_bookname=rs.getString("bookname");
		}else{
%>
		<script>
			alert("등록되지 않은 도서코드입니다.");
		</script>
<%
		}
	}catch(SQLException e){
		System.out.println("bookinfo 테이블 오류");
		e.printStackTrace();
	}
	}
%>
<form name="form" method="post" action="reservation_insert.jsp">
<h1>도서 대출 예약 정보 등록 화면</h1>
<table border=1 id="tab3">
	<tr>
		<th id="th2">대출번호</th>
		<td><input type="text" name="lentno" value="<%=no %>"></td>
		<th id="th2">고객성명</th>
		<td><input type="text" name="custname" value="<%=custname %>"></td>
	</tr>
	<tr>
		<th id="th2">도서코드</th>
		<td><input type="text" name="bookno" value="<%=t_bookno %>" onchange="changesubmit();"></td>
		<th id="th2">도서이름</th>
		<td><input type="text" name="bookname" value="<%=t_bookname %>"></td>
	</tr>
	<tr>
		<th id="th2">대출일자</th>
		<td><input type="text" name="outdate" value="<%=outdate %>"></td>
		<th id="th2">반납일자</th>
		<td><input type="text" name="indate" value="<%=indate %>" onchange="changesubmit();"></td>
			<%if(indate==""){sel=1;}else{sel=0;} %>
	</tr>
	<tr>
		<th id="th2">대출상태</th>
		<td>
			<input type="radio" name="status" value="1" <%if(sel==1){%>checked<%}%>>대출
			<input type="radio" name="status" value="2" <%if(sel==0){%>checked<%}%>>반납
		</td>
		<th id="th2">등급</th>
		<td>
			<select name="dunggub" id="s1">
				<option value=""></option>
				<option value="S">S</option>
				<option value="A">A</option>
				<option value="B">B</option>
				<option value="C">C</option>
			</select>
		</td>
	</tr>
	<tr>
		<td colspan=4 align=center>
			<input type="submit" value="저장" onclick="check()" id="btn2">
			<input type="reset" value="취소" id="btn2">
		</td>
	</tr>
</table>
</form>
<script>
	function check(){
		if(document.form.lentno.value==""){
			alert("대출번호가 입력되지 않았습니다.");
			document.form.lentno.focus();
		}else if(document.form.custname.value==""){
			alert("고객성명이 입력되지 않았습니다.");
			document.form.custname.focus();
		}else if(document.form.bookno.value==""){
			alert("도서코드가 입력되지 않았습니다.");
			document.form.bookno.focus();
		}else if(document.form.outdate.value==""){
			alert("대출일자가 입력되지 않았습니다.");
			document.form.outdate.focus();
		}else{
			form.action="reservation_insertProcess.jsp";
		}
	}
	
	function changesubmit(){
		document.form.submit();
	}
</script>
</section>
<%@ include file="footer.jsp" %>
</body>
</html>