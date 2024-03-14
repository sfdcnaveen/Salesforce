import { LightningElement } from 'lwc';

export default class CustomCheckboxGroup extends LightningElement {
    
    value = ['HariTeja'];
    options = [
        { label: 'Naveen', value: 'Naveen' },
        { label: 'Nageswari', value: 'Nageswari' },
        { label: 'HariTeja', value: 'HariTeja' },
        { label: 'Srinivasulu', value: 'Srinivasulu' },
        { label: 'Lakshmi', value: 'Lakshmi' },
        { label: 'Prasanna', value: 'Prasanna' },
        { label: 'SaiKrupa', value: 'SaiKrupa'}
    ];
    handleInput(event){
        let fName = event.target.value;
        this.value = fName.split(',');
    }
}