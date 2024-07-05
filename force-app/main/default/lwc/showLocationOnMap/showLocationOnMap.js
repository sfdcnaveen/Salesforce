import { LightningElement } from "lwc";
// import { api,wire } from "lwc";
// import { getRecord } from "lightning/uiRecordApi";
import { createRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
// import { getFieldValue } from "lightning/uiRecordApi";
// import START_LOCATION from "@salesforce/schema/Locattion__c.Start_Location__c";
// import END_LOCATION from "@salesforce/schema/Locattion__c.End_Location__c";
// let FIELDS = [START_LOCATION, END_LOCATION];

export default class GeoLocation extends LightningElement {
  latitudes;
  longitudes;
  mapMarkers = [];
  zoomLevel = "1";
  title = "";
  handleTitle(e) {
    this.title = e.target.value;
  }
  handelStart() {
    let currentDate = new Date().toJSON().slice(0, 10);
    let CurrentDateAndTime = new Date().toJSON();
    console.log(currentDate);
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((position) => {
        let latitude = position.coords.latitude;
        let longtitude = position.coords.longitude;
        this.latitudes = latitude;
        this.longitudes = longtitude;
        // console.log("latitude", latitudes);
        // console.log("longtitude", longitudes);
      });
    }
    // eslint-disable-next-line @lwc/lwc/no-async-operation
    setTimeout(() => {
      const locationfield = {
        Start_Location_Longitude_s: this.latitudes,
        Start_Location_Latitude_s: this.longitudes,
        Work_Date__c: currentDate,
        Work_Date_And_Time__c: CurrentDateAndTime,
        Location_Title__c: this.title
      };
      const accountRecordDetails = {
        apiName: "Location__c",
        fields: locationfield
      };

      this.mapMarkers = [
        {
          location: {
            Latitude: this.latitudes,
            Longitude: this.longitudes
          }
        }
      ];
      this.zoomLevel = "4";
      console.log("Title-->", this.title);

      createRecord(accountRecordDetails)
        .then((x) => {
          console.log(x);
          const event = new ShowToastEvent({
            title: "Location Saved",
            message: "Your current location saved.",
            variant: "success"
          });
          this.dispatchEvent(event);
          console.log("Executing");
        })
        .catch((err) => {
          console.log(JSON.stringify(err));
          const event = new ShowToastEvent({
            title: "Location Can Not Save",
            message: "Your current location can not save.",
            variant: "error"
          });
          this.dispatchEvent(event);
          console.log("Executing with error");
        });
    }, 5000);
  }
}
