<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.master" AutoEventWireup="true" CodeFile="AdminUpdateProductViewPage.aspx.cs" Inherits="AdminUpdateProductViewPage" %>

<%-- Head --%>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminUpdateProductHead" runat="Server">
    <title>Admin - Cập nhật sản phẩm</title>
    <link href="assets/css/updateProductForm.css" rel="stylesheet" />

    <!-- Tiny editor -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4" crossorigin="anonymous"></script>
    <script src="https://cdn.tiny.cloud/1/kni28pimx3vbme8ar0q8guu556w4ig99fxodlsqrr7ettxqb/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
    <script src="https://cdn.jsdelivr.net/npm/@tinymce/tinymce-jquery@2/dist/tinymce-jquery.min.js"></script>

</asp:Content>

<%-- Content --%>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminUpdateProductContent" runat="Server">
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
                    <a href="#">Cập nhật sản phẩm</a>
                </li>
            </ul>


        </div>

        <div class="control-product">
 <%--           <a href="#" class="btn btn-black">
                <i class="icon-control fas fa-window-restore"></i>
                Cập nhật
            </a>--%>
            <asp:Button ID="updateProductBtn" CssClass="btn btn-black btn-update-product" runat="server" Text="Cập nhật" OnClick="updateProductBtn_Click"/>

            <a href="AdminProductViewPage.aspx" class="btn btn-primary">
                <i class="icon-control fas fa-undo-alt"></i>
                Trở về
            </a>
        </div>

        <div class="update-product-form-area">
            <div class="row">
                <div class="col-12">
                    <div class="label-notice">* Các mục đánh dấu (*) là bắt buộc</div>
                </div>
                <!-- Form side left -->
                <div class="col-9">
                    <div class="form-left">
                        <div class="form-group">
                            <label for="name-product" class="form-label">Tên sản phẩm</label>
                            <input type="text" class="form-input" id="nameProduct" runat="server">
                        </div>

                        <div class="form-group">
                            <label for="product-desc-content" class="form-label">Mô tả sản phẩm</label>
                            <textarea id="productDescContent" class="product-desc-content" runat="server"></textarea>
                            <asp:TextBox ID="productDescContentHidden" TextMode="MultiLine" Style="display: none" runat="server"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label for="product-detail-content" class="form-label">Chi tiết sản phẩm</label>
                            <textarea id="productDetailContent" class="product-detail-content" runat="server"></textarea>
                            <asp:TextBox ID="productDetailContentHidden" TextMode="MultiLine" Style="display: none" runat="server"></asp:TextBox>
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
                                <%--<input type="file" name="" class="img-product-main">--%>
                                <asp:FileUpload ID="uploadImageMain" class="img-product-main" runat="server" />

                                <div class="img-product-wrapper">
                                    <img accept="image/*" src="<%= GetImageData(Int32.Parse(Request.QueryString["productID"]), 0) %>" class="product-img-view" alt="">
                                </div>
                            </div>

                            <div class="upload-img-item">
                                <span class="upload-img-title">Ảnh phụ 1</span>
                                <%--<input type="file" name="" class="img-product-sub-1">--%>
                                <asp:FileUpload ID="uploadImageSub1" class="img-product-sub-1" runat="server" />

                                <div class="img-product-wrapper">
                                    <img accept="image/*" src="<%= GetImageData(Int32.Parse(Request.QueryString["productID"]), 1) %>" class="product-img-view" alt="">
                                </div>
                            </div>

                            <div class="upload-img-item">
                                <span class="upload-img-title">Ảnh phụ 2</span>
                                <%--<input type="file" name="" class="img-product-sub-2">--%>
                                <asp:FileUpload ID="uploadImageSub2" class="img-product-sub-2" runat="server" />


                                <div class="img-product-wrapper">
                                    <img accept="image/*" src="<%= GetImageData(Int32.Parse(Request.QueryString["productID"]), 2) %>" class="product-img-view" alt="">
                                </div>
                            </div>

                            <div class="upload-img-item">
                                <span class="upload-img-title">Ảnh phụ 3</span>
                                <%--<input type="file" name="" class="img-product-sub-3">--%>
                                <asp:FileUpload ID="uploadImageSub3" class="img-product-sub-3" runat="server" />

                                <div class="img-product-wrapper">
                                    <img accept="image/*" src="<%= GetImageData(Int32.Parse(Request.QueryString["productID"]), 3) %>" class="product-img-view" alt="">
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="nameProduct" class="form-label">Loại sản phẩm</label>

                            <%--<select name="" id="category-product" class="select-input">
                                <option value="0">[Chọn loại sản phẩm]</option>
                                <option value="1">Iphone 16</option>
                                <option value="2">Watch</option>
                            </select>--%>

                            <asp:DropDownList ID="categoryProduct" CssClass="select-input" runat="server">
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label for="product-quantity" class="form-label">Số lượng</label>
                            <input type="number" min="1" class="form-input" id="productQuantity" runat="server">
                        </div>

                        <div class="form-group">
                            <label for="product-price" class="form-label">Giá gốc</label>
                            <input type="text" class="form-input" id="productPrice" runat="server">
                        </div>

                        <div class="form-group">
                            <label for="product-price-promotion" class="form-label">Giá khuyến mãi</label>
                            <input type="text" class="form-input" id="productPricePromotion" runat="server">
                        </div>

                        <div class="form-group">
                            <label for="product-has-promotion" class="form-label">Chương trình giảm giá</label>

                            <asp:DropDownList ID="productHasPromotion" CssClass="select-input" runat="server">
                                <asp:ListItem Text="Có" Value="true" />
                                <asp:ListItem Text="Không" Value="false" />
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label for="product-status" class="form-label">Trạng thái</label>

                            <asp:DropDownList ID="productStatus" CssClass="select-input" runat="server">
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
<asp:Content ID="Content3" ContentPlaceHolderID="AdminUpdateProductScript" runat="Server">
    <!-- Tiny editor -->
    <script>
        document.addEventListener("DOMContentLoaded", () => {
            // Text editor product desc content
            tinymce.init({
                selector: "#<%= productDescContent.ClientID %>",
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
                selector: "#<%= productDetailContent.ClientID %>",
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
            const btnUpdateProduct = document.querySelector(".btn-update-product");
            const descInputHidden = document.getElementById("<%= productDescContentHidden.ClientID %>");
            const detailInputHidden = document.getElementById("<%= productDetailContentHidden.ClientID %>");


            btnUpdateProduct.addEventListener("click", function (e) {
                const descContent = tinymce.get("<%= productDescContent.ClientID %>").getContent();
                const detailContent = tinymce.get("<%= productDetailContent.ClientID %>").getContent();

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

                if (fileImg) {
                    const reader = new FileReader();

                    reader.onload = function (e) {
                        // assign url img to img element
                        imgElement.src = e.target.result;
                        imgElement.style.display = "inline-block";
                        imgElement.parentElement.style.borderBottom = "1px dashed #ededed";
                    }

                    // Read file as a URL
                    reader.readAsDataURL(fileImg);

                } else {
                    imgElement.src = "";
                    imgElement.style.display = "none";
                    imgElement.parentElement.style.borderBottom = "";
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



        handleRenderImageOnchange(inputImageMain, imageMain);
        handleRenderImageOnchange(inputImageSub1, imageSub1);
        handleRenderImageOnchange(inputImageSub2, imageSub2);
        handleRenderImageOnchange(inputImageSub3, imageSub3);


        document.addEventListener("DOMContentLoaded", function (e) {
            console.log(inputImageMain)
        });

        


    </script>
</asp:Content>


