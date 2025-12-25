// Model view large
const modalViewLarge = document.querySelector(".modal-view-large");
const btnViewLarge = document.querySelector(".view-large-btn");
const btnCloseViewLarge = document.querySelector(".modal-close");

btnViewLarge.addEventListener("click", function () {
  if (!modalViewLarge.closest(".show")) {
    modalViewLarge.classList.add("show");
  }
});

btnCloseViewLarge.addEventListener("click", function () {
  if (modalViewLarge.closest(".show")) {
    modalViewLarge.classList.remove("show");
  }
});

modalViewLarge.addEventListener("click", function (e) {
  if (e.target.closest(".modal-overlay")) {
    modalViewLarge.classList.remove("show");
  }
});

// Modal view img carousel
$(".modal-view-carousel").owlCarousel({
  item: 1,
  mouseDrag: true,
  loop: true,
  nav: true,
  autoWidth: true,
  center: true,
  rewind: true,
  navContainer: ".modal-nav-carousel",
  navText: [
    '<i class="bi icon-carousel bi-arrow-left-short"></i>',
    '<i class="bi icon-carousel bi-arrow-right-short"></i>',
  ],
  dots: true,
});

// Slide product view
$(".product-view-slide").nivoSlider({
  effect: "fade",
  slices: 15,
  animSpeed: 100,
  manualAdvance: true,
  startSlide: 0,
  directionNav: true,
  controlNavThumbs: true,
  nextText: '<i class="bi icon-nivo-control bi-arrow-right-short"></i>',
  prevText: '<i class="bi icon-nivo-control bi-arrow-left-short"></i>',
});
