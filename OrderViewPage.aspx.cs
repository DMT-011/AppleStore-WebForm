using DataBase;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OrderViewPage : System.Web.UI.Page
{
    AppleStoreDBEntities db = new AppleStoreDBEntities();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadOrders();
        }
    }

    private void LoadOrders()
    {
        // 1. Kiểm tra đăng nhập
        if (Session["UserID"] == null)
        {
            Response.Redirect("LoginViewPage.aspx");
            return;
        }

        int userId = Convert.ToInt32(Session["UserID"]);

        // 2. Lấy danh sách đơn hàng của User (Sắp xếp mới nhất lên đầu)
        var orders = db.Orders
                       .Where(o => o.UserID == userId)
                       .OrderByDescending(o => o.CreatedAt)
                       .ToList();

        rptOrders.DataSource = orders;
        rptOrders.DataBind();
    }

    // Xử lý sự kiện bấm nút "Xem chi tiết"
    protected void RptOrders_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "ViewDetail")
        {
            int orderId = Convert.ToInt32(e.CommandArgument);
            ShowOrderDetail(orderId);
        }
    }

    private void ShowOrderDetail(int orderId)
    {
        // 1. Tìm đơn hàng để lấy ID và Tổng tiền
        var order = db.Orders.Find(orderId);

        if (order != null)
        {
            lblModalOrderID.Text = order.OrderID.ToString();
            lblModalTotal.Text = String.Format("{0:N0} đ", order.TotalAmount).Replace(",", ".");

            // --- PHẦN QUAN TRỌNG: LẤY THÔNG TIN USER HIỆN TẠI ---

            // Lấy UserID từ Session (Người đang đăng nhập)
            int userId = Convert.ToInt32(Session["UserID"]);

            // Tìm User trong database
            var currentUser = db.Users.Find(userId);

            if (currentUser != null)
            {
                // Gán dữ liệu từ bảng Users vào các Label
                lblModalShipName.Text = currentUser.FullName; // Tên

                // Số điện thoại (Kiểm tra nếu null thì hiện thông báo)
                lblModalPhone.Text = !string.IsNullOrEmpty(currentUser.PhoneNumber)
                                     ? currentUser.PhoneNumber
                                     : "Chưa cập nhật SĐT";

                // Địa chỉ
                lblModalAddress.Text = !string.IsNullOrEmpty(currentUser.AddressUsers)
                                       ? currentUser.AddressUsers
                                       : "Chưa cập nhật địa chỉ";
            }
            else
            {
                // Trường hợp hy hữu không tìm thấy User thì lấy tạm trong đơn hàng cũ
                //lblModalShipName.Text = order.ShipName;
                //lblModalPhone.Text = order.ShipPhone;
                //lblModalAddress.Text = order.ShipAddress;
            }
            // -----------------------------------------------------

            // 2. Lấy danh sách sản phẩm
            var details = db.OrderDetails.Where(d => d.OrderID == orderId).ToList();
            rptOrderDetails.DataSource = details;
            rptOrderDetails.DataBind();

            // 3. Mở Modal
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showOrderDetailModal();", true);
        }
    }

    // --- Các hàm hỗ trợ hiển thị giao diện ---

    // Xử lý màu sắc trạng thái (Bootstrap class)
    public string GetStatusClass(object statusObj)
    {
        string status = statusObj != null ? statusObj.ToString() : "";
        switch (status)
        {
            case "Pending": return "status-pending"; // Chờ xử lý
            case "Shipping": return "status-shipping"; // Đang giao
            case "Completed": return "status-completed"; // Hoàn thành
            case "Cancelled": return "status-cancelled"; // Đã hủy
            default: return "bg-light text-dark";
        }
    }

    // Dịch trạng thái sang tiếng Việt
    public string GetStatusText(object statusObj)
    {
        string status = statusObj != null ? statusObj.ToString() : "";
        switch (status)
        {
            case "Pending": return "Chờ xử lý";
            case "Shipping": return "Đang giao hàng";
            case "Completed": return "Giao thành công";
            case "Cancelled": return "Đã hủy";
            default: return status;
        }
    }

    // Hàm lấy ảnh sản phẩm (Copy từ CartViewPage sang)
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

    // 1. Thêm hàm này để kiểm tra xem có hiện nút Hủy không (Dùng cho thuộc tính Visible bên frontend)
    protected bool IsOrderCancelable(object statusObj)
    {
        string status = statusObj != null ? statusObj.ToString() : "";
        // Chỉ hiện nút Hủy nếu trạng thái là "Pending"
        return status == "Pending";
    }

    protected void rptOrders_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        // 1. Xem chi tiết (Giữ nguyên)
        if (e.CommandName == "ViewDetail")
        {
            int orderId = Convert.ToInt32(e.CommandArgument);
            ShowOrderDetail(orderId);
        }

        // 2. Hủy đơn hàng (CÓ RELOAD PAGE)
        if (e.CommandName == "CancelOrder")
        {
            int orderId = Convert.ToInt32(e.CommandArgument);
            var order = db.Orders.Find(orderId);

            if (order != null)
            {
                if (order.OrderStatus == "Pending")
                {
                    // Đổi trạng thái
                    order.OrderStatus = "Cancelled";
                    db.SaveChanges();

                    // --- CODE MỚI: Alert xong thì Reload trang luôn ---
                    string script = "alert('Đã hủy đơn hàng thành công!'); window.location.href = window.location.href;";
                    ScriptManager.RegisterStartupScript(this, GetType(), "ReloadPage", script, true);
                }
                else
                {
                    // Trường hợp không hủy được cũng reload cho người dùng thấy trạng thái mới nhất
                    string script = "alert('Đơn hàng này không thể hủy (Đã xử lý).'); window.location.href = window.location.href;";
                    ScriptManager.RegisterStartupScript(this, GetType(), "ReloadPage", script, true);
                }
            }
        }
    }

}