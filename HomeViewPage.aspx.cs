using DataBase;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Entity;

public partial class HomeViewPage : System.Web.UI.Page
{
    AppleStoreDBEntities db = new AppleStoreDBEntities();

    protected void Page_Load(object sender, EventArgs e)
    {
        renderProductView();
    }

    private void renderProductView()
    {
        var groupedProducts = db.Products
            .GroupBy(item => item.CategoryID)
            .Select(group => new
            {
                CategoryID = group.Key,
                Products = group.Where(item => item.IsDeleted == false).ToList()
            }).ToList();

        RenderProductBlock.DataSource = groupedProducts;
        RenderProductBlock.DataBind();
    }

    public string getNameCategoryByID (int idCategory)
    {
        var categorys = db.Categories.SingleOrDefault(
            item => item.CategoryID == idCategory
            );

        return $"{categorys.CategoryName}";
    }

    public string GetImageData(int idProduct)
    {
        var imageItem = db.Images.SingleOrDefault(
            item => item.ProductID == idProduct 
            && item.isImageMain == true );

        string resultValue = "";

        if (imageItem != null)
        {
            string base64Image = Convert.ToBase64String(imageItem.Images);

            resultValue = "data:image/jpeg;base64," + base64Image;
        }

        return resultValue;
    }
}