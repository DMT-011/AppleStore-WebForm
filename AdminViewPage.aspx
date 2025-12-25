<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAdmin.master" AutoEventWireup="true" CodeFile="AdminViewPage.aspx.cs" Inherits="AdminViewPage" %>

<%-- Head --%>
<asp:Content ID="Content1" ContentPlaceHolderID="AdminPageHead" Runat="Server">
    <title>Apple Store - Trang quản trị viên</title>
</asp:Content>

<%-- Body --%>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminDashBoardPageContent" Runat="Server">
    <h3>Để cho bớt trống chua co cc gi </h3>
</asp:Content>



<%-- Script --%>
<asp:Content ID="Content3" ContentPlaceHolderID="AdminDashBoardPageScript" Runat="Server">
    <script>
        const navItemDashboard = document.querySelector(".nav-item-dashboard");

        navItemDashboard.classList.add("active");
    </script>
</asp:Content>
