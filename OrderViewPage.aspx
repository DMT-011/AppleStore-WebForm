<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageMain.master" AutoEventWireup="true" CodeFile="OrderViewPage.aspx.cs" Inherits="OrderViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="OrderViewPageHead" runat="Server">

    <title>Apple Store - Đơn hàng của tui</title>

    <style>
        /* 1. Bảng to rõ */
        .table-order-history thead th {
            font-size: 15px; /* To bằng header giỏ hàng */
            font-weight: 600;
            text-align: center;
            padding: 12px 0;
            background-color: #212529;
            color: white;
            border: none;
        }

        .table-order-history tbody td {
            font-size: 14px; /* To bằng nội dung giỏ hàng */
            text-align: center;
            vertical-align: middle;
            padding: 18px 0;
            border-bottom: 1px solid #ccc;
        }

        /* 2. Giá tiền màu đỏ to */
        .price-text {
            font-size: 1.55rem;
            color: red;
            font-weight: 500;
        }

        /* 3. Trạng thái đơn hàng (To hơn cũ) */
        .order-status {
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px; /* Tăng từ 0.9rem lên 1.3rem */
            font-weight: 500;
            display: inline-block;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-shipping {
            background-color: #cff4fc;
            color: #055160;
        }

        .status-completed {
            background-color: #c3e6cb;
            color: #155724;
        }

        .status-cancelled {
            background-color: #f8d7da;
            color: #842029;
        }

        /* 4. Nút Xem chi tiết */
        .btn-view-detail {
            font-size: 13px;
            padding: 6px 18px;
            font-weight: 500;
        }

        /* --- CSS CHO MODAL (Cũng phải to lên) --- */
        .modal-title {
            font-size: 18px;
            font-weight: 600;
        }

        .modal-body p {
            font-size: 15px;
            margin-bottom: 8px;
        }

        .modal-table th {
            font-size: 14px;
            text-align: center;
            background: #f8f9fa;
        }

        .modal-table td {
            font-size: 13.5px;
            vertical-align: middle;
        }

        .modal-total-text {
            font-size: 18px;
            color: red;
            font-weight: 600;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="OrderViewPageContent" runat="Server">
    <div class="main-content" style="margin-top: 0px; margin-bottom: 80px;">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="breadcrumb-area">
                        <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='%236c757d'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="HomeViewPage.aspx">Trang chủ</a></li>
                                <li class="breadcrumb-item active" aria-current="page" style="text-transform: capitalize;">Đơn hàng của tôi</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-12">
                    <h3 class="text-uppercase border-bottom pb-3" style="font-size: 2rem; font-weight: 600;">Lịch sử đơn hàng</h3>
                </div>
            </div>

            <div class="row">
                <div class="col-12">

                    <asp:UpdatePanel ID="upOrderHistory" runat="server">
                        <ContentTemplate>

                            <div class="table-responsive">
                                <table class="table table-hover align-middle table-order-history">
                                    <thead>
                                        <tr>
                                            <th>Mã đơn</th>
                                            <th>Ngày đặt</th>
                                            <th>Tổng tiền</th>
                                            <th>Trạng thái</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptOrders" runat="server" OnItemCommand="rptOrders_ItemCommand">
                                            <ItemTemplate>
                                                <tr>
                                                    <td style="font-weight: 600;">#<%# Eval("OrderID") %></td>
                                                    <td><%# Eval("CreatedAt", "{0:dd/MM/yyyy HH:mm}") %></td>
                                                    <td>
                                                        <span class="price-text">
                                                            <%# String.Format("{0:N0}", Eval("TotalAmount")).Replace(",", ".") %><sup>đ</sup>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <span class='order-status <%# GetStatusClass(Eval("OrderStatus")) %>'>
                                                            <%# GetStatusText(Eval("OrderStatus")) %>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="btnViewDetail" runat="server"
                                                            CommandName="ViewDetail"
                                                            CommandArgument='<%# Eval("OrderID") %>'
                                                            CssClass="btn btn-outline-dark btn-view-detail">
                                                            <i class="bi bi-eye-fill"></i> Xem
                                                        </asp:LinkButton>

                                                        <asp:LinkButton ID="btnCancelOrder" runat="server"
                                                            CommandName="CancelOrder"
                                                            CommandArgument='<%# Eval("OrderID") %>'
                                                            Visible='<%# IsOrderCancelable(Eval("OrderStatus")) %>'
                                                            OnClientClick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này không?');"
                                                            CssClass="btn btn-danger btn-view-detail">
                                                        <i class="bi bi-x-circle-fill"></i> Hủy
                                                        </asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <tr runat="server" visible="<%# rptOrders.Items.Count == 0 %>">
                                                    <td colspan="5" class="text-center py-5">
                                                        <div style="font-size: 1.5rem; color: #6c757d;">Bạn chưa có đơn hàng nào.</div>
                                                        <a href="HomeViewPage.aspx" class="btn btn-dark mt-3" style="font-size: 1.4rem; padding: 10px 30px;">Mua sắm ngay</a>
                                                    </td>
                                                </tr>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>

                            <div class="modal fade" id="orderDetailModal" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog modal-lg modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Chi tiết đơn hàng #<asp:Label ID="lblModalOrderID" runat="server"></asp:Label></h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="mb-4 p-3 bg-light rounded border">
                                                <h6 class="text-uppercase mb-3" style="font-size: 1.5rem; font-weight: 700;">Thông tin nhận hàng</h6>
                                                <p>
                                                    <strong>Người nhận:</strong>
                                                    <asp:Label ID="lblModalShipName" runat="server"></asp:Label>
                                                </p>
                                                <p>
                                                    <strong>SĐT:</strong>
                                                    <asp:Label ID="lblModalPhone" runat="server"></asp:Label>
                                                </p>
                                                <p class="mb-0">
                                                    <strong>Địa chỉ:</strong>
                                                    <asp:Label ID="lblModalAddress" runat="server"></asp:Label>
                                                </p>
                                            </div>

                                            <div class="table-responsive">
                                                <table class="table table-bordered modal-table">
                                                    <thead>
                                                        <tr>
                                                            <th>Sản phẩm</th>
                                                            <th>Hình ảnh</th>
                                                            <th>SL</th>
                                                            <th>Đơn giá</th>
                                                            <th>Thành tiền</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <asp:Repeater ID="rptOrderDetails" runat="server">
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td class="text-start ps-3"><%# Eval("Product.ProductName") %></td>
                                                                    <td class="text-center">
                                                                        <img src="<%# GetImageSrc(Eval("Product.Images")) %>" style="width: 60px; height: 60px; object-fit: contain;" />
                                                                    </td>
                                                                    <td class="text-center"><%# Eval("Quantity") %></td>
                                                                    <td class="text-center"><%# String.Format("{0:N0}", Eval("Price")).Replace(",", ".") %></td>
                                                                    <td class="text-center fw-bold"><%# String.Format("{0:N0}", Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity"))).Replace(",", ".") %></td>
                                                                </tr>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    </tbody>
                                                </table>
                                            </div>

                                            <div class="text-end mt-4">
                                                <span style="font-size: 1.6rem; font-weight: 600;">Tổng cộng: </span>
                                                <asp:Label ID="lblModalTotal" runat="server" CssClass="modal-total-text"></asp:Label>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="font-size: 1.3rem;">Đóng</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function showOrderDetailModal() {
            var myModal = new bootstrap.Modal(document.getElementById('orderDetailModal'));
            myModal.show();
        }
    </script>

</asp:Content>
