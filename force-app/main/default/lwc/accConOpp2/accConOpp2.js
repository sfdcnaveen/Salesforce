import { LightningElement, track } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import createAccountContactOpportunity from "@salesforce/apex/AccConOpp2.createAccountContactOpportunity";

export default class AccConOpp2 extends LightningElement {
  @track account = {};
  @track contact = {};
  @track opportunity = {};
  @track stageOptions = [
    { label: "Qualification", value: "Qualification" },
    { label: "Needs Analysis", value: "Needs Analysis" },
    { label: "Value Proposition", value: "Value Proposition" }
    // Add more stages as needed
  ];

  handleInputChange(event) {
    const field = event.target.dataset.id;
    const value = event.target.value;

    if (field.startsWith("account")) {
      this.account[field.replace("account", "")] = value;
    } else if (field.startsWith("contact")) {
      this.contact[field.replace("contact", "")] = value;
    } else if (field.startsWith("opportunity")) {
      this.opportunity[field.replace("opportunity", "")] = value;
    }
  }

  handleSave() {
    createAccountContactOpportunity({
      account: this.account,
      contact: this.contact,
      opportunity: this.opportunity
    })
      .then(() => {
        this.showToast(
          "Success",
          "Account, Contact, and Opportunity created successfully",
          "success"
        );
        // Clear the fields after successful save
        this.template
          .querySelectorAll("lightning-input")
          .forEach((input) => (input.value = ""));
        this.template
          .querySelectorAll("lightning-combobox")
          .forEach((combobox) => (combobox.value = ""));
      })
      .catch((error) => {
        this.showToast("Error", error.body.message, "error");
      });
  }

  showToast(title, message, variant) {
    const evt = new ShowToastEvent({
      title: title,
      message: message,
      variant: variant
    });
    this.dispatchEvent(evt);
  }
}
