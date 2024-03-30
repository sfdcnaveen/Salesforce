import { LightningElement, wire } from "lwc";
import pubsub from "c/pubsub";
import { CurrentPageReference } from "lightning/navigation";
export default class Subscriber1 extends LightningElement {
  message;
  value = ["HariTeja"];
  @wire(CurrentPageReference)
  pageRef;
  get options() {
    return [
      { label: "Naveen", value: "Naveen" },
      { label: "Nageswari", value: "Nageswari" },
      { label: "HariTeja", value: "HariTeja" },
      { label: "Srinivasulu", value: "Srinivasulu" },
      { label: "Lakshmi", value: "Lakshmi" },
      { label: "Prasanna", value: "Prasanna" },
      { label: "SaiKrupa", value: "SaiKrupa" }
    ];
  }
  connectedCallback() {
    this.callSubscriber();
  }
  disconnectedCallback() {
    pubsub.unregisterAllListeners(this);
  }
  callSubscriber() {
    pubsub.registerListener(
      "textData1",
      (message) => {
        this.message = message;
      },
      this
    );
  }
}
