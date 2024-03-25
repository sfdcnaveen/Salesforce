import { LightningElement,api } from 'lwc';

export default class P2cChildAlertComponent extends LightningElement {
    @api message;
    @api cardHeading;
    @api number;
    @api isValid; //default value is true 
}