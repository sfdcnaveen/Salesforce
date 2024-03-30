import { LightningElement, wire, track } from "lwc";
import pubsub from "c/pubsub";
import { CurrentPageReference } from "lightning/navigation";
export default class Publisher extends LightningElement {
  @track message1;
  @track message2;
  @track message3;
  @track textval;

  @wire(CurrentPageReference)
  pageRef;

  inputHandler(event) {
    this.textval = event.target.value;
    if (this.textval.includes("|")) {
      this.textval = this.textval.substring(this.textval.lastIndexOf("|") + 1);
    }
    if (this.textval.startsWith("first:")) {
      this.message1 = this.textval.substring(6);
    } else if (this.textval.startsWith("second:")) {
      this.message2 = this.textval.substring(7);
    } else if (this.textval.startsWith("third:")) {
      this.message3 = this.textval.substring(6);
    }
  }

  publishHandler() {
    if (this.message1 != null) {
      pubsub.fireEvent(this.pageRef, "textData1", this.message1);
    }
    if (this.message2 != null) {
      pubsub.fireEvent(this.pageRef, "textData2", this.message2);
    }
    if (this.message3 != null) {
      pubsub.fireEvent(this.pageRef, "textData3", this.message3);
    }
  }
}
