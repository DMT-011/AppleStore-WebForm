<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.master" AutoEventWireup="true" CodeFile="AdminAddProductViewPage.aspx.cs" Inherits="AdminAddProductViewPage" %>

<%-- Head --%>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminAddProductHead" runat="Server">
    <title>Admin - Thêm sản phẩm</title>
    <link href="assets/css/addProductForm.css" rel="stylesheet" />
    <!-- Tiny editor -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4" crossorigin="anonymous"></script>
    <script src="https://cdn.tiny.cloud/1/kni28pimx3vbme8ar0q8guu556w4ig99fxodlsqrr7ettxqb/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
    <script src="https://cdn.jsdelivr.net/npm/@tinymce/tinymce-jquery@2/dist/tinymce-jquery.min.js"></script>

</asp:Content>

<%-- Body --%>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminAddProductContent" runat="Server">
    <div class="page-inner page-inner-custom">
        <!-- Breadcrumb-->
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
                    <a href="#">Thêm sản phẩm</a>
                </li>
            </ul>


        </div>
        <!-- Control Add product && Remove product list -->
        <div class="control-product">
  <%--           <button class="btn btn-black btn-add-product" runat="server" id="addProductBtn" OnClickServưe="AddProductBtn_Click" >
                <i class="icon-control fas fa-calendar-check"></i>
                Thêm sản phẩm
            </button>--%>

            <asp:Button ID="addProductBtn" Text="Thêm sản phầm" OnClick="addProductBtn_Click" CssClass="btn btn-black btn-add-product" runat="server" />


            <a href="AdminProductViewPage.aspx" class="btn btn-primary">
                <i class="icon-control fas fa-undo-alt"></i>
                Trở về
            </a>
        </div>
        <!-- Add product form admin-->
        <div class="add-product-form-area">
            <div class="row">
                <div class="col-12">
                    <div class="label-notice">* Các mục đánh dấu (*) là bắt buộc</div>
                </div>
                <!-- Form side left -->
                <div class="col-9">
                    <div class="form-left">
                        <div class="form-group">
                            <label for="name-product" class="form-label">Tên sản phẩm</label>
                            <input type="text" class="form-input" id="nameProduct" required="required" runat="server">
                        </div>

                        <div class="form-group">
                            <label for="product-desc-content" class="form-label">Mô tả sản phẩm</label>
                            <asp:TextBox ID="productDescContentHidden" TextMode="MultiLine" Style="display: none" runat="server"></asp:TextBox>
                            <textarea id="product-desc-content" ></textarea>
                        </div>

                        <div class="form-group">
                            <label for="product-detail-content" class="form-label">Chi tiết sản phẩm</label>
                            <asp:TextBox ID="productDetailContentHidden" TextMode="MultiLine" Style="display: none" runat="server"></asp:TextBox>
                            <textarea id="product-detail-content" ></textarea>
                        </div>
                    </div>
                </div>

                <!-- Form side right -->
                <div class="col-3">
                    <div class="form-right">
                        <div class="form-group">
                            <label for="img-product-main" class="form-label">Hình ảnh</label>
                            <div class="upload-img-item">
                                <span class="upload-img-title">Ảnh chính</span>
                                <%--<input type="file" id="uploadImageMain" class="img-product-main" runat="server">--%>

                                <asp:FileUpload ID="uploadImageMain" required="required" class="img-product-main" runat="server" />

                                <div class="img-product-wrapper">
                                    <img accept="image/*" src="" class="product-img-view" alt="">
                                </div>
                            </div>

                            <div class="upload-img-item">
                                <span class="upload-img-title">Ảnh phụ 1</span>
                                <%--<input type="file" id="uploadImageSub1" runat="server" class="img-product-sub-1">--%>

                                <asp:FileUpload ID="uploadImageSub1" required="required" class="img-product-sub-1" runat="server" />

                                <div class="img-product-wrapper">
                                    <img accept="image/*" src="" class="product-img-view" alt="">
                                </div>
                            </div>

                            <div class="upload-img-item">
                                <span class="upload-img-title">Ảnh phụ 2</span>
                                <%--<input type="file" id="uploadImageSub2" runat="server" class="img-product-sub-2">--%>

                                <asp:FileUpload ID="uploadImageSub2" required="required" class="img-product-sub-2" runat="server" />

                                <div class="img-product-wrapper">
                                    <img accept="image/*" src="" class="product-img-view" alt="">
                                </div>
                            </div>

                            <div class="upload-img-item">
                                <span class="upload-img-title">Ảnh phụ 3</span>
                                <%--<input type="file" id="uploadImageSub3" runat="server" class="img-product-sub-3">--%>

                                <asp:FileUpload ID="uploadImageSub3" required="required" class="img-product-sub-3" runat="server" />

                                <div class="img-product-wrapper">
                                    <img accept="image/*" src="" class="product-img-view" alt="">
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="nameProduct" class="form-label">Loại sản phẩm</label>

                            <%-- <select ID="categoryProduct" runat="server" class="select-input">
                                <option value="0">[Chọn loại sản phẩm]</option>
                                <option value="1">Iphone 16</option>
                                <option value="2">Macb</option>
                            </select>--%>
                            <asp:DropDownList ID="categoryProduct" required="required" CssClass="select-input" runat="server">
                            </asp:DropDownList>

                        </div>

                        <div class="form-group">
                            <label for="product-quantity" class="form-label">Số lượng</label>
                            <input type="number" min="1" required="required" class="form-input" id="productQuantity" runat="server">
                        </div>

                        <div class="form-group">
                            <label for="product-price" class="form-label">Giá gốc</label>
                            <input type="text" required="required" class="form-input" id="productPrice" runat="server">
                        </div>

                        <div class="form-group">
                            <label for="product-price-promotion" class="form-label">Giá khuyến mãi</label>
                            <input type="text" required="required" class="form-input" id="productPricePromotion" runat="server">
                        </div>

                        <div class="form-group">
                            <label for="product-has-promotion" class="form-label">Chương trình giảm giá</label>

                            <asp:DropDownList ID="productHasPromotion" required="required" CssClass="select-input" runat="server">
                                <asp:ListItem Text="Có" Value="true" />
                                <asp:ListItem Text="Không" Value="false" />
                            </asp:DropDownList>

                        </div>

                        <div class="form-group">
                            <label for="product-status" class="form-label">Trạng thái</label>

                            <asp:DropDownList ID="productStatus" required="required" CssClass="select-input" runat="server">
                                <asp:ListItem Text="Hiển thị" Value="true" />
                                <asp:ListItem Text="Không hiển thị" Value="false" />
                            </asp:DropDownList>

                        </div>


                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>


<%-- Script --%>
<asp:Content ID="Content3" ContentPlaceHolderID="AdminAddProductScript" runat="Server">
    <!-- Tiny editor -->
    <script>
        document.addEventListener("DOMContentLoaded", () => {
            // Text editor product desc content
            tinymce.init({
                selector: "#product-desc-content",
                height: 400,
                menubar: true,
                plugins: [
                    'advlist', 'autolink', 'lists', 'link', 'image', 'charmap', 'preview',
                    'anchor', 'searchreplace', 'visualblocks', 'fullscreen',
                    'insertdatetime', 'media', 'table', 'code', 'help', 'wordcount'
                ],
                toolbar: 'undo redo | blocks | bold italic backcolor | ' +
                    'alignleft aligncenter alignright alignjustify | ' +
                    'bullist numlist outdent indent | removeformat | fullscreen | preview | help',
            });

            // Text editor product detail content
            tinymce.init({
                selector: "#product-detail-content",
                height: 400,
                menubar: true,
                plugins: [
                    'advlist', 'autolink', 'lists', 'link', 'image', 'charmap', 'preview',
                    'anchor', 'searchreplace', 'visualblocks', 'fullscreen',
                    'insertdatetime', 'media', 'table', 'code', 'help', 'wordcount'
                ],
                toolbar: 'undo redo | blocks | bold italic backcolor | ' +
                    'alignleft aligncenter alignright alignjustify | ' +
                    'bullist numlist outdent indent | removeformat | fullscreen | preview | help',
            });
        });
    </script>

    <%-- Handle get value tiny --%>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const btnAddProduct = document.querySelector(".btn-add-product");
            const descInputHidden = document.getElementById("<%= productDescContentHidden.ClientID %>");
            const detailInputHidden = document.getElementById("<%= productDetailContentHidden.ClientID %>");


            btnAddProduct.addEventListener("click", function (e) {
                const descContent = tinymce.get("product-desc-content").getContent();
                const detailContent = tinymce.get("product-detail-content").getContent();

                descInputHidden.value = descContent;
                detailInputHidden.value = detailContent;

            });
        });

    </script>
    <!-- Auto render img when upload other file img -->
    <script>
        function handleRenderImageOnchange(inputElement, imgElement) {
            inputElement.addEventListener("input", function (e) {
                const fileImg = e.target.files[0];
                const imgWrapper = imgElement.parentElement;

                if (fileImg) {
                    const reader = new FileReader();

                    reader.onload = function (e) {
                        // assign url img to img element
                        imgElement.src = e.target.result;
                        imgElement.style.display = "inline-block";
                        imgWrapper.style.borderBottom = "1px dashed #ededed";
                        imgWrapper.style.display = "block";
                    }

                    // Read file as a URL
                    reader.readAsDataURL(fileImg);


                } else {
                    imgElement.src = "";
                    imgElement.style.display = "none";
                    imgWrapper.style.display = "none";
                    imgWrapper.style.borderBottom = "";
                }

            });
        }


        const inputImageMain = document.querySelector(".img-product-main");
        const imageMain = inputImageMain.parentElement.querySelector(".product-img-view");

        const inputImageSub1 = document.querySelector(".img-product-sub-1");
        const imageSub1 = inputImageSub1.parentElement.querySelector(".product-img-view");

        const inputImageSub2 = document.querySelector(".img-product-sub-2");
        const imageSub2 = inputImageSub2.parentElement.querySelector(".product-img-view");

        const inputImageSub3 = document.querySelector(".img-product-sub-3");
        const imageSub3 = inputImageSub3.parentElement.querySelector(".product-img-view");

        const imgWrappers = document.querySelectorAll(".upload-img-item .img-product-wrapper");

        imgWrappers.forEach(function (imgWrapperItem) {
            imgWrapperItem.style.display = "none";
        })

        handleRenderImageOnchange(inputImageMain, imageMain);
        handleRenderImageOnchange(inputImageSub1, imageSub1);
        handleRenderImageOnchange(inputImageSub2, imageSub2);
        handleRenderImageOnchange(inputImageSub3, imageSub3);


    </script>
</asp:Content>
