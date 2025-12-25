using DataBase;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DetailProductViewPage : System.Web.UI.Page
{
    AppleStoreDBEntities db = new AppleStoreDBEntities();

    protected void Page_Load(object sender, EventArgs e)
    {
        var idProduct = Request.QueryString["productID"];
        if (idProduct != null)
        {
            renderDetailProduct(Int32.Parse(idProduct));
            renderImageProduct(Int32.Parse(idProduct));
            renderImageModal(Int32.Parse(idProduct));
        }
        else
        {
            Response.Redirect("HomeViewPage.aspx");
        }
    }

    public void renderDetailProduct(int idProduct)
    {
        var productItem = db.Products.SingleOrDefault(item => item.ProductID == idProduct
        && item.IsDeleted == false);

        if (productItem != null)
        {

            List<Product> productItemContainer = new List<Product> { productItem };

            // Detail product content 
            RenderDetailBlock.DataSource = productItemContainer;
            RenderDetailBlock.DataBind();

            // Desc product content 
            RenderContentBlock.DataSource = productItemContainer;
            RenderContentBlock.DataBind();

        }
    }

    public string getNameProductByID(string queryString)
    {
        var idProduct = Int32.Parse(queryString);
        var productItem = db.Products.SingleOrDefault(item => item.ProductID == idProduct
        && item.IsDeleted == false);

        return $"{productItem.ProductName}";
    }

    private void renderImageModal(int idProduct)
    {
        var images = db.Images.Where(item => item.ProductID == idProduct);

        RenderImageModelBlock.DataSource = images.ToList();
        RenderImageModelBlock.DataBind();
    }

    public void renderImageProduct(int idProduct)
    {
        var images = db.Images.Where(item => item.ProductID == idProduct);

        RenderImageBlock.DataSource = images.ToList();
        RenderImageBlock.DataBind();
    }

    public string getImage(byte[] imgBinary)
    {
        var resultImage = "";

        string base64Image = Convert.ToBase64String(imgBinary);

        resultImage = "data:image/jpeg;base64," + base64Image;

        return resultImage;
    }

    protected void RenderDetailBlock_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "AddToCart")
        {
            // 1. Kiểm tra đăng nhập
            if (Session["UserID"] == null)
            {
                Response.Redirect("LoginViewPage.aspx");
                return;
            }

            // 2. Lấy ProductID từ CommandArgument
            int productID = Convert.ToInt32(e.CommandArgument);

            // 3. Lấy Số lượng từ TextBox bên trong Repeater Item
            TextBox txtQty = (TextBox)e.Item.FindControl("txtQuantity");
            int quantity = 1; // Mặc định là 1 nếu lỗi
            if (txtQty != null && !string.IsNullOrEmpty(txtQty.Text))
            {
                int.TryParse(txtQty.Text, out quantity);
            }

            // 4. Gọi hàm thêm vào giỏ hàng
            AddToCartLogic(productID, quantity);
        }
    }


    private void AddToCartLogic(int productID, int quantity)
    {
        int userID = Convert.ToInt32(Session["UserID"]);

        // Tìm giỏ hàng của User
        var cart = db.Carts.FirstOrDefault(c => c.UserID == userID);

        // Nếu chưa có giỏ thì tạo mới
        if (cart == null)
        {
            cart = new Cart { UserID = userID };
            db.Carts.Add(cart);
            db.SaveChanges(); // Lưu để lấy CartID
        }

        // Kiểm tra xem sản phẩm đã có trong giỏ chưa
        var cartItem = db.CartItems.FirstOrDefault(ci => ci.CartID == cart.CartID && ci.ProductID == productID);
        var product = db.Products.Find(productID);

        // Giá bán (ưu tiên giá khuyến mãi nếu có)
        decimal price = product.ProductPromotionPrice ?? product.ProductPrice ?? 0;

        if (cartItem != null)
        {
            // Nếu có rồi thì cộng dồn số lượng
            cartItem.Quantity += quantity;
            cartItem.TotalPrice = cartItem.Quantity * price;
        }
        else
        {
            // Nếu chưa có thì thêm mới
            cartItem = new CartItem
            {
                CartID = cart.CartID,
                ProductID = productID,
                Quantity = quantity,
                Price = price,
                TotalPrice = price * quantity
            };
            db.CartItems.Add(cartItem);
        }

        db.SaveChanges();


        string script = "alert('Đã thêm sản phẩm vào giỏ hàng thành công!');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "AddToCartAlert", script, true);
    }
}

