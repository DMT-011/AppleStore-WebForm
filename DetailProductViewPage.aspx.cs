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
        if (idProduct != null )
        {
            renderDetailProduct(Int32.Parse(idProduct));
            renderImageProduct(Int32.Parse(idProduct));
            renderImageModal(Int32.Parse(idProduct));
        } else
        {
            Response.Redirect("HomeViewPage.aspx");
        }
    }

    public void renderDetailProduct(int idProduct)
    {
        var productItem = db.Products.SingleOrDefault(item => item.ProductID == idProduct 
        && item.IsDeleted == false);

        if (productItem != null) {
            
            List <Product> productItemContainer = new List<Product> { productItem };

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

}