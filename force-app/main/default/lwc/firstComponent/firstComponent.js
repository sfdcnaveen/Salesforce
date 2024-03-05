import { LightningElement, track } from "lwc";

export default class FirstComponent extends LightningElement {
  @track welcomeNote = "Hello, Good Morning!";
  @track newText = "";
  @track items = [];
  students = ['HariTeja','Naveen','Nageswari','Lakshmi','Srinivasulu'];
  handleInputChange(event) {
    this.welcomeNote = event.target.value;
    this.newText = event.target.value;
  }
  handleAddClick() {
    if (this.newText) {
      //push method adds the element into the array
      this.items.push(this.newText);
      this.newText = ""; // Clear the input field
    }
  }
  handleRemoveClick() {
    //pop method removes the last element of the array
    this.items.pop();
  }
}
