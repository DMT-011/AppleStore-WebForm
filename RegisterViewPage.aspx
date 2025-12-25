q<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegisterViewPage.aspx.cs" Inherits="RegisterViewPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Apple Store - Đăng ký</title>

    <!-- Favicon -->
    <link rel="shortcut icon" href="assets/img/favicon/apple-favicon.png" type="image/x-icon">

    <%-- Font gg --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="crossorigin">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500&display=swap" rel="stylesheet">

    <%-- Style Css --%>
    <link href="assets/css/registerStyle.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="register-wrapper">
            <div class="register-card">
                <div class="logo">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/f/fa/Apple_logo_black.svg" alt="Apple Logo">
                </div>
                <h2>Đăng ký tài khoản</h2>
                <p>Điền thông tin bên dưới để tạo tài khoản của bạn</p>
                <div>
                    <div class="form-grid">
                        <div class="form-group">
                            <input type="text" placeholder="Họ và tên" id="fullNameInput" runat="server" required="required">
                        </div>

                        <div class="form-group">
                            <input type="text" placeholder="Tên đăng nhập" id="userNameInput" runat="server" required="required">
                        </div>

                        <div class="form-group">
                            <input type="tel" placeholder="Số điện thoại" id="phoneInput" runat="server" required="required">
                        </div>

                        <div class="form-group">
                            <input type="password" placeholder="Mật khẩu" id="passwordInput" runat="server" required="required">
                        </div>

                        <div class="form-group">
                            <input type="email" placeholder="Địa chỉ email" id="emailInput" runat="server" required="required">
                        </div>

                        <div class="form-group">
                            <input type="password" placeholder="Nhập lại mật khẩu" id="confirmPasswordInput" runat="server" required="required">
                        </div>

                        <div class="form-group form-full-width">
                            <input type="text" placeholder="Địa chỉ" id="addressInput" runat="server" required="required">
                        </div>
                    </div>

                    <asp:Button CssClass="btn" ID="registerSubmitBtn" runat="server" Text="Đăng ký" OnClick="registerSubmitBtn_Click" />
                </div>
                <div class="signin-link">
                    <p>Bạn đã có tài khoản? <a href="LoginViewPage.aspx">Đăng nhập ngay</a></p>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
