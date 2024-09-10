import { LightningElement } from 'lwc';
import getPicture from '@salesforce/apex/PixabayAPI.getPicture';

export default class PixabayAPI extends LightningElement {
    search;
    imageURL;
    handleonchange() {
        this.search = event.target.value;

    }
    buttonClick() {
        getPicture({ search: this.search, }).then((response) => {
            console.log("###Response :" + response);
            // let parseData = JSON.parse(response);
            // this.imageURL = parseData
        })
            .catch((error) => {
                console.log('##Error :' + JSON.stringify(error));

            });

    }
}