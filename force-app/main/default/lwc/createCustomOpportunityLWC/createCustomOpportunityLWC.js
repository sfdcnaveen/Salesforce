import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import OPP_OBJECT from "@salesforce/schema/Opportunitiescustom__c";
import ACCOUNT_FIELD from "@salesforce/schema/Opportunitiescustom__c.Account_Name__c";
import EMAIL_FIELD from "@salesforce/schema/Opportunitiescustom__c.Email__c";

export default class AccountContactOpportunity extends LightningElement {
  objectName = OPP_OBJECT;
  fieldList = [ACCOUNT_FIELD, EMAIL_FIELD];
  successhandler(event) {
    console.log(event.detail.id);
    // eslint-disable-next-line no-new
    new ShowToastEvent({
      title: "Opportunity Created",
      message: "Record ID: " + event.detail.id,
      variant: "success"
    });
  }
}
