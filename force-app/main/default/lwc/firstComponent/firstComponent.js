import { LightningElement, track } from 'lwc';

export default class FirstComponent extends LightningElement {
    @track welcomeNote = "Hello, Good Morning!";
    handleInputChange(event){
        this.welcomeNote = event.target.value;
    }
}