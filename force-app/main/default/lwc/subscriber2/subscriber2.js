import { LightningElement,wire } from 'lwc';
import pubsub from 'c/pubsub';
import {CurrentPageReference} from 'lightning/navigation';


export default class Subscriber2 extends LightningElement {
    message 
    @wire(CurrentPageReference)
    pageRef
    connectedCallback(){
        this.callSubscriber();
    }  
    disconnectedCallback(){
        pubsub.unregisterAllListeners(this);
    }
    callSubscriber(){
        pubsub.registerListener('textData2', (message)=>{this.message=message},this)
    }

}