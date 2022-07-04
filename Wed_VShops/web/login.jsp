<%-- 
    Document   : login
    Created on : 08-Mar-2022, 09:56:17
    Author     : HTN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <!--CSS-->
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="color/login/fonts/icomoon/style.css">
        <link rel="stylesheet" href="color/login/css/owl.carousel.min.css">
        <link rel="stylesheet" href="color/login/css/bootstrap.min.css">
        <link rel="stylesheet" href="color/login/css/style.css">
    </head>
    <body>

        <!-- Header Section Begin -->
        <div class="d-md-flex half">
            <div class="bg" style="background-image: url('color/login/images/b1.jpg');"></div>
            <div class="contents">
                <div class="container">
                    <div class="row align-items-center justify-content-center">
                        <div class="col-md-12">

                            <div class="form-block mx-auto">
                                <div class="text-center mb-5">
                                    <h3 class="text-uppercase">Login to <strong>VSHOPs</strong></h3>
                                </div>
                                <!--Login-->
                                <form action="MainController" method="POST" id="check">
                                    <div class="form-group first">
                                        <label for="username">Username</label>
                                        <input class="form-control" type="text" name="userID" required="" placeholder="Your UserID" />
                                    </div>
                                    <div class="form-group last mb-3">
                                        <label for="password">Password</label>
                                        <input class="form-control" type="password" name="password" required="" placeholder="Your Password" />
                                    </div>
                                    <%
                                        String error = (String) request.getAttribute("ERROR");
                                        if (error == null) {
                                            error = "";
                                        }
                                    %>
                                    <div style="color: red"><%= error%></div>

                                    <!--recaptcha-->
                                    <div class="g-recaptcha" data-sitekey="6LeUS7AeAAAAAFWI42cMB0BD0UFxPFIXOz9MRuMU"></div> 
                                    <div id="error" style="color: red"></div>
                                    <!--end-recaptcha-->

                                    <input class="btn btn-block py-2 btn-primary" type="submit" name="action" value="Login" >
                                    <span class="text-center my-3 d-block">or</span>

                                    <!--Login by email-->
                                    <a href="#" class="btn btn-block py-2 btn-google"><span class="icon-google mr-3"></span>Login with Google</a>

                                    <!--Go to Home-->
                                    <a href="MainController?action=Load" class="btn btn-block py-2 btn-light" 
                                       style="background-color: #82ae46; color: #fff">Go to Home</a>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>      

        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
        <script>
            window.onload = function () {
                const recap = document.getElementById("check");
                const error = document.getElementById("error");
                recap.addEventListener("submit", function (event) {

                    const response = grecaptcha.getResponse();
                    if (response) {
                        recap.submit();
                    } else {
                        event.preventDefault();
                        error.innerHTML = "Please check recaptcha!";
                    }
                });
            }
        </script>
    </body>
</html>
