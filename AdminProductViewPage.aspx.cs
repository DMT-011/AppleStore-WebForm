using DataBase;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Management;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminProductViewPage : System.Web.UI.Page
{
    AppleStoreDBEntities db = new AppleStoreDBEntities();

    protected void Page_Load(object sender, EventArgs e)
    {
        string queryString = Request.QueryString["idProduct"];

        // Soft delete item product
        if (queryString != null)
        {
            removeProductToTrash(Int32.Parse(queryString));
        }
       
        renderContentProduct();
    }

    public void renderContentProduct()
    {
        var productList = db.Products.Where(item => item.IsDeleted == false);

        RenderProductBlock.DataSource = productList.ToList();
        RenderProductBlock.DataBind();
    }


    public string getImageMainByID(int idProduct)
    {
        var imageItem = db.Images.Where(item => item.isImageMain == true && item.ProductID == idProduct).FirstOrDefault();
        var resultImage = "";

        if (imageItem != null)
        {
            string base64Image = Convert.ToBase64String(imageItem.Images);

            resultImage = "data:image/jpeg;base64," + base64Image;
        }

        return resultImage;
    }

    public void removeProductToTrash(int idProduct)
    {
        var productItem = db.Products.Where(item => item.ProductID == idProduct)
            .FirstOrDefault();

        if (productItem != null)
        {
            productItem.IsDeleted = true;
            db.SaveChanges();
        }

    }

    public string getCategoryNameById (int categoryProductID)
    {
        var categoryItem = db.Categories.SingleOrDefault(item => item.CategoryID == categoryProductID);
        string result = "";

        if (categoryItem != null) {
           result = categoryItem.CategoryName;
        }

        return result;
    }

    public string countItemDeleted()
    {
        var productItemDeleted = db.Products.Where(item => item.IsDeleted == true).Count();
        string result = "";

        if (productItemDeleted > 0) {
            result = $"({productItemDeleted.ToString()})";
        }
        return result;
    }
}