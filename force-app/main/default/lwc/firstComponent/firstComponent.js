import { LightningElement, track, wire } from "lwc";
import pubsub from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation'


export default class FirstComponent extends LightningElement {
  @track welcomeNote = "Hello, Good Morning!";
  //@track showRed = false;
  @track newText = "";
  @track items = [];
  @track checkboxSelected = false;
  students = ['HariTeja','Naveen','Nageswari','Lakshmi','Srinivasulu'];
  
  @wire(CurrentPageReference)
  pageRef;

  get showRed(){
    return this.welcomeNote === undefined || this.welcomeNote === null || this.welcomeNote === '' || !this.checkboxSelected;
  }
  handleInputChange(event) {
    this.welcomeNote = event.target.value;
    this.newText = event.target.value;
    //this.showRed = this.welcomeNote === undefined || this.welcomeNote === null || this.welcomeNote === '' || !this.checkboxSelected;
    //pubsub.fireEvent(this.pageRef,'firstHit',this.welcomeNote);
    pubsub.fireEvent(this.pageRef,'secondHit',this.welcomeNote);

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
  handleChange(event){
    this.checkboxSelected = event.target.checked;
    console.log(this.checkboxSelected);
    //this.showRed = this.welcomeNote === undefined || this.welcomeNote === null || this.welcomeNote === '' || !this.checkboxSelected;
  }
}
