<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LoginViewPage.aspx.cs" Inherits="LoginViewPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Apple Store - Đăng nhập</title>
    <link href="assets/css/loginStyle.css" rel="stylesheet" />

    <!-- Favicon -->
    <link rel="shortcut icon" href="assets/img/favicon/apple-favicon.png" type="image/x-icon">

    <%-- Font gg --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="crossorigin">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500&display=swap" rel="stylesheet">
</head>
<body>
    <form id="form1" class="form-login" runat="server">
        <div class="container-content">
            <div class="login-box">
                <div class="logo">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/f/fa/Apple_logo_black.svg" alt="Apple Logo">
                </div>
                <h1>Chào mừng đến với Apple Store</h1>
                <p>Đăng nhập để khám phá những sản phẩm tuyệt vời</p>
                <div id="loginForm">
                    <div class="form-group">
                        <input id="userNameInput" type="text" runat="server" placeholder="Nhập tên đăng nhập của bạn" required="required">
                    </div>
                    <div class="form-group">
                        <input type="password" id="passwordInput" runat="server" placeholder="Mật khẩu" required="required">
                    </div>
                    
                    <asp:Button CssClass="btn" ID="loginSubmitBtn" runat="server" Text="Đăng nhập" OnClick="loginSubmitBtn_Click" />
                </div>
                <p class="signup-link">Chưa có tài khoản? <a href="RegisterViewPage.aspx">Đăng ký ngay</a></p>
            </div>
        </div>

    </form>
</body>
</html>
