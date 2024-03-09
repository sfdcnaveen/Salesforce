import { LightningElement, api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api firstLabel;
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
    @api
    valuesFromParent(fName) {
        this.value = fName.split(',');
    }
}