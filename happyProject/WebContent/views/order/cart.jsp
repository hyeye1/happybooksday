<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.order.model.vo.Cart, com.kh.book.model.vo.Book, java.util.ArrayList, java.text.*"%>
<%
	ArrayList<Cart> list = (ArrayList<Cart>)request.getAttribute("list");

	DecimalFormat df = new DecimalFormat("#,###,###");
	int total = (Integer)request.getAttribute("total");
	String totalComma = df.format(total);
	
	int discountTotal = (Integer)request.getAttribute("discountTotal");
	String discountComma = df.format(discountTotal);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>담은장바구니</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .cartOuter{
            width:1000px;
            height:100%;
            margin:auto;
        }

        .cartOuter .text{
            float:left;
        }
        
        /* 주문 단계 */
        .cartOuter .step{
            text-align: right;
        }
        .cartOuter .showStep{
            border:none;
            border-radius: 20px;
            padding:10px;
            background: rgb(250, 211, 81);
        }
        .cartOuter .step1{
            background: rgb(248, 229, 165);
        }

        /* 카트 창 */
        .cartOuter .cartView{
            width:680px;
            /*height:300px;*/
            margin-top: 20px;
            float:left;
        }
        .cartOuter .cartView table{
            width:100%;
            font-size: 15px;
            line-height:20px;
            border-top:1px solid black;
            border-bottom:1px solid black;
        }
        .cartOuter .cartView table td{
            border-top:1px solid darkgray;
            padding:20px;
        }

         /* 화살표 없애기 */
        input[type="number"]::-webkit-outer-spin-button,
        input[type="number"]::-webkit-inner-spin-button{
            -webkit-appearance: none;
            margin:0px;
        }
        /* 버튼 */
        .cartOuter .button{
            border:none;
            background:rgb(249, 219, 122);
            border-radius: 5px;
            padding:5px 10px 5px 10px;
        }
        input[type=checkbox]{
            zoom:1.5;
        }

         /* 써머리 창 */
         .cartOuter .summaryBox{
            border:1px solid darkgray;
            width:300px;
            height:200px;
            display:table-cell;
            float:right;
            margin-top:20px;
        }
        .cartOuter .priceInfo{
            height:65%;
        }
        .cartOuter .priceInfo table{
            margin:auto;
            width:250px;
            height:100%;
            color:grey;
            line-height:1px;
            letter-spacing: -1px;
        }
        .cartOuter .priceInfo .price{
            color:black;
        }
        .cartOuter .totalInfo{
            height:35%;
            background:rgb(252, 233, 170);
        }
        .cartOuter .totalInfo table{
            margin:auto;
            width:250px;
            height:100%;
            font-size:18px
        }
        /* 버튼 */
        .cartOuter #selectBuy{
            width:300px;
            height:60px;
            float:right;
            margin-top:10px;
            background: rgb(249, 219, 122);
            border:none;
            font-size:16px;
            font-weight: bolder;
        }

    </style>
</head>
<body>
	
	<%@ include file = "../common/menubar.jsp" %>
	
	 <div class="cartOuter">

        <br><br>

        <!-- 장바구니타이틀, 단계-->
        <div>
            <div class="text">
                <h2 style="display:inline;">장바구니</h2>
            </div>
            <div class="step">
                <button class="showStep btn btn-primary" disabled>01 장바구니 ></button>
                <button class="showStep step1 btn btn-primary" disabled>02 주문하기 ></button>
                <button class="showStep step1 btn btn-primary" disabled>03 결제완료 </button>
            </div>
        </div>
        <hr>
        <!-- 장바구니 창 -->
        <div class="cartView">
            <table>
                <tr>
                    <td colspan="3" style="height:50px;">
                        <input type="checkbox" id="selectAll" checked>
                        <label for="selectAll">전체선택</label>
                    </td>
                    <td align="center"><button class="button">선택삭제</button></td>
                </tr>
                	
	                <% for(Cart c : list) { %> 
	                <tr>
	                    <td style="height:100px;"><input type="checkbox" checked></td>
	                    <td align="center"><img src="<%= c.getMainImg() %>" style="width:80px; height:100px;"></td>
	                    <td>
	                        <p><%= c.getTitle() %></p>
	                        <small><%= c.getAuthor() %></small> <br><br>
	                        <button class="button">-</button>
	                        <input type="number" value="<%= c.getAmount() %>" min="1" max="9">
	                        <button class="button">+</button> <button class="button" type="rest">삭제</button>
	                    </td>
	                    <td align="center"><%= c.getTtPrice() %> 원</td>
	                </tr>
	                <% } %>
            </table>
        </div>

        <!-- 장바구니 써머리 창 -->
        <div class="summaryBox">
            <div class="priceInfo">
                <table>
                    <tr>
                        <td colspan="2">
                            <img src="resources/images/cart/checked2.png" style="width:20px;"> 
                            <label for="">0권을 선택하셨습니다.</label> 
                        </td>
                    </tr>
                    <tr>
                        <td>총 상품 금액</td>
                        <td class="price" style="text-align: right;"><%= totalComma %> 원</td>
                    </tr>
                    <tr>
                        <td>할인 금액</td>
                        <td class="price" style="text-align: right;"><%= discountComma %> 원</td>
                    </tr>
                </table>
            </div>
            <div class="totalInfo">
                <table>
                    <tr>
                        <td>합계</td>
                        <td style="text-align: right;"><%= totalComma %> 원</td>
                    </tr>
                </table>
            </div>
        </div>
        <button id="selectBuy" class="btn btn-warning btn-lg" onclick="cartPage();">선택 구매하기</button>
       	<script>
       		function cartPage(){
       			location.href = "<%= contextPath %>/order.or";
       		}
       	</script>
    </div>
    
    

</body>
</html>