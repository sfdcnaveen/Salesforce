import { LightningElement, api } from 'lwc';

export default class RecordViewEditForm extends LightningElement {
    @api recordId;
    @api objectApiName;

    checkboxVal = true;
    handleChange(event) {
        this.checkboxVal = event.target.checked;
      }
}

