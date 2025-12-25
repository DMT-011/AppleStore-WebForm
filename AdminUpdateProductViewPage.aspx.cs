using DataBase;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminUpdateProductViewPage : System.Web.UI.Page
{
    AppleStoreDBEntities db = new AppleStoreDBEntities();

    protected void Page_Load(object sender, EventArgs e)
    {
        string queryString = Request.QueryString["productID"];

        if (queryString != null)
        {
            int idProduct = Int32.Parse(queryString);

            if (!IsPostBack)
            {
                //Render category
                renderCategorySelect();
                categoryProduct.Items.Insert(0, new ListItem("[Chọn loại sản phẩm]", "0"));

                renderDataProductView(idProduct);
            }
        } else
        {
            Response.Redirect("AdminProductViewPage.aspx");
        }
       
    }

    public void updateProuduct(int idProduct)
    {
        var productItem = db.Products.SingleOrDefault(item => item.ProductID == idProduct);

        if (productItem != null) {

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
            productItem.UpdateAt = DateTime.Now;

            db.SaveChanges();

            // Check file exits , when file exits update reload image
            checkFileUploadExit(productItem.ProductID);

            Response.Redirect("AdminProductViewPage.aspx");

        }
    }

    private void checkFileUploadExit(int idProduct)
    {
        if (uploadImageMain.HasFile)
        {
            updateImageProduct( idProduct, uploadImageMain, true, 1);
        }

        if(uploadImageSub1.HasFile)
        {
            updateImageProduct(idProduct, uploadImageSub1, false, 2);
        }
       
        if (uploadImageSub2.HasFile)
        {
            updateImageProduct(idProduct, uploadImageSub2, false, 3);
        }
       
        if (uploadImageSub3.HasFile)
        {
            updateImageProduct(idProduct, uploadImageSub3, false, 4);
        }
    }

    public void updateImageProduct(int productID, FileUpload uploadImage, bool isMainImage, int index)
    {
        var imageItem = db.Images.Where(
            item => item.ProductID == productID
         && item.indexImage == index).FirstOrDefault();

        imageItem.Images = convertImageToBinary(uploadImage);
        imageItem.isImageMain = isMainImage;
        
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

    private void renderCategorySelect()
    {
        var categorys = db.Categories;
        categoryProduct.DataSource = categorys.ToList();
        categoryProduct.DataTextField = "CategoryName";
        categoryProduct.DataValueField = "CategoryID";
        categoryProduct.DataBind();
    }

    public void renderDataProductView(int idProduct)
    {
        var productItem = db.Products.SingleOrDefault(item => item.ProductID == idProduct);
        var imageItems = db.Images.Where(item => item.ProductID == idProduct);
        

        if (productItem != null) {

            nameProduct.Value = productItem.ProductName;
            productDescContent.Value = Server.HtmlDecode(productItem.ProductDesc);
            productDetailContent.Value = Server.HtmlDecode(productItem.ProductDetail);
            productQuantity.Value = Convert.ToString(productItem.ProductQuantity);
            productPrice.Value = Convert.ToString(productItem.ProductPrice);
            productPricePromotion.Value = Convert.ToString(productItem.ProductPromotionPrice);
            productStatus.SelectedValue = Convert.ToString(productItem.IsDisplay);
            productHasPromotion.SelectedValue = Convert.ToString(productItem.IsDiscount);
            categoryProduct.SelectedValue = Convert.ToString(productItem.CategoryID);

        }


    }

    public string GetImageData(int idProduct, int index)
    {
        var imageItems = db.Images.Where(item => item.ProductID == idProduct).ToList();

        string resultValue = "";

        if (imageItems != null)
        {
            string base64Image = Convert.ToBase64String(imageItems[index].Images);

            resultValue = "data:image/jpeg;base64," + base64Image;
        }

        return resultValue;
    }

    protected void updateProductBtn_Click(object sender, EventArgs e) {
        updateProuduct(Int32.Parse(Request.QueryString["productID"]));
    }
}