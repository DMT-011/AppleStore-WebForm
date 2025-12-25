<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageMain.master" AutoEventWireup="true" CodeFile="CartViewPage.aspx.cs" Inherits="CartViewPage" %>

<%-- Head --%>
<asp:Content ID="Content1" ContentPlaceHolderID="HomeViewPageHead" runat="Server">
    <title>Giỏ hàng</title>

    <%-- Css style --%>
    <link href="assets/css/cartProduct.css" rel="stylesheet" />
</asp:Content>

<%-- Body --%>
<asp:Content ID="Content2" ContentPlaceHolderID="CartViewPageContent" runat="Server">

    <!-- Main content -->
    <div class="main-content" style="margin: 0;">
        <div class="container">
            <!-- Breadcrumb area -->
            <div class="row">
                <div class="col-12">
                    <div class="breadcrumb-area">
                        <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='%236c757d'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="/home.html">Trang chủ</a></li>
                                <li class="breadcrumb-item active" aria-current="page" style="text-transform: capitalize;">giỏ hàng</li>
                            </ol>
                        </nav>
                    </div>

                </div>
            </div>

            <!-- Product list in cart  -->
            <div class="row">
                <div class="col-12">
                    <!-- Product list area -->
                    <div class="table-responsive">
                        <table class="table list-product-cart-area align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">Hình ảnh</th>
                                    <th scope="col">Tên sản phẩm</th>
                                    <th scope="col">Đơn giá</th>
                                    <th scope="col">Số lượng</th>
                                    <th scope="col">Thành tiền</th>
                                    <th scope="col">Xóa</th>
                                </tr>
                            </thead>

                            <tbody class="table-group-divider">
                                <!-- Item Product -->
                                <tr>
                                    <th scope="row" style="width: 96px;">
                                        <div class="id-product-text">1</div>
                                    </th>
                                    <td>
                                        <a href="" class="product-link-img-cart">
                                            <img src="assets/img/product_img/iphone16/iphone-16-128gb-black.png" alt="">
                                        </a>
                                    </td>

                                    <td>
                                        <p class="product-name-cart">
                                            <a href="">iphone 16 128GB black 
                                            </a>
                                        </p>
                                    </td>

                                    <td>
                                        <p class="product-price-cart">
                                            23.900.000<sup>đ</sup>
                                        </p>
                                    </td>
                                    <td>
                                        <div class="product-quantity-cart">
                                            <input type="number" name="quantity-product-select" value="1" min="1" id="">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="total-price-cart">
                                            <span class="price">23.900.000<sup>đ</sup>
                                            </span>
                                        </div>
                                    </td>

                                    <td>
                                        <span class="cart-delete-product">
                                            <a href="">
                                                <i class="bi bi-trash3-fill"></i>
                                            </a>
                                        </span>
                                    </td>
                                </tr>


                                <tr>
                                    <th scope="row">
                                        <div class="id-product-text">1</div>
                                    </th>
                                    <td>
                                        <a href="" class="product-link-img-cart">
                                            <img src="assets/img/product_img/iphone16/iphone-16-128gb-black.png" alt="">
                                        </a>
                                    </td>

                                    <td>
                                        <p class="product-name-cart">
                                            <a href="">iphone 16 128GB black
                                            </a>
                                        </p>
                                    </td>

                                    <td>
                                        <p class="product-price-cart">
                                            23.900.000<sup>đ</sup>
                                        </p>
                                    </td>
                                    <td>
                                        <div class="product-quantity-cart">
                                            <input type="number" name="quantity-product-select" value="1" min="1" id="">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="total-price-cart">
                                            <span class="price">23.900.000<sup>đ</sup>
                                            </span>
                                        </div>
                                    </td>

                                    <td>
                                        <span class="cart-delete-product">
                                            <a href="">
                                                <i class="bi bi-trash3-fill"></i>
                                            </a>
                                        </span>
                                    </td>
                                </tr>

                            </tbody>

                        </table>

                    </div>

                </div>

                <!-- Return shop area -->
                <div class="col-12" style="display: block;">
                    <div class="return-continute-shop">
                        <div class="return-home-btn">
                            <a href="">
                                <i class="bi bi-arrow-left-circle-fill"></i>
                                Tiếp tục mua hàng
                            </a>
                        </div>

                        <div class="order-controls">
                            <button class="remove-all-product-btn btn btn-danger">Xóa tất cả</button>
                            <button class="order-product-btn btn btn-dark">Đặt hàng</button>
                        </div>
                    </div>

                </div>

            </div>

        </div>
    </div>

    <!-- Infomation order && methods payment area -->
    <div class="main-content" style="margin-top: 42px; display: none;">
        <div class="container">
            <div class="row gx-5">
                <!-- Infomation order product area -->
                <div class="col-6">
                    <h3 class="title-text-order">Thông tin giao hàng</h3>

                    <div class="infor-order-area">
                        <div class="order-item">
                            <span>Họ tên</span>
                            <span class="user-name-order">Dương minh trí</span>
                        </div>

                        <div class="order-item">
                            <span>Số điện thoại</span>
                            <span class="user-phone-order">034503733</span>
                        </div>

                        <div class="order-item">
                            <span>Địa chỉ</span>
                            <span class="user-address-order">TP.Hồng ngự, P6, Đồng tháp</span>
                        </div>


                        <div class="order-item">
                            <span>Email</span>
                            <span style="text-transform: lowercase;" class="user-email-order">duongminhtri711@gmail.com</span>
                        </div>

                    </div>

                </div>

                <div class="col-6">
                    <h3 class="title-text-order">Thông tin thanh toán</h3>

                    <div class="infor-order-area">
                        <div class="order-item order-item-price">
                            <span>Đơn hàng</span>
                            <span class="price-order">23.900.000<sup>đ</sup></span>
                        </div>

                        <div class="order-item order-item-price">
                            <span>Phí vận chuyển</span>
                            <span class="shipping-fess">0<sup>đ</sup></span>
                        </div>

                        <div class="order-item order-item-price">
                            <span>Mã giảm giá</span>
                            <span class="user-address-order">0<sup>đ</sup></span>
                        </div>


                        <div class="order-item order-item-price total-price-item">
                            <span>Tổng cộng</span>
                            <span class="total-price-order">23.900.000<sup>đ</sup></span>
                        </div>

                    </div>

                </div>
                <!--End: Infomation order product area -->

                <!-- Option Payment area -->
                <div class="col-12">
                    <div class="payment-area">
                        <h3>Lựa chọn phương thức thanh toán</h3>
                        <div class="option-payment-block">
                            <div class="payment-item">
                                <input type="radio" name="payment-methods" id="scan-payment">
                                <label for="scan-payment">Quét mã thanh toán</label>
                            </div>

                            <div class="payment-item">
                                <input type="radio" name="payment-methods" id="paypal-payment">
                                <label for="paypal-payment">PayPal</label>
                            </div>

                            <div class="payment-item">
                                <input type="radio" name="payment-methods" id="ship-cod">
                                <label for="ship-cod">Ship COD</label>
                            </div>

                        </div>

                        <button class="payment-confirm-btn btn btn-dark">
                            Hoàn tất
                    <i class="bi bi-bag-check-fill"></i>
                        </button>
                    </div>

                </div>

                <div class="col-12">
                    <div class="return-continute-shop" style="margin-bottom: 52px; margin-top: 22px;">
                        <div class="return-home-btn">
                            <a href="home.html">
                                <i class="bi bi-arrow-left-circle-fill"></i>
                                Tiếp tục mua hàng
                            </a>
                        </div>
                    </div>

                </div>

            </div>

        </div>

    </div>

</asp:Content>


