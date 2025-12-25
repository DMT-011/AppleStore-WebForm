const nivoControls = document.querySelectorAll(".nivo-control");

// Slide
$("#main-slider").nivoSlider({
  effect: "random", 
  animSpeed: 600, 
  pauseTime: 4000,
  startSlide: 0,
  directionNav: false, 
  controlNav: true, 
  manualAdvance: true, 
});


// Carouse 
$('.brand-carousel').owlCarousel({
  item: 5,
  loop: true,
  mouseDrag: true,
  nav: false,
  autoWidth: true,
  margin: 32,
  dots: false,
  // navContainer: ".nav-carouse-controls",
  navText: [
    "<i class=\"bi icon-controls bi-chevron-left\"></i>",
    "<i class=\"bi icon-controls bi-chevron-right\"></i>"
  ],
  responsive: {
    1000: {
      items: 5
    }
  },
  autoplay: true,
  autoplayTimeout: 2200,
  autoplayHoverPause: true,
});



// Click item to link assign on sidebar
const listItemSidebar = document.querySelectorAll(".single-product-item");

listItemSidebar.forEach(itemSidebar => {
    itemSidebar.addEventListener("click", function() {
      const itemSidebarLink = itemSidebar.querySelector(".sidebar-product-link").href;

      if (itemSidebarLink != null) {
        location.href = itemSidebarLink;
      }
     
    });
});


// Click item to link assign on product 
const listProducts = document.querySelectorAll(".product-item");

listProducts.forEach(productItem => {
    productItem.addEventListener("click", function( ) {
      const itemProductLink = productItem.querySelector(".product-link").href;

      if (itemProductLink != null) {
        location.href = itemProductLink;
      }
    });
});


const totalBlock = document.querySelector(".total-price-block");
const shoppingCartElement = document.querySelector(".shopping-cart");
const cartBlock = document.querySelector(".cart-product-list");



shoppingCartElement.addEventListener("mouseover", function() {
  const possitionTotalBlock = cartBlock.offsetHeight + 53;
  totalBlock.style.top = possitionTotalBlock + "px";
});


// Carousel list product
const nextBtnProducts = document.querySelectorAll(".product-carousel-nav .product-next-btn");
const prevBtnProducts = document.querySelectorAll(".product-carousel-nav .product-prev-btn");

const productListCarousels = document.querySelectorAll(".product-carousel:not(.product-max-4)");

const productListNews = document.querySelector(".product-max-4");
const productNewItems = productListNews.querySelectorAll(".col-3");

let currentIndex = 0;

// Show next to element when click next or prev
function updateCarousel(itemProduct, productListCarousel) {
    const itemWidth = itemProduct[0].offsetWidth;
    productListCarousel.style.transform = `translateX(${-currentIndex * itemWidth}px)`;
}


// When quantity product item > 4 show controls carousel 
if (productNewItems.length > 4) {
    const productControls = productListNews.parentElement.querySelector(".product-carousel-nav");

    productControls.style.display = "flex";
}

// When quantity product item > 5 show controls carousel 
productListCarousels.forEach((item, index) => {
    const itemProducts = item.querySelectorAll(".col-2-4");
    const parentProduct = itemProducts[index].parentElement;

    if (itemProducts.length > 5) {
        const productControls = parentProduct.previousElementSibling.querySelector(".product-carousel-nav");
        productControls.style.display = "flex";
    }

})

// Next btn when click next to item
nextBtnProducts.forEach(nextBtn => {
    nextBtn.addEventListener("click", function () {
        currentIndex++;

        // Case product list top
        try {
            const productListNew = this.parentElement.parentElement.nextElementSibling.closest(".product-max-4")
            const productItemsNew = productListNew.querySelectorAll(".col-3");

            if (productListNew) {
                if (currentIndex >= productItemsNew.length - 3) {
                    currentIndex = 0;
                }

                updateCarousel(productItemsNew, productListNew);
            }

        } catch (error) {

            const productList = this.parentElement.parentElement.nextElementSibling;
            const productItems = productList.querySelectorAll(".col-2-4");

            if (currentIndex >= productItems.length - 4) {
                currentIndex = 0;
            }

            updateCarousel(productItems, productList);
        }

    })
});

// Prev btn when click prev to item
prevBtnProducts.forEach(prevBtn => {
    prevBtn.addEventListener("click", function () {

        currentIndex--;

        if (currentIndex < 0) {
            currentIndex = 0;
        }

        // Case product list top
        try {

            const productListNew = this.parentElement.parentElement.nextElementSibling.closest(".product-max-4")
            const productItemsNew = productListNew.querySelectorAll(".col-3");

            updateCarousel(productItemsNew, productListNew);

        } catch (error) {
            const productList = this.parentElement.parentElement.nextElementSibling;
            const productItems = productList.querySelectorAll(".col-2-4");

            updateCarousel(productItems, productList);
        }

    });
});


