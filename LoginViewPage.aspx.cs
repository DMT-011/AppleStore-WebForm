using DataBase;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LoginViewPage : System.Web.UI.Page
{
    AppleStoreDBEntities db = new AppleStoreDBEntities();

    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            if (Session["RoleID"] != null)
            {
                var roleId = (int) Session["RoleID"];

                if (roleId == 2)
                {
                    Response.Redirect("AdminViewPage.aspx");
                }
                else
                {
                    Response.Redirect("HomeViewPage.aspx");
                }
            }
        }
    }

    private void AuthenticationUser()
    {
        var userName = userNameInput.Value.Trim();
        var userPassword = passwordInput.Value.Trim();

        var user = db.Users.FirstOrDefault(item => item.UserName == userName);

        if (user != null && VerifyPassword(userPassword, user.Passwords))
        {

            // --- Code Mới: Lưu thêm thông tin cần thiết ---
            Session["UserEmail"] = user.Email;
            Session["UserID"] = user.UserID;     // Quan trọng: dùng để query Cart, Order
            Session["FullName"] = user.FullName; // Dùng để hiển thị tên "Xin chào..."
            Session["RoleID"] = user.RoleID;     // Dùng để phân quyền Admin/User

            // Kiểm tra quyền để chuyển hướng (Ví dụ: RoleID = 2 là Admin)
            if (user.RoleID == 2)
            {
                Response.Redirect("AdminViewPage.aspx");
            }
            else
            {
                Response.Redirect("HomeViewPage.aspx");
            }

        }
        else
        {
            Response.Write("<script>alert('Thông tin đăng nhập không chính xác!') </script>");
        }
    }

    protected void loginSubmitBtn_Click(object sender, EventArgs e)
    {
        AuthenticationUser();
    }

    private bool VerifyPassword(string enteredPassword, string storedHash)
    {
        using (SHA256 sha256Hash = SHA256.Create())
        {
            byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(enteredPassword));
            StringBuilder builder = new StringBuilder();
            foreach (byte b in bytes)
            {
                builder.Append(b.ToString("x2"));
            }
            return storedHash == builder.ToString();
        }
    }
}