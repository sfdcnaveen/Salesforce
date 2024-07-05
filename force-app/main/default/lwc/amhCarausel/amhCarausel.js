import { LightningElement, wire, track, api } from "lwc";
import getCarouselList from "@salesforce/apex/AmhCarousel.getCarouselList";
import { NavigationMixin } from "lightning/navigation";

export default class AmhCarausel extends NavigationMixin(LightningElement) {
  @track List;
  imageUrls;
  activeIndex = 0;
  @api intervalId;
  isPlaying = true;
  @track navigationType = "standard__webPage";
  space = " ";
  underScore = "_";
  zero = 0;
  errorMessage = "Failed to retrieve image URLs";
  error;
  clicked = "clicked";
  roundButtonClass = ".round-button";
  nTwoFifty = 250;
  @api nThreeThousand = 3000;
  isFalse = false;
  one = 1;

  @api
  getCardsBySection() {
    return {
      one: this.one,
      isFalse: this.isFalse,
      error: this.error,
      nTwoFifty: this.nTwoFifty,
      nThreeThousand: this.nThreeThousand,
      clicked: this.clicked,
      roundButtonClass: this.roundButtonClass,
      errorMessage: this.errorMessage,
      zero: this.zero,
      navigationType: this.navigationType,
      underScore: this.underScore,
      space: this.space,
      isPlaying: this.isPlaying,
      intervalId: this.intervalId,
      activeIndex: this.activeIndex,
      imageUrls: this.imageUrls,
      List: this.List,
      playPauseLabel: this.playPauseLabel,
      currentImageUrl: this.currentImageUrl,
      currentImageTitle: this.currentImageTitle,
      currentImageCompany: this.currentImageCompany,
      currentImageAddress: this.currentImageAddress,
      CurrentSlideButtonLabel: this.CurrentSlideButtonLabel,
      currentImageLink: this.currentImageLink
    };
  }

  @wire(getCarouselList)
  caraouselData({ error, data }) {
    if (error) {
      this.error = this.errorMessage + error;
      this.imageUrls = [];
    } else if (data) {
      this.List = data;
      this.startAutoSwipe();
      this.imageUrls = data.map((x) => {
        return {
          Images__c: x.Image_Source__c,
          Title__c: x.Title__c,
          Company__c: x.SubTitle__c,
          Address__c: x.Description__c,
          button_label_text__c: x.Button__c,
          UniqueId: x.Name?.replaceAll(this.space, this.underScore),
          UrlLink: x.Link_Resource__c
        };
      });
    }
  }

  get currentImageUrl() {
    return this.imageUrls && this.imageUrls.length > 0
      ? this.imageUrls[this.activeIndex].Images__c
      : null;
  }

  get currentImageLink() {
    return this.imageUrls && this.imageUrls.length > 0
      ? this.imageUrls[this.activeIndex].UrlLink
      : null;
  }

  get currentImageTitle() {
    return this.imageUrls && this.imageUrls.length > 0
      ? this.imageUrls[this.activeIndex].Title__c
      : null;
  }

  get currentImageCompany() {
    return this.imageUrls && this.imageUrls.length > 0
      ? this.imageUrls[this.activeIndex].Company__c
      : null;
  }

  get currentImageAddress() {
    return this.imageUrls && this.imageUrls.length > 0
      ? this.imageUrls[this.activeIndex].Address__c
      : null;
  }

  get CurrentSlideButtonLabel() {
    return this.imageUrls && this.imageUrls.length > this.zero
      ? this.imageUrls[this.activeIndex].button_label_text__c
      : null;
  }
  handleSlideButton(event) {
    const url = event.target.dataset.url;
    let attributes = {};
    attributes.type = this.navigationType;
    attributes.attributes = {};
    attributes.attributes.url = url;
    this[NavigationMixin.Navigate](attributes, this.isFalse);
  }
  handleButtonClick(event) {
    this.activeIndex = parseInt(event.target.dataset.index, 10);

    const buttons = this.template.querySelectorAll(this.roundButtonClass);
    for (let button of buttons) {
      button.classList.remove(this.clicked);
    }
    event.target.classList.add(this.clicked);
  }

  startAutoSwipe() {
    this.isPlaying = true;
    this.dispatchEvent(new CustomEvent("autoSwipe"));
  }

  handleAutoSwipe() {
    if (!this.isPlaying) {
      return;
    }

    this.activeIndex =
      this.imageUrls.length - this.one > this.activeIndex
        ? this.activeIndex + this.one
        : this.zero;
    const buttons = this.template.querySelectorAll(this.roundButtonClass);
    buttons.forEach((button, index) => {
      if (index !== this.activeIndex) {
        button.classList.remove(this.clicked);
      } else {
        button.classList.add(this.clicked);
        // eslint-disable-next-line @lwc/lwc/no-async-operation
        setTimeout(() => {
          button.classList.remove(this.clicked);
        }, this.nThreeThousand);
      }
    });

    this.dispatchEvent(new CustomEvent("autoSwipe"));
  }

  stopAutoSwipe() {
    clearInterval(this.intervalId);
  }

  get playPauseLabel() {
    return this.isPlaying ? "❚❚" : "▶";
  }

  toggleAutoSwipe() {
    if (!this.isPlaying) {
      this.startAutoSwipe();
    } else {
      this.stopAutoSwipe();
    }
    this.isPlaying = !this.isPlaying;
  }
}
