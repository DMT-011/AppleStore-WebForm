using DataBase;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    AppleStoreDBEntities db = new AppleStoreDBEntities();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CheckLoginStatus();
        }

        LoadHeaderCart();
    }

    private void CheckLoginStatus()
    {
        // Kiểm tra xem có Session UserID hoặc FullName không (đã lưu lúc Login)
        if (Session["FullName"] != null)
        {
            // --- TRƯỜNG HỢP ĐÃ ĐĂNG NHẬP ---

            // 1. Ẩn các nút của khách
            liLogin.Visible = false;
            liRegister.Visible = false;

            // 2. Hiện thông tin người dùng và nút đăng xuất
            liUserInfo.Visible = true;
            liLogout.Visible = true;
            liOrder.Visible = true;

            // 3. Gán tên người dùng vào Label
            lblFullName.Text = Session["FullName"].ToString();
        }
        else
        {
            // --- TRƯỜNG HỢP KHÁCH (CHƯA ĐĂNG NHẬP) ---

            // 1. Hiện nút đăng nhập/đăng ký
            liLogin.Visible = true;
            liRegister.Visible = true;

            // 2. Ẩn thông tin user
            liUserInfo.Visible = false;
            liLogout.Visible = false;
            liOrder.Visible = false;
        }
    }

    // Sự kiện khi bấm nút Đăng xuất
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        // 1. Xóa toàn bộ Session
        Session.Clear();
        Session.Abandon();

        // 2. Chuyển hướng về trang chủ hoặc trang đăng nhập
        Response.Redirect("LoginViewPage.aspx");
    }

    protected void btnOrder_Click(object sender, EventArgs e)
    {
       
        // 2. Chuyển hướng về trang chủ hoặc trang đăng nhập
        Response.Redirect("OrderViewPage.aspx");
    }


    // --- HÀM MỚI: Load dữ liệu giỏ hàng lên Header ---
    private void LoadHeaderCart()
    {
        // 1. Kiểm tra đăng nhập
        if (Session["UserID"] == null)
        {
            lblTotalQuantity.Text = "0";
            lblTotalAmount.Text = "0";
            rptHeaderCart.DataSource = null;
            rptHeaderCart.DataBind();
            return;
        }

        int userId = Convert.ToInt32(Session["UserID"]);

        // 2. Lấy giỏ hàng của User
        var cart = db.Carts.FirstOrDefault(c => c.UserID == userId);
        if (cart != null)
        {
            // Lấy danh sách món hàng, kèm theo thông tin Product và Images để hiển thị
            var cartItems = db.CartItems.Where(ci => ci.CartID == cart.CartID).ToList();

            // 3. Bind dữ liệu vào Repeater
            rptHeaderCart.DataSource = cartItems;
            rptHeaderCart.DataBind();

            // 4. Tính tổng số lượng và tổng tiền
            int totalQty = cartItems.Sum(x => x.Quantity ?? 0);
            decimal totalMoney = cartItems.Sum(x => (x.Price ?? 0) * (x.Quantity ?? 0));

            lblTotalQuantity.Text = totalQty.ToString();
            lblTotalAmount.Text = String.Format("{0:N0}", totalMoney).Replace(",", ".");
        }
    }

    // --- HÀM MỚI: Xử lý hiển thị ảnh trong Repeater ---
    // Vì Product chứa 1 List Images, ta cần lấy cái ảnh chính (isImageMain=true)
    public string GetImageSrc(object imagesObj)
    {
        var images = imagesObj as ICollection<DataBase.Image>;

        if (images != null && images.Count > 0)
        {
            // Lấy ảnh chính, nếu không có thì lấy ảnh đầu tiên
            var mainImg = images.FirstOrDefault(i => i.isImageMain) ?? images.FirstOrDefault();

            if (mainImg != null && mainImg.Images != null)
            {
                string base64 = Convert.ToBase64String(mainImg.Images);
                return "data:image/jpeg;base64," + base64;
            }
        }

        // Trả về ảnh mặc định nếu sản phẩm chưa có ảnh
        return "assets/img/no-image.png";
    }

}
