import { LightningElement } from "lwc";
//import CAROUSEL_IMAGES from "@salesforce/resourceUrl/carousel";
import CAROUSEL_IMAGE1 from "@salesforce/resourceUrl/carousel1";
import CAROUSEL_IMAGE2 from "@salesforce/resourceUrl/carousel2";
import CAROUSEL_IMAGE3 from "@salesforce/resourceUrl/carousel3";

const CARD_VISIBLE_CLASSES = "slds-show";
const CARD_HIDDEN_CLASSES = "slds-hide";

export default class CustomCarouselComponent extends LightningElement {
  slideIndex = 0;

  slides = [
    {
      image: CAROUSEL_IMAGE1
    },
    {
      image: CAROUSEL_IMAGE2
    },
    {
      image: CAROUSEL_IMAGE3
    }
  ];

  set slidesData(data) {
    this.slides = data.map((item, index) => {
      return index === 0
        ? {
            ...item,
            slideIndex: index + 1,
            cardClasses: CARD_VISIBLE_CLASSES
          }
        : {
            ...item,
            slideIndex: index + 1,
            cardClasses: CARD_HIDDEN_CLASSES
          };
    });
  }

  // currentSlide(event) {
  //   let slideIndex = Number(event.target.dataset.id);
  //   this.slideSelectionHandler(slideIndex);
  // }
  // backSlide() {
  //   let slideIndex = this.slideIndex - 1;
  //   this.slideSelectionHandler(slideIndex);
  // }
  // forwardSlide() {
  //   let slideIndex = this.slideIndex + 1;
  //   this.slideSelectionHandler(slideIndex);
  // }

  // slideSelectionHandler(id) {
  //   if (id > this.slides.length) {
  //     this.slideIndex = 1;
  //   } else if (id < 1) {
  //     this.slideIndex = this.slides.length;
  //   } else {
  //     this.slideIndex = id;
  //   }
  //   this.slides = this.slides.map((item) => {
  //     return this.slideIndex === item.slideIndex
  //       ? {
  //           ...item,
  //           cardClasses: CARD_VISIBLE_CLASSES
  //         }
  //       : {
  //           ...item,
  //           cardClasses: CARD_HIDDEN_CLASSES
  //         };
  //   });
  // }
}
