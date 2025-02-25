<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.sql.*"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

    <html class="no-js" lang="zxx">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Virtual Classroom</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="manifest" href="site.webmanifest">
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">

        <!-- CSS here -->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="assets/css/slicknav.css">
        <link rel="stylesheet" href="assets/css/flaticon.css">
        <link rel="stylesheet" href="assets/css/progressbar_barfiller.css">
        <link rel="stylesheet" href="assets/css/gijgo.css">
        <link rel="stylesheet" href="assets/css/animate.min.css">
        <link rel="stylesheet" href="assets/css/animated-headline.css">
        <link rel="stylesheet" href="assets/css/magnific-popup.css">
        <link rel="stylesheet" href="assets/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="assets/css/themify-icons.css">
        <link rel="stylesheet" href="assets/css/slick.css">
        <link rel="stylesheet" href="assets/css/nice-select.css">
        <link rel="stylesheet" href="assets/css/style.css">
		 <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .grid-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr); /* 3 columns */
            grid-gap: 10px; /* Spacing between items */
        }
        .grid-item {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            text-align: center;
        }
        .grid-item img {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
        }
        .grid-item a {
            text-decoration: none;
            color: black;
        }
    </style>
    </head>

    <body>

        <%
		if(session.getAttribute("student") == null)									// check if admin is already student in to the system
		{
			response.sendRedirect("student_login.jsp");								// if not logged in, take student to login page
		}
%>

            <!-- ? Preloader Start -->
            <div id="preloader-active">
                <div class="preloader d-flex align-items-center justify-content-center">
                    <div class="preloader-inner position-relative">
                        <div class="preloader-circle"></div>
                        <div class="preloader-img pere-text">
                            <img src="assets/img/logo/loder.png" alt="">
                        </div>
                    </div>
                </div>
            </div>
            <!-- Preloader Start -->
            <header>
                <!-- Header Start -->
                <div class="header-area header-transparent">
                    <div class="main-header ">
                        <div class="header-bottom  header-sticky">
                            <div class="container-fluid">
                                <div class="row align-items-center">
                                    <!-- Logo -->
                                    <div class="col-xl-2 col-lg-2">
                                        <div class="logo">
                                            <a href="index.jsp"><img src="assets/img/logo/logo.png" alt=""></a>
                                        </div>
                                    </div>
                                    <div class="col-xl-10 col-lg-10">
                                        <div class="menu-wrapper d-flex align-items-center justify-content-end">
                                            <!-- Main-menu -->
                                            <div class="main-menu d-none d-lg-block">
                                                <nav>
                                                    <ul id="navigation">
                                                        <li class="active"><a href="student_dashboard.jsp">Home</a></li>
                                                        <li><a href="#">Classroom</a>
                                                            <ul class="submenu">
                                                                <li><a href="studentvideos.jsp">Video Lectures</a></li>
                                                                <li><a href="">Study Materials</a></li>
                                                            </ul>
                                                        </li>
                                                        <li><a href="">Q/A Forum</a></li>
                                                        <!-- Button -->
                                                        <li class="button-header"><a href="student_logout.jsp" class="btn btn3">Log Out</a></li>
                                                    </ul>
                                                </nav>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Mobile Menu -->
                                    <div class="col-12">
                                        <div class="mobile_menu d-block d-lg-none"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Header End -->
            </header>
            <main>
                <!--? slider Area Start-->
               <section class="slider-area ">
               <div class="slider-active">
                   <!-- Single Slider -->
                   <div class="single-slider slider-height d-flex align-items-center">
                       <div class="container">
                           <div class="row">
                               <div class="col-xl-6 col-lg-7 col-md-12">
                                   <div class="hero__caption">
                                      <div class="grid-container">
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            String dbURL = "jdbc:mysql://localhost:3306/project";
            String dbUser = "root";
            String dbPass = "tiger";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                stmt = conn.createStatement();
                String sql = "SELECT subject_name, youtube_link, image FROM video_resources";
                rs = stmt.executeQuery(sql);

                int count = 0;
                while (rs.next() && count < 18) { // Limit to 18 images for 3 rows
                    String subjectName = rs.getString("subject_name");
                    String youtubeLink = rs.getString("youtube_link");
                    Blob photoBlob = rs.getBlob("image");
                    byte[] photoBytes = photoBlob.getBytes(1, (int) photoBlob.length());

                    String base64Image = java.util.Base64.getEncoder().encodeToString(photoBytes);
        %>
                    <div class="grid-item">
                        <a href="<%= youtubeLink %>" target="_blank">
                   	<img src="data:image/jpeg;base64,<%= base64Image %>" alt="<%= subjectName %> Image" style="width:100;"/>
                   </a>
                       
                        <p><%= subjectName %></p>
                    </div>
        <%
                    count++;
                }
            } catch (Exception e) {
                out.println("<h3>Error: " + e.getMessage() + "</h3>");
                e.printStackTrace();
            } finally {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            }
        %>
    </div>
                                   </div>
                               </div>
                           </div>
                       </div>
                   </div>
               </div>
           </section>
            </main>
            <footer>
                <div class="footer-wrappper footer-bg">
                    <!-- Footer Start-->
                    <div class="footer-area footer-padding">
                        <div class="container">
                            <div class="row justify-content-between">
                                <div class="col-xl-4 col-lg-5 col-md-4 col-sm-6">
                                    <div class="single-footer-caption mb-50">
                                        <div class="single-footer-caption mb-30">
                                            <!-- logo -->
                                            <div class="footer-logo mb-25">
                                                <a href="index.jsp"><img src="assets/img/logo/logo2_footer.png" alt=""></a>
                                            </div>
                                            <div class="footer-tittle">
                                                <div class="footer-pera">
                                                    <p>The automated process starts here.</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- footer-bottom area -->
                                <div class="footer-bottom-area">
                                    <div class="container">
                                        <div class="footer-border">
                                            <div class="row d-flex align-items-center">
                                                <div class="col-xl-12 ">
                                                    <div class="footer-copy-right text-center">
                                                        <p>
                                                            Copyright &copy;
                                                            <script>
                                                                document.write(new Date().getFullYear());
                                                            </script> All rights reserved
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Footer End-->
                            </div>
            </footer>
            <!-- Scroll Up -->
            <div id="back-top">
                <a title="Go to Top" href="#"> <i class="fas fa-level-up-alt"></i></a>
            </div>

            <!-- JS here -->
            <script src="./assets/js/vendor/modernizr-3.5.0.min.js"></script>
            <!-- Jquery, Popper, Bootstrap -->
            <script src="./assets/js/vendor/jquery-1.12.4.min.js"></script>
            <script src="./assets/js/popper.min.js"></script>
            <script src="./assets/js/bootstrap.min.js"></script>
            <!-- Jquery Mobile Menu -->
            <script src="./assets/js/jquery.slicknav.min.js"></script>

            <!-- Jquery Slick , Owl-Carousel Plugins -->
            <script src="./assets/js/owl.carousel.min.js"></script>
            <script src="./assets/js/slick.min.js"></script>
            <!-- One Page, Animated-HeadLin -->
            <script src="./assets/js/wow.min.js"></script>
            <script src="./assets/js/animated.headline.js"></script>
            <script src="./assets/js/jquery.magnific-popup.js"></script>

            <!-- Date Picker -->
            <script src="./assets/js/gijgo.min.js"></script>
            <!-- Nice-select, sticky -->
            <script src="./assets/js/jquery.nice-select.min.js"></script>
            <script src="./assets/js/jquery.sticky.js"></script>
            <!-- Progress -->
            <script src="./assets/js/jquery.barfiller.js"></script>

            <!-- counter , waypoint,Hover Direction -->
            <script src="./assets/js/jquery.counterup.min.js"></script>
            <script src="./assets/js/waypoints.min.js"></script>
            <script src="./assets/js/jquery.countdown.min.js"></script>
            <script src="./assets/js/hover-direction-snake.min.js"></script>

            <!-- contact js -->
            <script src="./assets/js/contact.js"></script>
            <script src="./assets/js/jquery.form.js"></script>
            <script src="./assets/js/jquery.validate.min.js"></script>
            <script src="./assets/js/mail-script.js"></script>
            <script src="./assets/js/jquery.ajaxchimp.min.js"></script>

            <!-- Jquery Plugins, main Jquery -->
            <script src="./assets/js/plugins.js"></script>
            <script src="./assets/js/main.js"></script>

    </body>

    </html>
