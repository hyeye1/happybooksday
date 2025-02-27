<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.kh.notice.model.vo.Notice, com.kh.common.model.vo.PageInfo, com.kh.member.model.vo.Member "%>
<%
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	ArrayList<Notice> list = (ArrayList<Notice>)request.getAttribute("list");
 	String contextPath = request.getContextPath(); 
 	Member loginUser = (Member)session.getAttribute("loginUser");
 	
 	int currentPage = pi.getCurrentPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
	int maxPage = pi.getMaxPage();
	
%>   

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
    .outer{
            margin-top: 50px;
            margin: auto;
            margin-bottom: 20px;
            border: 1px solid white;
            width:800px;
    }
    .listArea{
        border: 1px solid black;
        text-align: center;
    }
    .listArea>tbody>tr:hover{
        cursor:pointer;
        background: rgb(249, 219, 122);
        color: white;
    }
    #text1{font-size:x-large; font-weight: bold;}
    #text2{color:rgb(241, 196, 15); font-weight: bold;}
    #btn{
            width: 70px;
            height: 30px;
            font-size: small;
            font-weight: bold;
            color: gray;
            border: 1px solid lightgrey;
            background-color: rgb(249, 219, 122);
            border-radius: 4px;
            padding: 5px;
            cursor: pointer;
    }
    #btn:hover{background-color: rgb(249, 219, 122); color:white;}
    .outer2{margin-left: 700px;}
    #btn2{
            border: 1px solid lightgray;
            color: black;
            background-color: lightgray;
            border-radius: 5px;
            padding: 6px;
            }
    #btn2:hover{background-color: rgb(249, 219, 122); color:white;}
    .pageButton{font-size: medium; margin-left: 310px;}
    #top{height: 30px; background-color: rgb(249, 219, 122);}
</style>

</head>
<body>
	<div class="outer">
        <span id="text1">공지사항</span> &emsp;최신
        <span id="text2">해피북스데이</span>
        <span> 소식을 확인하실 수 있습니다.</span><hr>
        <!-- 로그인했고, 로그인한 사용자가 admin일 경우 보여지는 div -->
        <% if(loginUser != null) { %>
	        <div align="right" style="width:800px" >
	            <a href="<%= contextPath %>/enrollForm.no" class="btn btn-secondary btn-sm" id="btn">
                    글작성</a>
	           
	        </div>
	         <br>
        <% } %>
         
        <table class="listArea" align="center">
            <thead>
                <tr id="top">
                    <th>글번호</th>
                    <th width="370">글제목</th>
                    <th width="150">작성자</th>
                    <th>조회수</th>
                    <th width="130">작성일</th>
                </tr>
            </thead>
            <tbody>
            <% if(list.isEmpty()){ %>
             	<tr>
             		<td colspan="5">존재하는 공지사항이 없습니다. </td>
             	</tr>
            <%} else { %>
            	<% for(Notice n:list) { %>
	                <tr>
	                    <td><%= n.getNoNo() %></td>
	                    <td><%= n.getNoTitle() %></td>
	                    <td><%= n.getNoWriter() %></td>
	                    <td><%= n.getNoCount() %></td>
	                    <td><%= n.getNoDate() %></td>
	                </tr>
	            <%} %>
             <%} %>
          
            </tbody>
        </table>
        <script>
        $(function(){
    		$(".listArea>tbody>tr").click(function(){
    			
    			// 쿼리스트링 이용해서 요청할 url 작성
    			location.href = '<%=contextPath%>/detail.no?nno=' + $(this).children().eq(0).text();
    		})
    	})
        </script>
     

    
    
         <br><br>
	
        <div align="center" class="pagingArea">

			<% if(currentPage != 1) { %>
            	<button onclick="location.href='<%=contextPath%>/list.no?currentPage=<%=currentPage-1%>';">이전</button>
			<% } %>
			
			<% for(int p=startPage; p<=endPage; p++) { %>
				
				<% if(currentPage == p){ %>
            		<button disabled><%= p %></button>
            	<% }else{ %>
            		<button onclick="location.href='<%=contextPath%>/list.no?currentPage=<%= p %>';"><%= p %></button>
            	<% } %>
            	
			<% } %>
			
			<% if(currentPage != maxPage){ %>
            	<button onclick="location.href='<%=contextPath%>/list.no?currentPage=<%=currentPage+1%>';">다음</button>
			<% } %>
			
        </div>
    
    </div>
    
    
   
	
        
</body>
</html>