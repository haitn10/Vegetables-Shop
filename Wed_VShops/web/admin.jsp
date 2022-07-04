<%-- 
    Document   : admin
    Created on : 08-Mar-2022, 01:46:33
    Author     : HTN
--%>

<%@page import="sample.product.Category"%>
<%@page import="sample.product.ProductDAO"%>
<%@page import="sample.product.ProductDTO"%>
<%@page import="sample.user.UserDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
        <!--CSS-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="color/admin/style.css">
    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null || !loginUser.getRoleID().equals("AD")) {
                response.sendRedirect("login.jsp");
                return;
            }
            String search = request.getParameter("search");
            if (search == null) {
                search = "";
            }
        %>
        <div class="header">
            <ul>    
                <li>
                    <h2><%= loginUser.getFullName()%></h2>
                    <h6>Administrator</h6>
                </li>
                <li class="search">
                    <form class="example" action="MainController">
                        <input type="text" name="search" value="<%= search%>" placeholder="Search by product name..." />
                        <input type="hidden" name="validation" value="AD"/>
                        <button type="submit" name="action" value="Search"><i class="fa fa-search"></i></button>
                    </form>
                </li>                

            </ul>
        </div>

        <div class="main">
            <a href="create.jsp" class="btn py-2 btn-light" style="font-size: 15px; margin-left: 50px;">Create New Product</a>
            <a href="MainController?action=Search&validation=AD&search= " class="btn py-2 btn-light" style="font-size: 15px; margin-left: 50px;">Show All</a>
            <a class="btn py-2 btn-light" href="MainController?action=Logout" style="float: right; margin-right: 50px">Log Out</a> 
            <%
                List<ProductDTO> listProduct = (List<ProductDTO>) request.getAttribute("LIST_PRODUCT");
                if (listProduct != null) {
                    if (listProduct.size() > 0) {
            %>
            <div class="show">
                <table class="responsive-table">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Product ID</th>
                            <th>Name</th>
                            <th>Image</th>
                            <th>Price</th>
                            <th >Quantity</th>
                            <th>Category ID</th>
                            <th>Import Date</th>
                            <th>Using Date</th>
                            <th>Status</th>
                            <th>Delete</th>
                            <th>Update</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int count = 1;
                            for (ProductDTO product : listProduct) {
                        %>
                        <tr>
                    <form action="MainController" method="POST">
                        <th scope="row"><%= count++%></th>
                        <td>
                            <input class="input" type="text" name="productID" value="<%= product.getProductID()%>" readonly=""/>
                        </td>
                        <td>
                            <input class="input" type="text" name="productName" value="<%= product.getProductName()%>" required=""/>
                        </td>
                        <td>
                            <input class="input" type="text" name="image" value="<%= product.getImage()%>"/>
                        </td>
                        <td>
                            <input class="input" type="text" name="price" value="<%= product.getPrice()%>" required=""/>
                        </td>
                        <td>
                            <input class="input" type="number" name="quantity" value="<%= product.getQuantity()%>" min="0" max="100" required=""/>
                        </td>
                        <td>
                            <select class="input" name="categoryID" >
                                <option value="<%= product.getCategoryID()%>"><%= product.getCategoryID()%></option>
                                <%
                                    ProductDAO dao = new ProductDAO();
                                    List<Category> listCate = dao.getCategory();
                                    if (listCate != null) {
                                        if (listCate.size() > 0) {
                                            for (Category cate : listCate) {
                                %>
                                <option value="<%= cate.getCategoryID()%>"><%= cate.getCategoryID()%></option>
                                <%
                                            }
                                        }
                                    }
                                %>
                            </select>
                        </td>
                        <td>
                            <input class="input" type="date" name="importDate" value="<%= product.getImportDate()%>" required=""/>
                        </td>
                        <td>
                            <input class="input" type="date" name="usingDate" value="<%= product.getUsingDate()%>" required=""/>
                        </td>
                        <td>
                            <select class="input" name="status" >
                                <option value="<%= product.getStatus()%>"><%= product.getStatus()%></option>
                                <option value="0">0</option>
                                <option value="1">1</option>
                            </select>
                        </td>
                        <td>
                            <a style="color: #000" href="MainController?action=Delete&productID=<%= product.getProductID()%>&validation=AD&search=<%= search%>">Delete</a>
                        </td>
                        <td>
                            <input type="hidden" name="validation" value="AD"/>
                            <input class="input" type="submit" name="action" value="Update"/>
                            <input class="input" type="hidden" name="search" value="<%= search%>"/>
                        </td>
                    </form>
                    </tr>
                    <%
                        }
                    %>

                    </tbody>
                </table>
            </div>
            <%
                String error = (String) request.getAttribute("ERROR");
                if (error == null) {
                    error = "";
                }
            %>
            <%= error%>

            <%
                    }
                }
            %>

    </body>
</html>
