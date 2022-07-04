<%-- 
    Document   : create
    Created on : 08-Mar-2022, 10:23:07
    Author     : HTN
--%>

<%@page import="sample.product.ProductDAO"%>
<%@page import="sample.product.Category"%>
<%@page import="java.util.List"%>
<%@page import="sample.user.UserDTO"%>
<%@page import="sample.product.ProductError"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Page</title>
        <!--CSS-->
        <link href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
        <link href="color/create/vendor/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
        <link href="color/create/vendor/font-awesome-4.7/css/font-awesome.min.css" rel="stylesheet" media="all">
        <link href="color/create/vendor/select2/select2.min.css" rel="stylesheet" media="all">
        <link href="color/create/vendor/datepicker/daterangepicker.css" rel="stylesheet" media="all">
        <link href="color/create/css/main.css" rel="stylesheet" media="all">
    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null || !loginUser.getRoleID().equals("AD")) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <div class="page-wrapper bg-gra-02 p-t-100 p-b-100 font-poppins">
            <div class="card-a">
                <a href="admin.jsp">Go back</a>
            </div>
            <div class="wrapper wrapper--w680">
                <div class="card card-4">
                    <div class="card-body">
                        <h2 class="title">Add New Product</h2>
                        <%
                            ProductError productError = (ProductError) request.getAttribute("PRODUCT_ERROR");
                            if (productError == null) {
                                productError = new ProductError();
                            }
                        %>
                        <form action="MainController" method="POST">
                            <div class="row row-space">
                                <div class="col-2">
                                    <div class="input-group">
                                        <label class="label">Product ID</label>
                                        <input class="input--style-4" type="text" name="productID" required=""/>
                                        <div style="color: red;"><%= productError.getProductIDError()%></div>
                                    </div>
                                </div>
                                <div class="col-2">
                                    <div class="input-group">
                                        <label class="label">Product Name</label>
                                        <input class="input--style-4" type="text" name="productName" required=""/>
                                        <div style="color: red;"><%= productError.getProductNameError()%></div>
                                    </div>
                                </div>
                            </div>
                            <div class="row row-space">
                                <div class="col-2">
                                    <div class="input-group">
                                        <label class="label">Price</label>
                                        <input class="input--style-4" type="text" name="price" min="0" required=""/>

                                    </div>
                                </div>
                                <div class="col-2">
                                    <div class="input-group">
                                        <label class="label">Quantity</label>
                                        <input class="input--style-4" type="number" name="quantity" min="0" required=""/>
                                    </div>
                                </div>
                            </div>
                            <div class="row row-space">
                                <div class="col-2">
                                    <div class="input-group">
                                        <label class="label">Image</label>
                                        <input class="input--style-4" type="text" name="image"/>
                                        <div style="color: red;"><%= productError.getImageError()%></div>
                                    </div>
                                </div>
                                <div class="col-2">
                                    <div class="input-group">
                                        <label class="label">Category</label>
                                        <select class="input--style-4" name="categoryID" >
                                            <option value="" selected disabled hidden>Choose here</option>
                                            <%
                                                ProductDAO dao = new ProductDAO();
                                                List<Category> listCate = dao.getCategory();
                                                if (listCate != null) {
                                                    if (listCate.size() > 0) {
                                                        for (Category cate : listCate) {
                                            %>
                                            <option value="<%= cate.getCategoryID()%>"><%= cate.getCategoryName() %></option>
                                            <%
                                                        }
                                                    }
                                                }
                                            %>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row row-space">
                                <div class="col-2">
                                    <div class="input-group">
                                        <label class="label">Import Date</label>
                                        <input class="input--style-4" type="date" name="importDate" min="1/3/2022" max="30/3/2022" required=""/>
                                        <div style="color: red;"><%= productError.getImportDateError()%></div>
                                    </div>
                                </div>
                                <div class="col-2">
                                    <div class="input-group">
                                        <label class="label">Using Date</label>
                                        <input class="input--style-4" type="date" name="usingDate" required=""/>
                                        <div style="color: red;"><%= productError.getUsingDateError()%></div>
                                    </div>
                                </div>
                            </div>
                            <%
                                String error = (String) request.getAttribute("ERROR");
                                if (error == null) {
                                    error = "";
                                }
                            %>
                            <input type="hidden" name="status" value="1"/>
                            <div style="color: red"><%= error%></div>
                            <div class="p-t-15">
                                <input class="btn btn--radius-2 btn--blue" type="submit" name="action" value="Create"/>
                            </div>  
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <!-- Jquery JS-->
        <script src="color/create/vendor/jquery/jquery.min.js"></script>
        <script src="color/create/vendor/select2/select2.min.js"></script>
        <script src="color/create/vendor/datepicker/moment.min.js"></script>
        <script src="color/create/js/global.js"></script>

    </body>
</html>
