using DataBase;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CartViewPage : System.Web.UI.Page
{
    AppleStoreDBEntities db = new AppleStoreDBEntities();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadCart();
        }
    }

    private void LoadCart()
    {
        // 1. Kiểm tra đăng nhập
        if (Session["UserID"] == null)
        {
            Response.Redirect("LoginViewPage.aspx");
            return;
        }

        int userId = Convert.ToInt32(Session["UserID"]);

        // 2. Lấy giỏ hàng
        var cart = db.Carts.FirstOrDefault(c => c.UserID == userId);
        if (cart != null)
        {
            var cartItems = db.CartItems.Where(ci => ci.CartID == cart.CartID).ToList();

            if (cartItems.Count > 0)
            {
                // Gán dữ liệu vào Repeater
                rptCartItems.DataSource = cartItems;
                rptCartItems.DataBind();

                // Tính tổng tiền tạm tính (nếu cần hiển thị ở đâu đó ngoài bảng)
                decimal totalAmount = cartItems.Sum(x => (x.Price ?? 0) * (x.Quantity ?? 0));
                // lblGrandTotal.Text = String.Format("{0:N0} đ", totalAmount); 
            }
            else
            {
                // Xử lý khi giỏ hàng trống (Ví dụ: Ẩn bảng, hiện thông báo)
                rptCartItems.DataSource = null;
                rptCartItems.DataBind();
            }
        }
    }

    // Sự kiện Xóa sản phẩm
    protected void rptCartItems_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            int cartItemID = Convert.ToInt32(e.CommandArgument);
            var item = db.CartItems.Find(cartItemID);

            if (item != null)
            {
                db.CartItems.Remove(item);
                db.SaveChanges();

                // Reload lại giỏ hàng sau khi xóa
                LoadCart();

                // Cập nhật lại số lượng trên Header (gọi hàm bên MasterPage)
                //var master = this.Master as MasterPage;
                //if (master != null) master.UpdateCartUI();

                // Thông báo nhẹ
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Đã xóa sản phẩm!');", true);
            }
        }
    }

    // Hàm lấy ảnh đại diện
    public string GetImageSrc(object imagesObj)
    {
        var images = imagesObj as ICollection<DataBase.Image>;
        if (images != null && images.Count > 0)
        {
            var mainImg = images.FirstOrDefault(i => i.isImageMain) ?? images.FirstOrDefault();
            if (mainImg != null && mainImg.Images != null)
            {
                return "data:image/jpeg;base64," + Convert.ToBase64String(mainImg.Images);
            }
        }
        return "assets/img/no-image.png";
    }

    protected void btnProceedToCheckout_Click(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("LoginViewPage.aspx");
            return;
        }

        int userId = Convert.ToInt32(Session["UserID"]);

        // Kiểm tra giỏ hàng có rỗng không
        var cart = db.Carts.FirstOrDefault(c => c.UserID == userId);
        if (cart == null || !db.CartItems.Any(ci => ci.CartID == cart.CartID))
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Giỏ hàng trống trơn à, mua gì đi ông!');", true);
            return;
        }

        // 1. Ẩn Panel Giỏ hàng, Hiện Panel Thanh toán
        pnlCart.Visible = false;
        pnlCheckout.Visible = true;

        // 2. Load thông tin User vào các Label
        var user = db.Users.Find(userId);
        if (user != null)
        {
            lblUserName.Text = user.FullName;
            lblUserEmail.Text = user.Email;
            lblUserPhone.Text = string.IsNullOrEmpty(user.PhoneNumber) ? "Chưa cập nhật" : user.PhoneNumber;
            lblUserAddress.Text = string.IsNullOrEmpty(user.AddressUsers) ? "Chưa cập nhật" : user.AddressUsers;
        }

        // 3. Tính tổng tiền hiển thị
        var cartItems = db.CartItems.Where(ci => ci.CartID == cart.CartID).ToList();
        decimal totalMoney = cartItems.Sum(x => (x.Price ?? 0) * (x.Quantity ?? 0));

        string strTotal = String.Format("{0:N0}", totalMoney).Replace(",", ".");
        lblSubTotal.Text = strTotal;
        lblOrderTotal.Text = strTotal;
    }

    // --- SỰ KIỆN 2: Bấm nút "Quay lại giỏ hàng" ---
    protected void btnBackToCart_Click(object sender, EventArgs e)
    {
        pnlCart.Visible = true;
        pnlCheckout.Visible = false;
        LoadCart(); // Load lại dữ liệu
    }

    // --- SỰ KIỆN 3: Bấm nút "Hoàn tất" (TẠO ORDER) ---
    protected void btnConfirmOrder_Click(object sender, EventArgs e)
    {
        try
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            var cart = db.Carts.FirstOrDefault(c => c.UserID == userId);
            var cartItems = db.CartItems.Where(ci => ci.CartID == cart.CartID).ToList();

            if (cartItems.Count == 0) return;

            // 1. Xác định phương thức thanh toán
            string paymentMethod = "COD";
            if (rbScan.Checked) paymentMethod = "Banking";
            else if (rbPaypal.Checked) paymentMethod = "Paypal";

            // 2. Tạo Đơn Hàng (Order)
            Order newOrder = new Order();
            newOrder.UserID = userId;
            newOrder.CreatedAt = DateTime.Now;
            newOrder.TotalAmount = cartItems.Sum(x => (x.Price ?? 0) * (x.Quantity ?? 0));
            newOrder.OrderStatus = "Pending"; // Trạng thái chờ xử lý


            // Nếu bảng Order của ông có cột PaymentMethod thì gán vào
            // newOrder.PaymentMethod = paymentMethod; 

            db.Orders.Add(newOrder);
            db.SaveChanges(); // Lưu xong để có OrderID

            // 3. Tạo Chi Tiết Đơn Hàng (OrderDetail)
            foreach (var item in cartItems)
            {
                OrderDetail detail = new OrderDetail();
                detail.OrderID = newOrder.OrderID;
                detail.ProductID = item.ProductID;
                detail.Quantity = item.Quantity;
                detail.Price = item.Price;

                db.OrderDetails.Add(detail);
            }

            // 4. Xóa Giỏ Hàng
            db.CartItems.RemoveRange(cartItems);
            db.SaveChanges();
       

            // 6. Thông báo thành công và về trang chủ
            string js = "alert('Đặt hàng thành công! Cảm ơn bạn đã ủng hộ.'); window.location.href='HomeViewPage.aspx';";
            ScriptManager.RegisterStartupScript(this, GetType(), "OrderSuccess", js, true);
        }
        catch (Exception ex)
        {
            // Báo lỗi nếu có trục trặc database
            string jsError = $"alert('Có lỗi xảy ra: {ex.Message}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "OrderError", jsError, true);
        }
    }
}