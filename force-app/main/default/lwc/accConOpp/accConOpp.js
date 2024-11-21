import { LightningElement, track } from "lwc";
import createAccount from "@salesforce/apex/AccConOppAuraEnabled.createAccount";
import createContact from "@salesforce/apex/AccConOppAuraEnabled.createContact";
import createOpportunity from "@salesforce/apex/AccConOppAuraEnabled.createOpportunity";
import { NavigationMixin } from "lightning/navigation";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class AccConOpp extends NavigationMixin(LightningElement) {
  // To create Acc, Con, Opp from one component

  newAccountId;
  @track accountName;
  @track accphone;
  @track accweb;
  @track accind;
  @track accrdesc;
  @track accrating;
  @track firstName;
  @track lastName;
  @track contitle;
  @track conPhone;
  @track conemail;
  @track oppname;
  @track oppstagename;
  @track oppclosedate;
  @track oppemail;

  @track accountData = {};
  @track contactData = {};
  @track opportunityData = {};

  handleFieldChange(event) {
    const fieldName = event.target.name;
    const objectType = fieldName.split('_')[0];
    const field = fieldName.split('_')[1];

    if (objectType === 'acc') {
      this.accountData[field] = event.target.value;
    } else if (objectType === 'con') {
      this.contactData[field] = event.target.value;
    } else if (objectType === 'opp') {
      this.opportunityData[field] = event.target.value;
    }
  }

  handleSave() {
    createAccount(this.accountData)
      .then((accountId) => {
        this.newAccountId = accountId;
        this.contactData.AccountId = accountId;
        return createContact(this.contactData);
      })
      .then((contactId) => {
        this.opportunityData.AccountId = this.newAccountId;
        this.opportunityData.ContactId = contactId;
        return createOpportunity(this.opportunityData);
      })
      .then(() => {
        this.showToast(
          "Success",
          "Account, Contact and Opportunity Created Successfully",
          "success"
        );
        this.navigateAfterSave();
      })
      .catch((error) => {
        this.showToast("Error", error.body.message, "error");
      });
  }

  handleCancel() {
    const cancelForm = this.template.querySelectorAll("lightning-input-field");
    cancelForm.forEach((field) => {
      field.reset();
      field.messageWhenValueMissing = "";
      field.reportValidity();
    });
    this.showToast(
      "Information",
      "Account, Contact and Opportunity creation cancelled",
      "info"
    );
  }

  showToast(title, message, variant) {
    const confirmationMsg = new ShowToastEvent({
      title: title,
      message: message,
      variant: variant
    });
    this.dispatchEvent(confirmationMsg);
  }

  navigateAfterSave() {
    if (this.newAccountId) {
      this[NavigationMixin.Navigate]({
        type: "standard__recordPage",
        attributes: {
          recordId: this.newAccountId,
          objectApiName: "Account",
          actionName: "view"
        }
      });
    }
  }
}
