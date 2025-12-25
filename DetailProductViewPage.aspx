<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageMain.master" AutoEventWireup="true" CodeFile="DetailProductViewPage.aspx.cs" Inherits="DetailProductViewPage" %>

<%-- Head --%>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailProductViewPageHead" runat="Server">
    <title><%= getNameProductByID(Request.QueryString["productID"]) %></title>

    <!-- Css style -->
    <link href="assets/css/detailProduct.css" rel="stylesheet" />
</asp:Content>

<%-- Body --%>
<asp:Content ID="Content2" ContentPlaceHolderID="DetailProductViewPageContent" runat="Server">

    <!-- Main content -->
    <div class="main-content" style="margin: 0;">
        <div class="container">
            <!-- Breadcrumb area -->
            <div class="row">
                <div class="col-12">
                    <div class="breadcrumb-area">
                        <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='%236c757d'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="HomeViewPage.aspx">Trang chủ</a></li>
                                <li class="breadcrumb-item active" aria-current="page" style="text-transform: capitalize;"><%= getNameProductByID(Request.QueryString["productID"]) %></li>
                            </ol>
                        </nav>

                    </div>

                </div>
            </div>

            <!-- Detail product area -->
            <div class="row">
                <!-- Detail product-->
                <div class="col-9">
                    <!-- Product view area -->
                    <div class="row">
                        <!-- Product view img -->
                        <div class="col-5">
                            <div class="product-view-area">
                                <div class="product-view-slide nivoSlider">
                                    <asp:Repeater ID="RenderImageBlock" runat="server">
                                        <ItemTemplate>
                                            <img src="<%# getImage((byte[]) Eval("Images")) %>" data-thumb="<%# getImage((byte[]) Eval("Images")) %>" alt="img-product">
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>

                                <div class="view-large-btn">
                                    View large
                            <i class="bi view-large-icon bi-zoom-in"></i>
                                </div>
                            </div>
                        </div>

                        <!-- Product desc area -->
                        <div class="col-7">

                            <asp:UpdatePanel ID="UpdatePanelCart" runat="server">
                                <ContentTemplate>
                                    <asp:Repeater ID="RenderDetailBlock" runat="server" OnItemCommand="RenderDetailBlock_ItemCommand">
                                        <ItemTemplate>
                                            <div class="product-wrapper">
                                                <div class="product-description">
                                                    <h3 class="product-title-name"><%# Eval("ProductName") %></h3>
                                                </div>
                                                <div class="review-box">
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                    <i class="bi bi-star-fill"></i>
                                                </div>
                                                <div class="product-condition">
                                                    <p>
                                                        Sản phẩm có sẵn:
                <span class="product-condition-quantity"><%#Eval("ProductQuantity") %></span>
                                                    </p>
                                                    <p>
                                                        Tình trạng:
                 <span class="product-condition-text">New</span>
                                                    </p>
                                                </div>
                                                <div class="product-price-area">
                                                    <p class="product-price-new">
                                                        <%# String.Format("{0:N0}",Eval("ProductPromotionPrice")).Replace(",", ".") %><sup>đ</sup>
                                                    </p>
                                                    <p class="product-price-old">
                                                        <%# String.Format("{0:N0}",Eval("ProductPrice")).Replace(",", ".") %><sup>đ</sup>
                                                    </p>
                                                </div>
                                                <div class="product-desc-text">
                                                    <p><%# Server.HtmlDecode(Eval("ProductDesc").ToString()) %></p>
                                                </div>

                                                <div class="product-select-quantity">
                                                    <span>Số lượng</span>
                                                    <asp:TextBox ID="txtQuantity" runat="server" TextMode="Number" Text="1" min="1" max='<%# Eval("ProductQuantity") %>' CssClass="form-control" Style="width: 80px; display: inline-block;"></asp:TextBox>
                                                </div>

                                                <div class="product-controls">
                                                    <button class="buy-product-btn btn btn-dark">Mua ngay</button>

                                                    <asp:LinkButton ID="btnAddToCart" runat="server"
                                                        CssClass="add-product-cart-btn btn btn-outline-dark"
                                                        CommandName="AddToCart"
                                                        CommandArgument='<%# Eval("ProductID") %>'>
                    Thêm vào giỏ hàng
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>

                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </div>

                    </div>

                    <!-- Detail info product area -->
                    <div class="row" style="margin-top: 36px; margin-bottom: 48px">
                        <div class="col-12">
                            <div class="detail-info-product-area">
                                <div class="detail-title-area">
                                    <h3 class="detail-title-text">Chi tiết sản phẩm</h3>
                                </div>
                                <asp:Repeater ID="RenderContentBlock" runat="server">
                                    <ItemTemplate>
                                        <div class="detail-content-product"><%# Server.HtmlDecode(Eval("ProductDetail").ToString()) %> </div>
                                    </ItemTemplate>
                                </asp:Repeater>

                            </div>

                        </div>

                    </div>

                    <!-- Product same area-->
                    <div class="row" style="margin-bottom: 48px;">
                        <div class="col-12">
                            <div class="product-list-area">
                                <div class="left-title-area">
                                    <h3 class="left-title">Sản phẩm cùng danh mục</h3>
                                </div>

                                <div class="row">
                                    <!-- Product Item -->
                                    <div class="col-3">
                                        <div class="product-item">

                                            <div class="product-img">
                                                <a href="" class="product-link">
                                                    <img src="assets/img/product_img/iphone16/iphone-16-128gb-black.png" alt="">
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

                                            <div class="product-img">
                                                <a href="" class="product-link">
                                                    <img src="assets/img/product_img/iphone16/iphone-16-128gb-black.png" alt="">
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

                                            <div class="product-img">
                                                <a href="" class="product-link">
                                                    <img src="assets/img/product_img/iphone16/iphone-16-128gb-black.png" alt="">
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

                                            <div class="product-img">
                                                <a href="" class="product-link">
                                                    <img src="assets/img/product_img/iphone16/iphone-16-128gb-black.png" alt="">
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

                <!-- Product sidebar right -->
                <div class="col-3">
                    <!-- Product new sidebar right -->
                    <div class="product-right-sidebar-wrap">
                        <!-- Sidebar title -->
                        <div class="single-right-sidebar">
                            <div class="left-title-area">
                                <h3 class="left-title">Sản phẩm vừa nhập về</h3>
                            </div>
                        </div>

                        <!-- List products new  -->
                        <div class="list-product-sidebar-right">
                            <div class="single-product-item">
                                <div class="sidebar-product-img">
                                    <a href="#" class="sidebar-product-link">
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
                                        <span class="new-price">3.590.000<sup>đ</sup> </span>
                                        <span class="old-price">3.900.000<sup>đ</sup> </span>
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
                                        <span class="new-price">3.590.000<sup>đ</sup> </span>
                                        <span class="old-price">3.900.000<sup>đ</sup> </span>
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
                                        <span class="new-price">3.590.000<sup>đ</sup> </span>
                                        <span class="old-price">3.900.000<sup>đ</sup> </span>
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
                                        <span class="new-price">3.590.000<sup>đ</sup> </span>
                                        <span class="old-price">3.900.000<sup>đ</sup> </span>
                                    </div>
                                </div>

                            </div>

                        </div>

                    </div>

                    <!-- Product same area -->
                    <div class="product-right-sidebar-wrap">
                        <!-- Sidebar title -->
                        <div class="single-right-sidebar">
                            <div class="left-title-area">
                                <h3 class="left-title">Sản phẩm tương tự</h3>
                            </div>
                        </div>

                        <!-- List products new  -->
                        <div class="list-product-sidebar-right">
                            <div class="single-product-item">
                                <div class="sidebar-product-img">
                                    <a href="#" class="sidebar-product-link">
                                        <img src="assets/img/product_img/iphone16/iphone-16-plus-256gb-green.png" alt="">
                                    </a>
                                </div>

                                <div class="sidebar-product-desc">
                                    <a href="" class="sidebar-product-name">iphone 16 plus 256gb green</a>
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
                                        <span class="new-price">32.350.000<sup>đ</sup> </span>
                                        <span class="old-price">33.200.000<sup>đ</sup> </span>
                                    </div>

                                </div>

                            </div>

                            <div class="single-product-item">
                                <div class="sidebar-product-img">
                                    <a href="#" class="sidebar-product-link">
                                        <img src="assets/img/product_img/iphone16/iphone-16-plus-256gb-green.png" alt="">
                                    </a>
                                </div>

                                <div class="sidebar-product-desc">
                                    <a href="" class="sidebar-product-name">iphone 16 plus 256gb green</a>
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
                                        <span class="new-price">32.350.000<sup>đ</sup> </span>
                                        <span class="old-price">33.200.000<sup>đ</sup> </span>
                                    </div>

                                </div>

                            </div>

                            <div class="single-product-item">
                                <div class="sidebar-product-img">
                                    <a href="#" class="sidebar-product-link">
                                        <img src="assets/img/product_img/iphone16/iphone-16-plus-256gb-green.png" alt="">
                                    </a>
                                </div>

                                <div class="sidebar-product-desc">
                                    <a href="" class="sidebar-product-name">iphone 16 plus 256gb green</a>
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
                                        <span class="new-price">32.350.000<sup>đ</sup> </span>
                                        <span class="old-price">33.200.000<sup>đ</sup> </span>
                                    </div>

                                </div>

                            </div>

                            <div class="single-product-item">
                                <div class="sidebar-product-img">
                                    <a href="#" class="sidebar-product-link">
                                        <img src="assets/img/product_img/iphone16/iphone-16-plus-256gb-green.png" alt="">
                                    </a>
                                </div>

                                <div class="sidebar-product-desc">
                                    <a href="" class="sidebar-product-name">iphone 16 plus 256gb green</a>
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
                                        <span class="new-price">32.350.000<sup>đ</sup> </span>
                                        <span class="old-price">33.200.000<sup>đ</sup> </span>
                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>

                    <!-- Product best seller  -->
                    <div class="product-right-sidebar-wrap">
                        <!-- Sidebar title -->
                        <div class="single-right-sidebar">
                            <div class="left-title-area">
                                <h3 class="left-title">Sản phẩm bán chạy</h3>
                            </div>
                        </div>

                        <!-- List products best seller  -->
                        <div class="list-product-sidebar-right">
                            <div class="single-product-item">
                                <div class="sidebar-product-img">
                                    <a href="#" class="sidebar-product-link">
                                        <img src="assets/img/product_img/iphone16/iphone-16-plus-256gb-green.png" alt="">
                                    </a>
                                </div>

                                <div class="sidebar-product-desc">
                                    <a href="" class="sidebar-product-name">iphone 16 plus 256gb green</a>
                                    <div class="customer-comment-box">
                                        <div class="rating-box" style="display: none;">
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                        </div>
                                    </div>

                                    <div class="price-box">
                                        <span class="new-price">32.350.000<sup>đ</sup> </span>
                                        <span class="old-price">33.200.000<sup>đ</sup> </span>
                                        </span>

                          <div class="sold-quantity">
                              Đã bán: <span class="sold-number">12</span>
                          </div>

                                    </div>

                                </div>

                            </div>

                            <div class="single-product-item">
                                <div class="sidebar-product-img">
                                    <a href="#" class="sidebar-product-link">
                                        <img src="assets/img/product_img/iphone16/iphone-16-plus-256gb-green.png" alt="">
                                    </a>
                                </div>

                                <div class="sidebar-product-desc">
                                    <a href="" class="sidebar-product-name">iphone 16 plus 256gb green</a>
                                    <div class="customer-comment-box">
                                        <div class="rating-box" style="display: none;">
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                        </div>
                                    </div>

                                    <div class="price-box">
                                        <span class="new-price">32.350.000<sup>đ</sup> </span>
                                        <span class="old-price">33.200.000<sup>đ</sup> </span>
                                        </span>

                          <div class="sold-quantity">
                              Đã bán: <span class="sold-number">12</span>
                          </div>

                                    </div>

                                </div>

                            </div>

                            <div class="single-product-item">
                                <div class="sidebar-product-img">
                                    <a href="#" class="sidebar-product-link">
                                        <img src="assets/img/product_img/iphone16/iphone-16-plus-256gb-green.png" alt="">
                                    </a>
                                </div>

                                <div class="sidebar-product-desc">
                                    <a href="" class="sidebar-product-name">iphone 16 plus 256gb green</a>
                                    <div class="customer-comment-box">
                                        <div class="rating-box" style="display: none;">
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                        </div>
                                    </div>

                                    <div class="price-box">
                                        <span class="new-price">32.350.000<sup>đ</sup> </span>
                                        <span class="old-price">33.200.000<sup>đ</sup> </span>
                                        </span>

                          <div class="sold-quantity">
                              Đã bán: <span class="sold-number">12</span>
                          </div>

                                    </div>

                                </div>

                            </div>

                            <div class="single-product-item">
                                <div class="sidebar-product-img">
                                    <a href="#" class="sidebar-product-link">
                                        <img src="assets/img/product_img/iphone16/iphone-16-plus-256gb-green.png" alt="">
                                    </a>
                                </div>

                                <div class="sidebar-product-desc">
                                    <a href="" class="sidebar-product-name">iphone 16 plus 256gb green</a>
                                    <div class="customer-comment-box">
                                        <div class="rating-box" style="display: none;">
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                        </div>
                                    </div>

                                    <div class="price-box">
                                        <span class="new-price">32.350.000<sup>đ</sup> </span>
                                        <span class="old-price">33.200.000<sup>đ</sup> </span>
                                        </span>

                          <div class="sold-quantity">
                              Đã bán: <span class="sold-number">12</span>
                          </div>

                                    </div>

                                </div>

                            </div>

                            <div class="single-product-item">
                                <div class="sidebar-product-img">
                                    <a href="#" class="sidebar-product-link">
                                        <img src="assets/img/product_img/iphone16/iphone-16-plus-256gb-green.png" alt="">
                                    </a>
                                </div>

                                <div class="sidebar-product-desc">
                                    <a href="" class="sidebar-product-name">iphone 16 plus 256gb green</a>
                                    <div class="customer-comment-box">
                                        <div class="rating-box" style="display: none;">
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                            <i class="bi bi-star-fill"></i>
                                        </div>
                                    </div>

                                    <div class="price-box">
                                        <span class="new-price">32.350.000<sup>đ</sup> </span>
                                        <span class="old-price">33.200.000<sup>đ</sup> </span>
                                        </span>

                          <div class="sold-quantity">
                              Đã bán: <span class="sold-number">12</span>
                          </div>

                                    </div>

                                </div>

                            </div>


                        </div>

                    </div>

                    <div class="product-right-sidebar-wrap">
                        <!-- Sidebar title -->
                        <div class="single-right-sidebar">
                            <div class="left-title-area">
                                <h3 class="left-title">Tìm kiếm nhiều nhất</h3>
                            </div>
                        </div>

                        <!-- List products search most  -->
                        <div class="row">
                            <div class="col-6">
                                <ul class="list-product-most-search">
                                    <li>
                                        <a href="" class="link-product-most-search">m3 max</a>
                                    </li>

                                    <li>
                                        <a href="" class="link-product-most-search">iphone 16 pro</a>
                                    </li>

                                    <li>
                                        <a href="" class="link-product-most-search">test</a>
                                    </li>

                                    <li>
                                        <a href="" class="link-product-most-search">watch</a>
                                    </li>

                                    <li>
                                        <a href="" class="link-product-most-search">airpods 2 pro</a>
                                    </li>

                                </ul>
                            </div>

                            <div class="col-6">
                                <ul class="list-product-most-search">
                                    <li>
                                        <a href="" class="link-product-most-search">airpods 2</a>
                                    </li>

                                    <li>
                                        <a href="" class="link-product-most-search">airpods 3</a>
                                    </li>

                                    <li>
                                        <a href="" class="link-product-most-search">laptop</a>
                                    </li>

                                    <li>
                                        <a href="" class="link-product-most-search">airpods2</a>
                                    </li>

                                    <li>
                                        <a href="" class="link-product-most-search">macbook pro 16</a>
                                    </li>

                                </ul>
                            </div>
                        </div>

                    </div>

                </div>
            </div>

        </div>
    </div>

    <!-- Modal view large product -->
    <div class="modal-view-large">
        <div class="modal-overlay"></div>
        <div class="modal-view-area">
            <div class="modal-view-carousel owl-carousel owl-theme">

                <asp:Repeater ID="RenderImageModelBlock" runat="server">
                    <ItemTemplate>
                        <div class="modal-view-item">
                            <img src="<%#getImage((byte[]) Eval("Images")) %>" alt="">
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

            </div>

            <div class="modal-nav-carousel"></div>

            <div class="modal-close" title="Close">
                <i class="bi modal-close-icon bi-x-lg"></i>
            </div>

        </div>

    </div>


</asp:Content>

<%-- Script --%>
<asp:Content ID="Content3" ContentPlaceHolderID="DetailProductViewScript" runat="Server">
    <!-- Script here-->
    <script src="assets/js/detailProduct.js"></script>
</asp:Content>



