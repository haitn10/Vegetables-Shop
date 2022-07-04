<%-- 
    Document   : checkout
    Created on : 09-Mar-2022, 23:44:56
    Author     : HTN
--%>

<%@page import="java.util.List"%>
<%@page import="sample.product.ProductDTO"%>
<%@page import="sample.product.Cart"%>
<%@page import="sample.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout Page</title>
        <!--CSS-->
        <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="color/shop/css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="color/shop/css/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="color/shop/css/elegant-icons.css" type="text/css">
        <link rel="stylesheet" href="color/shop/css/nice-select.css" type="text/css">
        <link rel="stylesheet" href="color/shop/css/jquery-ui.min.css" type="text/css">
        <link rel="stylesheet" href="color/shop/css/owl.carousel.min.css" type="text/css">
        <link rel="stylesheet" href="color/shop/css/slicknav.min.css" type="text/css">
        <link rel="stylesheet" href="color/shop/css/style.css" type="text/css">
    </head>
    <body>

        <!-- Header Section Begin -->
        <header class="header">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3">
                        <div class="header__logo">
                            <a href="#"><img src="color/shop/img/logo.png" alt=""></a>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <nav class="header__menu">
                            <ul>
                                <li><a href="#">Home</a></li>
                                <li class="active"><a href="MainController?action=Load">Shop</a></li>
                                <li><a href="#">Pages</a></li>
                                <li><a href="#">Blog</a></li>
                                <li><a href="#">Contact</a></li>
                            </ul>
                        </nav>
                    </div>
                    <div class="col-lg-3">
                        <div class="hero__search__phone">
                            <%
                                UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
                                if (loginUser == null) {
                            %>
                            <div class="hero__search__phone__icon">
                                <i class="fa fa-user"></i>
                            </div>
                            <div class="hero__search__phone__text">
                                <h4><a href="login.jsp">Login</a></h4>
                            </div>
                            <%
                            } else {
                            %>
                            <div class="hero__search__phone__icon">
                                <i class="fa fa-user"></i>
                            </div>
                            <div class="hero__search__phone__text">
                                <h4><a href="MainController?action=Logout">Logout</a></h4>
                            </div>
                            <%
                                }
                            %> 
                        </div>
                    </div>
                </div>
                <div class="humberger__open">
                    <i class="fa fa-bars"></i>
                </div>
            </div>
        </header>
        <!-- Header Section End -->

        <!-- Hero Section Begin -->
        <section class="hero hero-normal">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3">
                        <div class="hero__categories">
                            <div class="hero__categories__all">
                                <i class="fa fa-bars"></i>
                                <span>All departments</span>
                            </div>
                            <ul>
                                <li><a href="#">Fresh Meat</a></li>
                                <li><a href="#">Vegetables</a></li>
                                <li><a href="#">Fruit & Nut Gifts</a></li>
                                <li><a href="#">Fresh Berries</a></li>
                                <li><a href="#">Ocean Foods</a></li>
                                <li><a href="#">Butter & Eggs</a></li>
                                <li><a href="#">Fastfood</a></li>
                                <li><a href="#">Fresh Onion</a></li>
                                <li><a href="#">Papayaya & Crisps</a></li>
                                <li><a href="#">Oatmeal</a></li>
                                <li><a href="#">Fresh Bananas</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-9">
                        <div class="hero__search">
                            <div class="hero__search__form">
                                <form action="MainController">
                                    <input type="text" name="search" placeholder="What do you need?">
                                    <input type="hidden" name="validation" value="US">
                                    <button type="submit" name="action" value="Search" class="site-btn">SEARCH</button>
                                </form>
                            </div>
                            <div class="hero__search__phone_a">
                                <div class="header__cart">
                                    <ul>
                                        <li><a href="viewCart.jsp"><i class="fa fa-shopping-cart"></i></a></li>
                                    </ul>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Hero Section End -->

        <!-- Breadcrumb Section Begin -->
        <section class="breadcrumb-section set-bg" data-setbg="color/shop/img/panel.jpg">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <div class="breadcrumb__text">
                            <h2>Checking Out</h2>
                            <div class="breadcrumb__option">
                                <a href="#">Home</a>
                                <span>Checking Out</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Breadcrumb Section End -->

        <!-- Shoping Cart Section Begin -->
        <section class="shoping-cart spad">
            <h3 style="margin-left: 150px; padding-bottom: 50px">Congratulations on successfully checkout!</h3>
            <div class="container">
                <div class="row success">
                    <div class="col-lg-12">
                        <div class="shoping__cart__table">
                            <table>
                                <thead>
                                    <tr>
                                        <th class="shoping__product">Products</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Total</th>
                                        
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        List<ProductDTO> product = (List<ProductDTO>) request.getAttribute("LIST_PRODUCT");
                                        for (ProductDTO list : product) {
                                    %>
                                    <tr>
                                        <td class="shoping__cart__item">
                                            <img src="<%= list.getImage()%>" alt="">
                                            <h5><%= list.getProductName()%></h5>
                                        </td>

                                        <td class="shoping__cart__price">
                                            $<%= list.getPrice()%>
                                        </td>
                                        <td class="shoping__cart__quantity">
                                            <div class="quantity">                                             
                                                    <h5><%= list.getQuantity()%></h5>                      

                                            </div>
                                        </td>
                                        <td class="shoping__cart__total">
                                            $<%= list.getPrice() * list.getQuantity()%>
                                        </td> 
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="shoping__cart__btns">
                            <a href="MainController?action=Load" class="primary-btn cart-btn">CONTINUE SHOPPING</a>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <%
                            double total = 0;
                            for (ProductDTO list : product) {
                                total += list.getPrice() * list.getQuantity();
                            }
                        %>
                        <div class="shoping__checkout__a">
                            <h5>Cart Total</h5>
                            <ul>
                                <li>Total <span><%= total%></span></li>
                            </ul>
                        </div>
                    </div>            
                </div>
            </div>
        </section>
        <!-- Shoping Cart Section End -->

        <!-- Footer Section Begin -->
        <footer class="footer spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="footer__about">
                            <div class="footer__about__logo">
                                <a href="#"><img src="color/shop/img/logo.png" alt=""></a>
                            </div>
                            <ul>
                                <li>Address: 60-49 Road 11378 New York</li>
                                <li>Phone: +65 11.188.888</li>
                                <li>Email: hello@colorlib.com</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-6 offset-lg-1">
                        <div class="footer__widget">
                            <h6>Useful Links</h6>
                            <ul>
                                <li><a href="#">About Us</a></li>
                                <li><a href="#">About Our Shop</a></li>
                                <li><a href="#">Secure Shopping</a></li>
                                <li><a href="#">Delivery infomation</a></li>
                                <li><a href="#">Privacy Policy</a></li>
                                <li><a href="#">Our Sitemap</a></li>
                            </ul>
                            <ul>
                                <li><a href="#">Who We Are</a></li>
                                <li><a href="#">Our Services</a></li>
                                <li><a href="#">Projects</a></li>
                                <li><a href="#">Contact</a></li>
                                <li><a href="#">Innovation</a></li>
                                <li><a href="#">Testimonials</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12">
                        <div class="footer__widget">
                            <h6>Join Our Newsletter Now</h6>
                            <p>Get E-mail updates about our latest shop and special offers.</p>
                            <form action="#">
                                <input type="text" placeholder="Enter your mail">
                                <button type="submit" class="site-btn">Subscribe</button>
                            </form>
                            <div class="footer__widget__social">
                                <a href="#"><i class="fa fa-facebook"></i></a>
                                <a href="#"><i class="fa fa-instagram"></i></a>
                                <a href="#"><i class="fa fa-twitter"></i></a>
                                <a href="#"><i class="fa fa-pinterest"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="footer__copyright">
                            <div class="footer__copyright__text"><p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                    Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                                    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p></div>
                            <div class="footer__copyright__payment"><img src="color/shop/img/payment-item.png" alt=""></div>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
        <!-- Footer Section End -->

        <!-- Js Plugins -->
        <script src="color/shop/js/jquery-3.3.1.min.js"></script>
        <script src="color/shop/js/bootstrap.min.js"></script>
        <script src="color/shop/js/jquery.nice-select.min.js"></script>
        <script src="color/shop/js/jquery-ui.min.js"></script>
        <script src="color/shop/js/jquery.slicknav.js"></script>
        <script src="color/shop/js/mixitup.min.js"></script>
        <script src="color/shop/js/owl.carousel.min.js"></script>
        <script src="color/shop/js/main.js"></script>


    </body>
</html>
