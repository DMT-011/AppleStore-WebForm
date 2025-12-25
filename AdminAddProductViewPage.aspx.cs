using DataBase;
using System;
using System.Collections.Generic;
using System.Drawing.Printing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.DynamicData;
using System.Web.Management;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class AdminAddProductViewPage : System.Web.UI.Page
{
    private AppleStoreDBEntities db = new AppleStoreDBEntities();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            renderCategorySelect();
            categoryProduct.Items.Insert(0, new ListItem("[Chọn loại sản phẩm]", "0"));
           
        }
    }


    private void addProduct()
    {
        Product productItem = new Product();

        productItem.ProductName = nameProduct.Value;
        productItem.ProductQuantity = Convert.ToInt32(productQuantity.Value);
        productItem.ProductPrice = Convert.ToDecimal(productPrice.Value.Trim()); ;
        productItem.ProductPromotionPrice = Convert.ToDecimal(productPricePromotion.Value.Trim());
        productItem.CategoryID = Convert.ToInt32(categoryProduct.SelectedItem.Value);
        productItem.IsDisplay = Convert.ToBoolean(productStatus.SelectedItem.Value);
        productItem.IsDiscount = Convert.ToBoolean(productHasPromotion.SelectedItem.Value);

        // img , 2 desc
        productItem.ProductDesc = Server.HtmlEncode(productDescContentHidden.Text);
        productItem.ProductDetail = Server.HtmlEncode(productDetailContentHidden.Text);
        productItem.CreatedAt = DateTime.Now;



        db.Products.Add(productItem);
        db.SaveChanges();

        addImageProduct(productItem.ProductID, uploadImageMain, true, 1);
        addImageProduct(productItem.ProductID, uploadImageSub1, false, 2);
        addImageProduct(productItem.ProductID, uploadImageSub2, false, 3);
        addImageProduct(productItem.ProductID, uploadImageSub3, false, 4);

        Response.Redirect("AdminProductViewPage.aspx");
    }

    private void renderCategorySelect()
    {
        var categorys = db.Categories;
        categoryProduct.DataSource = categorys.ToList();
        categoryProduct.DataTextField = "CategoryName";
        categoryProduct.DataValueField = "CategoryID";
        categoryProduct.DataBind();
    }

    public void addImageProduct(int productID, FileUpload uploadImage, bool isMainImage , int indexImg)
    {
        var imageItem = new DataBase.Image();

        imageItem.ProductID = productID;
        imageItem.isImageMain = isMainImage;
        imageItem.Images = convertImageToBinary(uploadImage);
        imageItem.indexImage = indexImg;

        db.Images.Add(imageItem);
        db.SaveChanges();
    }

    private byte[] convertImageToBinary(FileUpload inputUpload)
    {
        byte[] imgData = null;

        using (Stream fs = inputUpload.PostedFile.InputStream)
        {
            using (BinaryReader br = new BinaryReader(fs))
            {
                imgData = br.ReadBytes((int)fs.Length);
            }
        }

        return imgData;
    }

    protected void addProductBtn_Click(object sender, EventArgs e)
    {
        addProduct();
    }


}