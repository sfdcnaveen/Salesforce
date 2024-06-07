// myGeoLocationMap.js
import { LightningElement } from "lwc";
import { createRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import LOCATION_OBJECT from "@salesforce/schema/Location__c";
import START_LOCATION_FIELD from "@salesforce/schema/Location__c.Start_Location__c";
import END_LOCATION_FIELD from "@salesforce/schema/Location__c.End_Location__c";

export default class MyGeoLocationMap extends LightningElement {
  startLocation = "";
  endLocation = "";

  handleStartLocationChange(event) {
    this.startLocation = event.target.value;
  }

  handleEndLocationChange(event) {
    this.endLocation = event.target.value;
  }

  async handleSaveLocation() {
    const fields = {};
    fields[START_LOCATION_FIELD.fieldApiName] = this.startLocation;
    fields[END_LOCATION_FIELD.fieldApiName] = this.endLocation;

    const recordInput = { apiName: LOCATION_OBJECT.objectApiName, fields };

    try {
      const response = await createRecord(recordInput);
      console.log(response);
      this.showToast("Success", "Location saved successfully.", "success");
    } catch (error) {
      this.showToast("Error", "Error saving location.", "error");
      console.error(error);
    }
  }

  showToast(title, message, variant) {
    const event = new ShowToastEvent({
      title: title,
      message: message,
      variant: variant
    });
    this.dispatchEvent(event);
  }
}
