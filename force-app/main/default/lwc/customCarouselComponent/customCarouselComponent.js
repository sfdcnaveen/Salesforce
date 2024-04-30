import { LightningElement, api, wire } from "lwc";
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import { NavigationMixin } from "lightning/navigation";
import IMAGE1 from "@salesforce/schema/Images__c.image1__c";
import IMAGE2 from "@salesforce/schema/Images__c.image2__c";
import IMAGE3 from "@salesforce/schema/Images__c.image3__c";

const FIELDS = [IMAGE1, IMAGE2, IMAGE3];

export default class CustomCarouselComponent extends NavigationMixin(
  LightningElement
) {
  @api recordId; // The ID of the Images__c record
  images;

  @wire(getRecord, { recordId: "$recordId", fields: FIELDS })
  wiredImages({ error, data }) {
    if (data) {
      //this.images = data;
      this.images = getFieldValue(data, FIELDS);
      console.log("data", JSON.stringify(data));
    } else if (error) {
      console.error("Error loading record data:", error);
      console.log("error", JSON.stringify(error));
    }
  }

  get imageUrls() {
    return [
      this.images?.data?.IMAGE1?.value,
      this.images?.data?.IMAGE2?.value,
      this.images?.data?.IMAGE3?.value
    ];
  }

  goToPreviousSlide() {
    const carousel = this.template.querySelector(".carousel");
    const itemWidth = carousel.querySelector(".carousel-item").clientWidth;
    carousel.style.transform = `translateX(${itemWidth}px)`;
  }

  goToNextSlide() {
    const carousel = this.template.querySelector(".carousel");
    const itemWidth = carousel.querySelector(".carousel-item").clientWidth;
    carousel.style.transform = `translateX(-${itemWidth}px)`;
  }
}
