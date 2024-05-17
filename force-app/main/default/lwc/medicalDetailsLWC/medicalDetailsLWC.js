// myComponent.js
import { LightningElement, track } from "lwc";

export default class MedicalDetailsLWC extends LightningElement {
  @track selectedDate;
  @track startDate;
  @track selectedOption;
  @track otherDescription;
  @track showTextarea = true;
  @track selectedOption2;
  @track otherDescription2;
  @track showTextarea2 = true;
  @track endDate;
  @track startDate2;
  @track endDate2;
  @track formattedDate;
  @track formattedStartDate;
  @track formattedStartDate2;
  @track value = "Vibration white finger";
  @track value2 = "other";

  get options() {
    return [
      { label: "Vibration white finger", value: "Vibration white finger" },
      { label: "other", value: "other" }
    ];
  }

  get displayValue() {
    if (this.value === "other") {
      return this.otherDescription;
    }
    return this.value;
  }
  get displayValue2() {
    if (this.value2 === "other") {
      return this.otherDescription2;
    }
    return this.value2;
  }
  handleChange(event) {
    this.value = event.detail.value;
  }
  handleChange2(event) {
    this.value2 = event.detail.value;
  }

  handleDateChange(event) {
    this.selectedDate = event.target.value;
    this.formatDate();
  }

  handleComboboxChange(event) {
    this.selectedOption = event.detail.value;
    this.showTextarea = this.selectedOption === "other";
  }
  handleComboboxChange2(event) {
    this.selectedOption2 = event.detail.value;
    this.showTextarea2 = this.selectedOption2 === "other";
  }

  handleOtherDescriptionChange(event) {
    this.otherDescription = event.target.value;
  }
  handleOtherDescriptionChange2(event) {
    this.otherDescription2 = event.target.value;
  }

  handleStartDateChange(event) {
    this.startDate = event.target.value;
    this.formatStartDate();
  }

  handleEndDateChange(event) {
    this.endDate = event.target.value;
  }

  handleStartDate2Change(event) {
    this.startDate2 = event.target.value;
    this.formatStartDate2();
  }

  handleEndDate2Change(event) {
    this.endDate2 = event.target.value;
  }

  formatDate() {
    const date = new Date(this.selectedDate);
    const options = { month: "long", day: "numeric", year: "numeric" };
    this.formattedDate = date.toLocaleDateString("en-US", options);
  }

  formatStartDate() {
    const date = new Date(this.startDate);
    const options = { month: "long", day: "numeric", year: "numeric" };
    this.formattedStartDate = date.toLocaleDateString("en-US", options);
  }

  formatStartDate2() {
    const date = new Date(this.startDate2);
    const options = { month: "long", day: "numeric", year: "numeric" };
    this.formattedStartDate2 = date.toLocaleDateString("en-US", options);
  }
}
