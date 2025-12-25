using DataBase;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.ServiceModel.Channels;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RegisterViewPage : System.Web.UI.Page
{
    AppleStoreDBEntities db = new AppleStoreDBEntities();

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private void createAccountUser()
    {
        var userItem = new User();

        userItem.FullName = fullNameInput.Value;
        userItem.UserName = userNameInput.Value.Trim();
        userItem.Passwords = HashPassword(passwordInput.Value.Trim());
        userItem.Email = emailInput.Value.Trim();
        userItem.PhoneNumber = phoneInput.Value;
        userItem.AddressUsers = addressInput.Value;
        userItem.UserImage = null;
        userItem.CreatedAt = DateTime.Now;
        userItem.RoleID = 1;

        db.Users.Add(userItem);
        db.SaveChanges();

        Response.Write("<script>alert('Đăng ký thành công.') </script>");

    }

    private bool isExistEmail(string userEmail)
    {
        var userItem = db.Users.Where(item => item.Email == userEmail)
            .SingleOrDefault();

        if (userItem == null) {
            return true;
        }

        return false;
    }

    private string HashPassword(string password)
    {
        using (SHA256 sha256Hash = SHA256.Create())
        {
            byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(password));
            StringBuilder builder = new StringBuilder();
            foreach (byte b in bytes)
            {
                builder.Append(b.ToString("x2"));
            }
            return builder.ToString();
        }
    }


    protected void registerSubmitBtn_Click(object sender, EventArgs e)
    {
        if (passwordInput.Value.Trim() == confirmPasswordInput.Value.Trim()
            && isExistEmail(emailInput.Value.Trim()))
        {
            createAccountUser();
        } else
        {
            Response.Write("<script>alert('Email đã tồn tại hoặc mật khẩu nhập lại không chính xác!') </script>");
        }
    }
}