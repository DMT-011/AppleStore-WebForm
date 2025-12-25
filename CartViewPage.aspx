<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageMain.master" AutoEventWireup="true" CodeFile="CartViewPage.aspx.cs" Inherits="CartViewPage" %>

<%-- Head --%>
<asp:Content ID="Content1" ContentPlaceHolderID="HomeViewPageHead" runat="Server">
    <title>Giỏ hàng</title>

    <%-- Css style --%>
    <link href="assets/css/cartProduct.css" rel="stylesheet" />
</asp:Content>

<%-- Body --%>
<asp:Content ID="Content2" ContentPlaceHolderID="CartViewPageContent" runat="Server">

    <asp:Panel ID="pnlCart" runat="server">
        <div class="main-content" style="margin: 0;">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="breadcrumb-area">
                            <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='%236c757d'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="HomeViewPage.aspx">Trang chủ</a></li>
                                    <li class="breadcrumb-item active" aria-current="page" style="text-transform: capitalize;">giỏ hàng</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12">
                        <asp:UpdatePanel ID="upCartPage" runat="server">
                            <ContentTemplate>
                                <div class="table-responsive">
                                    <table class="table list-product-cart-area align-middle">
                                        <thead class="table-dark">
                                            <tr>
                                                <th scope="col">STT</th>
                                                <th scope="col">Hình ảnh</th>
                                                <th scope="col">Tên sản phẩm</th>
                                                <th scope="col">Đơn giá</th>
                                                <th scope="col">Số lượng</th>
                                                <th scope="col">Thành tiền</th>
                                                <th scope="col">Xóa</th>
                                            </tr>
                                        </thead>
                                        <tbody class="table-group-divider">
                                            <asp:Repeater ID="rptCartItems" runat="server" OnItemCommand="rptCartItems_ItemCommand">
                                                <ItemTemplate>
                                                    <tr>
                                                        <th scope="row" style="width: 70px;">
                                                            <div class="id-product-text"><%# Container.ItemIndex + 1 %></div>
                                                        </th>
                                                        <td>
                                                            <a href='<%# "DetailProductViewPage.aspx?productID=" + Eval("ProductID") %>' class="product-link-img-cart">
                                                                <img src="<%# GetImageSrc(Eval("Product.Images")) %>" alt="img-product" style="width: 80px; height: auto;">
                                                            </a>
                                                        </td>
                                                        <td>
                                                            <p class="product-name-cart">
                                                                <a href='<%# "DetailProductViewPage.aspx?productID=" + Eval("ProductID") %>'>
                                                                    <%# Eval("Product.ProductName") %>
                                                                </a>
                                                            </p>
                                                        </td>
                                                        <td>
                                                            <p class="product-price-cart">
                                                                <%# String.Format("{0:N0}", Eval("Price")).Replace(",", ".") %><sup>đ</sup>
                                                            </p>
                                                        </td>
                                                        <td>
                                                            <div class="product-quantity-cart">
                                                                <asp:TextBox ID="txtQuantity" runat="server" TextMode="Number"
                                                                    Text='<%# Eval("Quantity") %>' min="1" CssClass="form-control text-center"
                                                                    Style="width: 70px;"></asp:TextBox>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="total-price-cart">
                                                                <span class="price">
                                                                    <%# String.Format("{0:N0}", Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity"))).Replace(",", ".") %><sup>đ</sup>
                                                                </span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <span class="cart-delete-product">
                                                                <asp:LinkButton ID="btnDelete" runat="server"
                                                                    CommandName="Delete"
                                                                    CommandArgument='<%# Eval("CartItemID") %>'
                                                                    OnClientClick="return confirm('Bạn có chắc muốn xóa sản phẩm này không?');">
                                                                    <i class="bi bi-trash3-fill text-danger"></i>
                                                                </asp:LinkButton>
                                                            </span>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <tr runat="server" visible="<%# rptCartItems.Items.Count == 0 %>">
                                                        <td colspan="7" class="text-center py-4">Giỏ hàng đang trống. <a href="HomeViewPage.aspx">Mua sắm ngay</a></td>
                                                    </tr>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                        </tbody>
                                    </table>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>

                    <div class="col-12" style="display: block;">
                        <div class="return-continute-shop">
                            <div class="return-home-btn">
                                <a href="HomeViewPage.aspx">
                                    <i class="bi bi-arrow-left-circle-fill"></i>
                                    Tiếp tục mua hàng
                                </a>
                            </div>

                            <div class="order-controls">
                                <button class="remove-all-product-btn btn btn-danger">Xóa tất cả</button>
                                
                                <%-- Thay button HTML bằng asp:Button để chuyển sang Panel thanh toán --%>
                                <asp:Button ID="btnProceedToCheckout" runat="server" Text="Đặt hàng" 
                                    CssClass="order-product-btn btn btn-dark" 
                                    OnClick="btnProceedToCheckout_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlCheckout" runat="server" Visible="false">
        <div class="main-content" style="margin-top: 42px;">
            <div class="container">
                <div class="row gx-5">
                    <div class="col-6">
                        <h3 class="title-text-order">Thông tin giao hàng</h3>

                        <div class="infor-order-area">
                            <div class="order-item">
                                <span>Họ tên</span>
                                <span class="user-name-order">
                                    <asp:Label ID="lblUserName" runat="server"></asp:Label>
                                </span>
                            </div>

                            <div class="order-item">
                                <span>Số điện thoại</span>
                                <span class="user-phone-order">
                                    <asp:Label ID="lblUserPhone" runat="server"></asp:Label>
                                </span>
                            </div>

                            <div class="order-item">
                                <span>Địa chỉ</span>
                                <span class="user-address-order">
                                    <asp:Label ID="lblUserAddress" runat="server"></asp:Label>
                                </span>
                            </div>

                            <div class="order-item">
                                <span>Email</span>
                                <span style="text-transform: lowercase;" class="user-email-order">
                                    <asp:Label ID="lblUserEmail" runat="server"></asp:Label>
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="col-6">
                        <h3 class="title-text-order">Thông tin thanh toán</h3>

                        <div class="infor-order-area">
                            <div class="order-item order-item-price">
                                <span>Đơn hàng</span>
                                <span class="price-order">
                                    <asp:Label ID="lblSubTotal" runat="server"></asp:Label><sup>đ</sup>
                                </span>
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
                                <span class="total-price-order">
                                    <asp:Label ID="lblOrderTotal" runat="server"></asp:Label><sup>đ</sup>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="payment-area">
                            <h3>Lựa chọn phương thức thanh toán</h3>
                            <div class="option-payment-block">
                                <%-- Dùng asp:RadioButton thay cho input html để bắt sự kiện ở server --%>
                                <div class="payment-item">
                                    <asp:RadioButton ID="rbScan" runat="server" GroupName="PaymentGroup" />
                                    <label for="<%= rbScan.ClientID %>">Quét mã thanh toán</label>
                                </div>

                                <div class="payment-item">
                                    <asp:RadioButton ID="rbPaypal" runat="server" GroupName="PaymentGroup" />
                                    <label for="<%= rbPaypal.ClientID %>">PayPal</label>
                                </div>

                                <div class="payment-item">
                                    <asp:RadioButton ID="rbCOD" runat="server" GroupName="PaymentGroup" Checked="true" />
                                    <label for="<%= rbCOD.ClientID %>">Ship COD</label>
                                </div>
                            </div>

                            <%-- Thay button html bằng asp:LinkButton để xử lý Hoàn Tất --%>
                            <asp:LinkButton ID="btnConfirmOrder" runat="server" CssClass="payment-confirm-btn btn btn-dark" OnClick="btnConfirmOrder_Click">
                                Hoàn tất
                                <i class="bi bi-bag-check-fill"></i>
                            </asp:LinkButton>
                        </div>
                    </div>

                    <div class="col-12">
                        <div class="return-continute-shop" style="margin-bottom: 52px; margin-top: 22px;">
                            <div class="return-home-btn">
                                <%-- Nút Quay lại --%>
                                <asp:LinkButton ID="btnBackToCart" runat="server" OnClick="btnBackToCart_Click">
                                    <i class="bi bi-arrow-left-circle-fill"></i>
                                    Quay lại giỏ hàng
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>

</asp:Content>

