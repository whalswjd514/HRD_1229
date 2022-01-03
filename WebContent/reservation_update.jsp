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
	String lentno=request.getParameter("lentno");
	try{
		String sql="select b.custname,b.bookno,a.bookname,to_char(outdate,'yyyy-mm-dd'),to_char(indate,'yyyy-mm-dd'),b.status,b.dunggub from bookinfo1229 a,reservation1229 b where lentno=? and a.bookno=b.bookno";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, lentno);
		rs=pstmt.executeQuery();
		if(rs.next()){
			String custname=rs.getString(1);
			String bookno=rs.getString(2);
			String bookname=rs.getString(3);
			String outdate=rs.getString(4);
			String indate=rs.getString(5);
			String status=rs.getString(6);
			String dunggub=rs.getString(7);
			if(dunggub==null){
				dunggub="";
			}
%>
<form name="form" method="post" action="reservation_updateProcess.jsp">
<h1>도서 대출 예약 정보 수정 화면</h1>
<table border=1 id="tab3">
	<tr>
		<th id="th2">대출번호</th>
		<td><input type="text" name="lentno" value="<%=lentno %>"></td>
		<th id="th2">고객성명</th>
		<td><input type="text" name="custname" value="<%=custname %>"></td>
	</tr>
	<tr>
		<th id="th2">도서코드</th>
		<td><input type="text" name="bookno" value="<%=bookno %>" onchange="changesubmit();"></td>
		<th id="th2">도서이름</th>
		<td><input type="text" name="bookname" value="<%=bookname %>"></td>
	</tr>
	<tr>
		<th id="th2">대출일자</th>
		<td><input type="text" name="outdate" value="<%=outdate %>"></td>
		<th id="th2">반납일자</th>
		<td><input type="text" name="indate" value="<%=indate %>" onchange="changesubmit();"></td>
	</tr>
	<tr>
		<th id="th2">대출상태</th>
		<td>
			<input type="radio" name="status" value="1"<%=status.equals("1") ? "checked" : "" %>>대출
			<input type="radio" name="status" value="2"<%=status.equals("2") ? "checked" : "" %>>반납
		</td>
		<th id="th2">등급</th>
		<td>
			<select name="dunggub" id="s1">
				<option value=""<%if(dunggub==null){%>selected<%}%>></option>
				<option value="S"<%if(dunggub.equals("S")){%>selected<%}%>>S</option>
				<option value="A"<%if(dunggub.equals("A")){%>selected<%}%>>A</option>
				<option value="B"<%if(dunggub.equals("B")){%>selected<%}%>>B</option>
				<option value="C"<%if(dunggub.equals("C")){%>selected<%}%>>C</option>
			</select>
		</td>
	</tr>
	<tr>
		<td colspan=4 align=center>
			<input type="submit" value="수정" onclick="check()" id="btn2">
			<input type="reset" value="취소" id="btn2">
		</td>
	</tr>
</table>
</form>
<%
		}
	}catch(SQLException e){
		System.out.println("데이터 조회 실패");
	}
%>
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
			document.form.submit();
		}
	}

</script>
</section>
<%@ include file="footer.jsp" %>
</body>
</html>