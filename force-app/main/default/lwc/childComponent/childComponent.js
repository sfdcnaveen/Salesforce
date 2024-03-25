import { LightningElement, api,wire } from 'lwc';
import pubsub from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';

export default class ChildComponent extends LightningElement {
    value = ['HariTeja'];
    @wire(CurrentPageReference)
    pageRef;
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
    connectedCallback(){
        pubsub.registerListener('firstHit',this.valuesFromParent,this);
    }
    disconnectedCallback(){
        pubsub.unregisterAllListeners('firstHit',this.valuesFromParent,this);
    }
    @api
    valuesFromParent(fName) {
        this.value = fName.split(',');
    }
}