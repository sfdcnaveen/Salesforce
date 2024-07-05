import { LightningElement } from "lwc";

export default class GeoLocation extends LightningElement {
  lstMarkers = [];
  zoomlevel = "1";
  lat;
  lon;
  handleStartLocation() {}
  handleEndLocation() {}
  handleClick() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((position) => {
        //Get the latitude and longitude from Geolocation API
        var latitude = position.coords.latitude;
        var longitude = position.coords.longitude;
        this.lat = latitude;
        this.lon = longitude;

        //Add Latitude and Longitude to the markers list
        this.lstMarkers = [
          {
            location: {
              Latitude: latitude,
              Longitude: longitude
            },
            title: "You are here"
          }
        ];
        this.zoomlevel = "8";
      });
    }
  }
}
