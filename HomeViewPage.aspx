<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageMain.master" AutoEventWireup="true" CodeFile="HomeViewPage.aspx.cs" Inherits="HomeViewPage" %>

<%-- Head --%>
<asp:Content ID="Content1" ContentPlaceHolderID="HomeViewPageHead" runat="Server">
    <title>Apple Store</title>
</asp:Content>


<%-- Body --%>
<asp:Content ID="Content2" ContentPlaceHolderID="HomeViewPageContent" runat="Server">
    <!-- Page home -->

    <!-- Slider -->
    <div class="" id="slider">
        <div class="container">
            <div class="slider-wrapper">
                <div id="main-slider" class="nivoSlider">
                    <img src="assets/img/slides/banner-3.jpg" alt="">
                    <img src="assets/img/slides/banner-4.jpg" alt="">
                    <img src="assets/img/slides/banner-2.jpg" alt="">
                    <img src="assets/img/slides/banner-1.jpg" alt="">
                    <img src="assets/img/slides/banner-5.jpg" alt="">
                    <img src="assets/img/slides/banner-6.jpg" alt="">
                </div>

            </div>
        </div>
    </div>

    <!-- Main content -->
    <div class="main-content">
        <div class="container">
            <div class="row">
                <!-- Sidebar left -->
                <div class="col-3">
                    <!-- Sidebar title -->
                    <div class="single-left-sidebar">
                        <div class="left-title-area">
                            <h3 class="left-title">Sản phẩm khuyến mãi</h3>
                        </div>
                    </div>

                    <!-- List promotional products  -->
                    <div class="list-product-sales">
                        <div class="single-product-item">

                            <div class="sidebar-product-img">
                                <a href="detailProduct.html" class="sidebar-product-link">
                                    <img src="assets/img/product_img/sidebar/airpods-2-sac-lightning.png" alt="">
                                </a>
                            </div>

                            <div class="sidebar-product-desc">
                                <a href="" class="sidebar-product-name">AirPods 2 sạc Lightning</a>
                                <div class="customer-comment-box">
                                    <div class="rating-box">
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                    </div>
                                </div>

                                <div class="price-box">
                                    <span class="old-price">3.900.000<sup>đ</sup> </span>
                                    <span class="new-price">3.590.000<sup>đ</sup> </span>
                                </div>
                            </div>

                        </div>

                        <div class="single-product-item">

                            <div class="sidebar-product-img">
                                <a href="#" class="sidebar-product-link">
                                    <img src="assets/img/product_img/sidebar/airpods-pro-(2nd-gen)-usb-c.png" alt="">
                                </a>
                            </div>

                            <div class="sidebar-product-desc">
                                <a href="" class="sidebar-product-name">AirPods 2 sạc Lightning</a>
                                <div class="customer-comment-box">
                                    <div class="rating-box">
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                    </div>
                                </div>

                                <div class="price-box">
                                    <span class="old-price">3.900.000<sup>đ</sup> </span>
                                    <span class="new-price">3.590.000<sup>đ</sup> </span>
                                </div>
                            </div>

                        </div>

                        <div class="single-product-item">

                            <div class="sidebar-product-img">
                                <a href="#" class="sidebar-product-link">
                                    <img src="assets/img/product_img/sidebar/airpods-pro-(2nd-gen)-usb-c.png" alt="">
                                </a>
                            </div>

                            <div class="sidebar-product-desc">
                                <a href="" class="sidebar-product-name">AirPods 2 sạc Lightning</a>
                                <div class="customer-comment-box">
                                    <div class="rating-box">
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                        <i class="bi bi-star-fill"></i>
                                    </div>
                                </div>

                                <div class="price-box">
                                    <span class="old-price">3.900.000<sup>đ</sup> </span>
                                    <span class="new-price">3.590.000<sup>đ</sup> </span>
                                </div>
                            </div>

                        </div>

                    </div>

                </div>

                <!--List products new -->
                <div class="col-9" style="overflow: hidden;">
                    <!-- New product list -->
                    <div class="new-product-area">
                        <div class="left-title-area">
                            <h3 class="left-title">Sản phẩm mới</h3>

                            <div class="product-carousel-nav">
                                <div class="product-prev-btn">
                                    <i class="bi bi-arrow-left-square-fill product-next-icon"></i>
                                </div>

                                <div class="product-next-btn">
                                    <i class="bi bi-arrow-right-square-fill product-next-icon"></i>
                                </div>
                            </div>

                        </div>
                        <div class="row no-wrap product-carousel product-max-4">
                            <!-- Product item -->
                            <div class="col-3">
                                <div class="product-item">

                                    <div class="product-label">New</div>

                                    <div class="product-img">
                                        <a href="" class="product-link">
                                            <img src="assets/img/product_img/product_new/laptop-apple-macbook-air-13-inch-m3.jpg" alt="">
                                        </a>
                                    </div>

                                    <div class="product-info">
                                        <div class="rating-box">
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                        </div>

                                        <a href="" class="product-name">Apple macbook air </a>
                                        <div class="product-price">
                                            18.699.000<sup>đ</sup>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <div class="col-3">
                                <div class="product-item">

                                    <div class="product-label">New</div>

                                    <div class="product-img">
                                        <a href="" class="product-link">
                                            <img src="assets/img/product_img/product_new/laptop-apple-macbook-air-13-inch-m3.jpg" alt="">
                                        </a>
                                    </div>

                                    <div class="product-info">
                                        <div class="rating-box">
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                        </div>

                                        <a href="" class="product-name">Apple macbook air</a>
                                        <div class="product-price">
                                            18.699.000<sup>đ</sup>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <div class="col-3">
                                <div class="product-item">

                                    <div class="product-label">New</div>

                                    <div class="product-img">
                                        <a href="" class="product-link">
                                            <img src="assets/img/product_img/product_new/laptop-apple-macbook-air-13-inch-m3.jpg" alt="">
                                        </a>
                                    </div>

                                    <div class="product-info">
                                        <div class="rating-box">
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                        </div>

                                        <a href="" class="product-name">Apple macbook air</a>
                                        <div class="product-price">
                                            18.699.000<sup>đ</sup>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <div class="col-3">
                                <div class="product-item">

                                    <div class="product-label">New</div>

                                    <div class="product-img">
                                        <a href="" class="product-link">
                                            <img src="assets/img/product_img/product_new/laptop-apple-macbook-air-13-inch-m3.jpg" alt="">
                                        </a>
                                    </div>

                                    <div class="product-info">
                                        <div class="rating-box">
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                        </div>

                                        <a href="" class="product-name">Apple macbook air</a>
                                        <div class="product-price">
                                            18.699.000<sup>đ</sup>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <div class="col-3">
                                <div class="product-item">

                                    <div class="product-label">New</div>

                                    <div class="product-img">
                                        <a href="" class="product-link">
                                            <img src="assets/img/product_img/product_new/laptop-apple-macbook-air-13-inch-m3.jpg" alt="">
                                        </a>
                                    </div>

                                    <div class="product-info">
                                        <div class="rating-box">
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                        </div>

                                        <a href="" class="product-name">Apple macbook air</a>
                                        <div class="product-price">
                                            18.699.000<sup>đ</sup>
                                        </div>
                                    </div>

                                </div>
                            </div>

                        </div>

                    </div>
                </div>

            </div>

        </div>
    </div>
    <div class="main-content main-content-full-col">
        <asp:Repeater ID="RenderProductBlock" runat="server">
            <ItemTemplate>
                <!-- Product List -->
                <div class="container">
                    <div class="product-list-area">
                        <div class="left-title-area">
                            <h3 class="left-title"><%# getNameCategoryByID(Convert.ToInt32(Eval("CategoryID"))) %></h3>
                        </div>

                        <div class="row">
                            <!-- Product Item -->
                            <asp:Repeater ID="InnerRepeater" DataSource='<%# Eval("Products") %>' runat="server">
                                <ItemTemplate>
                                    <div class="col-2-4">
                                        <div class="product-item">

                                            <div class="product-label">New</div>

                                            <div class="product-img">
                                                <a href="DetailProductViewPage.aspx?productID=<%# Eval("ProductID") %>" class="product-link">
                                                    <img src="<%# GetImageData(Convert.ToInt32(Eval("ProductID"))) %>" alt="Product-Img">
                                                </a>
                                            </div>

                                            <div class="product-info">
                                                <div class="rating-box">
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                </div>

                                                <a href="DetailProductViewPage.aspx?productID=<%# Eval("ProductID") %>" class="product-name"><%# Eval("ProductName") %></a>
                                                <div class="product-price">
                                                    <%# String.Format("{0:N0}",Eval("ProductPromotionPrice")).Replace(",", ".") %><sup>đ</sup>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                        </div>

                    </div>
                </div>

            </ItemTemplate>
        </asp:Repeater>
    </div>

    <!-- End Page home -->
</asp:Content>

