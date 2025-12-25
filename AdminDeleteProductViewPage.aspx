<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.master" AutoEventWireup="true" CodeFile="AdminDeleteProductViewPage.aspx.cs" Inherits="AdminDeleteProductViewPage" %>

<%-- Head --%>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminDeleteProductHead" runat="Server">
    <%-- Css style --%>
    <link href="assets/css/adminDelete.css" rel="stylesheet" />

    <title>Admin - Thùng rác</title>
</asp:Content>


<%-- Body --%>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminDeleteProductContent" runat="Server">
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
                    <a href="#">Thùng rác</a>
                </li>
            </ul>
        </div>

        <div class="control-product">
            <a href="AdminProductViewPage.aspx" class="btn btn-primary">
                <i class="icon-control fas fa-undo-alt"></i>
                Trở về
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
                                <th scope="col">Giá</th>
                                <th scope="col">Thao tác</th>
                            </tr>
                        </thead>

                        <tbody class="table-group-divider">

                            <asp:Repeater ID="RenderProductDeletedBlock" runat="server">
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
                                        <td><%# String.Format("{0:N0}",Eval("ProductPrice")).Replace(",", ".") %></td>
                                        <td class="product-controls">
                                            <a
                                                href="?idProduct=<%# Eval("ProductID") %>"
                                                class="btn btn-black"
                                                data-bs-toggle="tooltip"
                                                data-bs-placement="top"
                                                data-bs-title="Khôi phục">
                                                <i class="fas fa-redo-alt"></i>
                                            </a>

                                            <button
                                                href="#"
                                                class="btn btn-danger btn-delete"
                                                data-id-product="<%# Eval("ProductID") %>"
                                                data-bs-toggle="modal"
                                                data-bs-target="#modal-confirm-delete">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </td>

                                        <td class="content-hidden" style="display: none"><%# getCategoryNameById(Convert.ToInt32(Eval("CategoryID"))) %>
                                        </td>
                                        <td class="content-hidden" style="display: none"><%# Eval("CreatedAt") %>
                                        </td>
                                        <td class="content-hidden" style="display: none"><%# String.Format("{0:N0}",Eval("ProductPromotionPrice")).Replace(",", ".") %>
                                        </td>
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
    <div class="modal fade" id="modal-confirm-delete" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Xóa vĩnh viễn sản phẩm này ?</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Hành động này sẽ xóa vĩnh viễn sản phẩm này, không thể khôi phục lại !
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light " data-bs-dismiss="modal">Hủy</button>
                    <a href="" class="btn btn-danger btn-delete-product">Xóa vĩnh viễn</a>
                </div>
            </div>
        </div>
    </div>

</asp:Content>


<%-- Script --%>
<asp:Content ID="Content3" ContentPlaceHolderID="AdminDeleteProductScript" runat="Server">
    <%-- Script modal confirm delete --%>
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

        const modalConfirm = document.getElementById("modal-confirm-delete");

        if (modalConfirm) {

            modalConfirm.addEventListener('show.bs.modal', event => {
                // Button that triggered the modal
                const btnClickShowModal = event.relatedTarget;
                const btnDeleteProduct = document.querySelector(".btn-delete-product");

                const idProduct = btnClickShowModal.getAttribute('data-id-product');

                btnDeleteProduct.href = `?idProductDelete=${idProduct}`;

            });
        }

    </script>


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
                            <div class="detail-product-value">${productContent[2].textContent}₫</div>
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
</asp:Content>


