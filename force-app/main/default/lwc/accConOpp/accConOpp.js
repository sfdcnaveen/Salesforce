import { LightningElement, track } from "lwc";
import createAccount from "@salesforce/apex/AccConOppAuraEnabled.createAccount";
import createContact from "@salesforce/apex/AccConOppAuraEnabled.createContact";
import createOpportunity from "@salesforce/apex/AccConOppAuraEnabled.createOpportunity";
import { NavigationMixin } from "lightning/navigation";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class AccConOpp extends NavigationMixin(LightningElement) {
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

  handleFieldChange(event) {
    const fieldName = event.target.name;
    this[fieldName] = event.target.value;
  }

  handleSave() {
    createAccount({
      Name: this.accountName,
      Phone: this.accphone,
      Website: this.accweb,
      Industry: this.accind,
      Description: this.accrdesc,
      Rating: this.accrating
    })
      .then((accountId) => {
        this.newAccountId = accountId;
        return createContact({
          FirstName: this.firstName,
          LastName: this.lastName,
          Phone: this.conPhone,
          AccountId: accountId,
          Title: this.contitle,
          Email: this.conemail
        });
      })
      .then((contactId) => {
        return createOpportunity({
          Name: this.oppname,
          StageName: this.oppstagename,
          CloseDate: this.oppclosedate,
          ContactId: contactId,
          AccountId: this.newAccountId
        });
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
        this.showToast("Error", error.body.message, "Error");
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
