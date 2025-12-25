using DataBase;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminDeleteProductViewPage : System.Web.UI.Page
{
    AppleStoreDBEntities db = new AppleStoreDBEntities();

    protected void Page_Load(object sender, EventArgs e)
    {
        string queryString = Request.QueryString["idProduct"];
        string queryStringDelete = Request.QueryString["idProductDelete"];

        if (queryString != null )
        {
            restoreProductItem(Convert.ToInt32(queryString));
        }

        // Delete (real) product on database
        if (queryStringDelete != null)
        {
            deleteProduct(Convert.ToInt32(queryStringDelete));
        }

        renderProductDeleted();
    }

    // Render product deleted in trash
    private void renderProductDeleted()
    {
        var productItemDeleted = db.Products.Where(item => item.IsDeleted == true);

        if (productItemDeleted != null)
        {
            RenderProductDeletedBlock.DataSource = productItemDeleted.ToList();
            RenderProductDeletedBlock.DataBind();
        }    
    }

    // Restore Item product when click btn restore
    private void restoreProductItem(int idProduct)
    {
        var productItemRestore = db.Products.SingleOrDefault(item => item.ProductID == idProduct);

        if (productItemRestore != null)
        {
            productItemRestore.IsDeleted = false;
            db.SaveChanges();
        }
    }

    public void deleteProduct(int idProduct)
    {
        var productItem = db.Products.SingleOrDefault(item => item.ProductID == idProduct);
        var imageItems = db.Images.Where(item => item.ProductID == idProduct);

        if (productItem != null)
        {
            db.Products.Remove(productItem);
            db.Images.RemoveRange(imageItems);
            db.SaveChanges();
        }

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

    public string getCategoryNameById (int categoryProductID)
    {
        var categoryItem = db.Categories.SingleOrDefault(item => item.CategoryID == categoryProductID);
        string result = "";

        if (categoryItem != null)
        {
            result = categoryItem.CategoryName;
        }

        return result;
    }

}