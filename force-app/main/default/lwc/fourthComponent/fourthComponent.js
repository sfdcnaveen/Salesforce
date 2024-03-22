import { LightningElement } from 'lwc';

export default class FourthComponent extends LightningElement {
    value = ['HariTeja'];
    get options() {
        return [
            { label: 'Naveen', value: 'Naveen' },
            { label: 'Nageswari', value: 'Nageswari' },
            { label: 'HariTeja', value: 'HariTeja' },
            { label: 'Srinivasulu', value: 'Srinivasulu' },
            { label: 'Lakshmi', value: 'Lakshmi' },
            { label: 'Prasanna', value: 'Prasanna' },
            { label: 'SaiKrupa', value: 'SaiKrupa'}
        ];
    }
    handleInputChange(event){
        this.value = event.target.value;
    }
}