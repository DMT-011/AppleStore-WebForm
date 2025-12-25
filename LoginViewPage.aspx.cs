using DataBase;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LoginVIewPage : System.Web.UI.Page
{
    AppleStoreDBEntities db = new AppleStoreDBEntities();

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private void AuthenticationUser()
    {
        var userEmail = userEmailInput.Value.Trim();
        var userPassword = passwordInput.Value.Trim();

        var user = db.Users.FirstOrDefault(item => item.Email == userEmail);

        if (user != null && VerifyPassword(userPassword, user.Passwords)) {

            Session["UserEmail"] = user.Email;
            Response.Redirect("HomeViewPage.aspx");
        } else
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