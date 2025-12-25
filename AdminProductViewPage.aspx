<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.master" AutoEventWireup="true" CodeFile="AdminProductViewPage.aspx.cs" Inherits="AdminProductViewPage" %>

<%-- Head --%>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminProductPageHead" runat="Server">
    <%-- Css style --%>
    <link href="assets/css/adminProduct.css" rel="stylesheet" />
    <title>Admin - Danh sách sản phẩm</title>
</asp:Content>


<%-- Body --%>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminProductPageContent" runat="Server">
    <div class="page-inner page-inner-custom">
        <!-- Breadcrumbs -->
        <div class="page-header">
            <h3 class="fw-bold mb-3">Sản phẩm</h3>
            <ul class="breadcrumbs mb-3">
                <li class="nav-home">
                    <a href="#">
                        <i class="icon-home"></i>
                    </a>
                </li>
                <li class="separator">
                    <i class="icon-arrow-right"></i>
                </li>
                <li class="nav-item">
                    <a href="#">Sản phẩm</a>
                </li>
                <li class="separator">
                    <i class="icon-arrow-right"></i>
                </li>
                <li class="nav-item">
                    <a href="#">Danh sách sản phẩm</a>
                </li>
            </ul>
        </div>

        <div class="control-product">
            <a href="AdminAddProductViewPage.aspx" class="btn btn-black">
                <i class="icon-control fas fa-plus-circle"></i>
                Thêm mới
            </a>
            <a href="AdminDeleteProductViewPage.aspx" class="btn btn-danger">
                <i class="icon-control fas fa-trash"></i>
                Thùng rác <%= countItemDeleted() %>
            </a>
        </div>

    </div>

    <div class="product-list-wrapper">
        <div class="row">
            <div class="col-12">
                <div class="table-responsive">
                    <table class="table align-middle table-product-list">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Hình ảnh</th>
                                <th scope="col">Tên sản phẩm</th>
                                <th scope="col">Số lượng</th>
                                <th scope="col">Thao tác</th>
                            </tr>
                        </thead>

                        <tbody class="table-group-divider">
                            <asp:Repeater ID="RenderProductBlock" runat="server">

                                <ItemTemplate>
                                    <tr class="product-item">
                                        <th scope="row">
                                            <i
                                                class="fas fa-angle-right icon-product-right"
                                                style="opacity: 0.9"></i>
                                            <i
                                                class="fas fa-angle-down icon-product-down hidden-icon-product"
                                                style="opacity: 0.9"></i>
                                            <span class="id-product" style="margin-left: 2px"><%# Eval("ProductID") %></span>
                                        </th>
                                        <td>
                                            <img
                                                src="<%# getImageMainByID(Convert.ToInt32(Eval("ProductID"))) %>"
                                                class="product-img"
                                                alt="" />
                                        </td>
                                        <td>
                                            <a href="#" class="product-detail-link"><%# Eval("ProductName") %></a>
                                        </td>
                                        <td><%# Eval("ProductQuantity") %></td>
                                        <td class="product-controls">
                                            <a href="AdminUpdateProductViewPage.aspx?productID=<%# Eval("ProductID") %>"
                                                class="btn btn-black"
                                                data-bs-toggle="tooltip"
                                                data-bs-placement="top"
                                                data-bs-title="Chỉnh sửa">
                                                <i class="far fa-edit"></i>
                                            </a>

                                            <button
                                                class="btn btn-danger btn-delete"
                                                href="#"
                                                data-id-product="<%# Eval("ProductID") %>"
                                                data-bs-toggle="modal"
                                                data-bs-target="#modal-confirm">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </td>

                                        <td class="content-hidden" style="display: none"><%# getCategoryNameById(Convert.ToInt32(Eval("CategoryID"))) %></td>
                                        <td class="content-hidden" style="display: none"><%# Eval("CreatedAt") %></td>
                                        <td class="content-hidden" style="display: none"><%# String.Format("{0:N0}",Eval("ProductPromotionPrice")).Replace(",", ".") %>₫</td>
                                        <td class="content-hidden" style="display: none"><%# String.Format("{0:N0}",Eval("ProductPrice")).Replace(",", ".") %>₫</td>
                                    </tr>

                                </ItemTemplate>
                            </asp:Repeater>

                            <!-- <tr class="detail-product">
                            <td colspan="5">
                              <div class="detail-product-inner">
                                  <div class="detail-product-row">
                                    <div class="detail-product-name">Loại sản phẩm:</div>
                                    <div class="detail-product-value">Iphone 16</div>
                                  </div>

                                  <div class="detail-product-row">
                                    <div class="detail-product-name">Ngày tạo:</div>
                                    <div class="detail-product-value">05/12/2024 - 2:38:32</div>
                                  </div>

                                  <div class="detail-product-row">
                                    <div class="detail-product-name">Giá khuyển mãi:</div>
                                    <div class="detail-product-value">23.999.000</div>
                                  </div>

                                  <div class="detail-product-row">
                                    <div class="detail-product-name">Giá:</div>
                                    <div class="detail-product-value">25.500.000</div>
                                  </div>
                                 
                              </div>
                            </td>
                          </tr> -->

                            <tr style="display: none"></tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>


        <!-- Modal -->
        <div class="modal fade" id="modal-confirm"  aria-hidden="true" tabindex="-1" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" >Vứt sản phẩm này vào thùng rác ?</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Bạn có chắc chắn là chuyển sản phẩm này đến thùng rác ?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Hủy</button>
                        <a href="" class="btn btn-dark btn-remove-product" runat="server" OnClick="btnRemoveProduct_Click">Xác nhận</a>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>


<%-- Script --%>
<asp:Content ID="Content3" ContentPlaceHolderID="AdminProductScript" runat="Server">
    <!-- Script droplist table -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const productItems = document.querySelectorAll(
                ".table-product-list .product-item"
            );

            // Show detail product when click on productItem 
            productItems.forEach(function (productItem) {
                productItem.addEventListener("click", function () {
                    const productItemClick = this;
                    const productIconRight = productItemClick.querySelector(
                        ".icon-product-right"
                    );
                    const productIconDown =
                        productItemClick.querySelector(".icon-product-down");
                    const hasNextElement = productItemClick.nextElementSibling;

                    if (hasNextElement.classList.contains("detail-product")) {
                        hasNextElement.classList.toggle("hidden-detail-product");

                        productIconDown.classList.toggle("hidden-icon-product");
                        productIconRight.classList.toggle("hidden-icon-product");
                    } else {
                        const productContent =
                            productItemClick.querySelectorAll(".content-hidden");
                        const detailProductElement = `
                <tr class="detail-product">
                    <td colspan="5">
                      <div class="detail-product-inner">
                          <div class="detail-product-row">
                            <div class="detail-product-name">Loại sản phẩm:</div>
                            <div class="detail-product-value">${productContent[0].textContent}</div>
                          </div>

                          <div class="detail-product-row">
                            <div class="detail-product-name">Ngày tạo:</div>
                            <div class="detail-product-value">${productContent[1].textContent}</div>
                          </div>

                          <div class="detail-product-row">
                            <div class="detail-product-name">Giá khuyển mãi:</div>
                            <div class="detail-product-value">${productContent[2].textContent}</div>
                          </div>

                          <div class="detail-product-row">
                            <div class="detail-product-name">Giá:</div>
                            <div class="detail-product-value">${productContent[3].textContent}</div>
                          </div>
                         
                      </div>
                    </td>
                  </tr>
        
        `;

                        productItemClick.insertAdjacentHTML(
                            "afterend",
                            detailProductElement
                        );
                        productIconRight.classList.add("hidden-icon-product");
                        productIconDown.classList.remove("hidden-icon-product");
                    }
                });
            });

            //Remove event when click controls
            const productControls = document.querySelectorAll(".table-product-list .product-controls");

            productControls.forEach(productControl => {
                const btnControls = productControl.querySelectorAll(".btn");

                btnControls.forEach(btnItems => {
                    btnItems.addEventListener("click", function (e) {
                        e.stopPropagation();
                    });

                });

            });
        });
    </script>

    <%-- Script modal confirm --%>
    <script>
            document.addEventListener("DOMContentLoaded", function () {
                const btnDeletes = document.querySelectorAll(".btn-delete");

                // Stop behavior submit form
                btnDeletes.forEach(function (btnDelete) {
                    btnDelete.addEventListener("click", function (e) {
                        e.preventDefault();
                    });
                });
            })
       
            const modalConfirm = document.getElementById("modal-confirm");

            if (modalConfirm) {

                modalConfirm.addEventListener('show.bs.modal', event => { 
                    // Button that triggered the modal
                    const btnClickShowModal = event.relatedTarget;
                    const btnRemoveProduct = document.querySelector(".btn-remove-product");
                   
                    const idProduct = btnClickShowModal.getAttribute('data-id-product');

                    btnRemoveProduct.href = `?idProduct=${idProduct}`;
                    
                });
            }

    </script>
    <%-- Script change nav --%>
    <script>
        const navItemProduct = document.querySelector(".nav-item-product");
        const navProductChild = document.querySelector(".nav-product");

        navItemProduct.classList.add("active");
        navProductChild.classList.add("active");
        navItemProduct.querySelector("#product").classList.add("show");
    </script>
</asp:Content>

