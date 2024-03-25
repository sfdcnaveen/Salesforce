import { LightningElement, wire, api } from 'lwc';
import pubsub from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';


export default class SecondComponent extends LightningElement {
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
        pubsub.registerListener('secondHit',this.handleInputChange,this);
    }
    disconnectedCallback(){
        pubsub.unregisterAllListeners('secondHit',this.handleInputChange,this);
    }
    @api
    handleInputChange(event){
        this.value = event.target.value;
        console.log(this.value);
    }
}