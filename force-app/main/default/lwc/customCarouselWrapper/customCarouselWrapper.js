import { LightningElement } from "lwc";
import CAROUSEL_IMAGES from "@salesforce/resourceUrl/carousel";

import CAROUSEL_IMAGE1 from "@salesforce/resourceUrl/carousel1";
import CAROUSEL_IMAGE2 from "@salesforce/resourceUrl/carousel2";
import CAROUSEL_IMAGE3 from "@salesforce/resourceUrl/carousel3";

export default class CustomCarouselWrapper extends LightningElement {
  slides = [
    {
      image: `${CAROUSEL_IMAGE1}`,
      heading: "Caption one",
      description: "You can add description of first slide here"
    },
    {
      image: `${CAROUSEL_IMAGE2}`,
      heading: "Caption Two",
      description: "You can add description of second slide here"
    },
    {
      image: `${CAROUSEL_IMAGE3}`,
      heading: "Caption Three",
      description: "You can add description of third slide here"
    }
  ];
}
