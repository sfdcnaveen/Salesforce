import { LightningElement, api, wire } from "lwc";
import { createRecord, getFieldValue } from "lightning/uiRecordApi";
import { getRecord } from "lightning/uiRecordApi";
import NAME_FIELD from "@salesforce/schema/Account.Name";
import PHONE_FIELD from "@salesforce/schema/Account.Phone";

let FIELDS = [NAME_FIELD, PHONE_FIELD];
export default class LdsServiceComponent extends LightningElement {
  // ----------ONE Way of getRecord --------------------
  // @api recordId;
  // result = [];
  // @wire(getRecord,{recordId: '$recordId', fields: [NAME_FIELD, PHONE_FIELD]})
  // wiredRecord({data,error}){
  //     if(data){
  //         const {fields} = data
  //         Object.keys(fields).forEach(item=>{
  //             let value = fields[item] && fields[item].displayValue ? fields[item].displayValue : fields[item].value
  //             this.result = {...this.result,[item]:value}
  //         })
  //     }
  //     if(error){
  //         console.error(error);
  //     }
  // }

  // --------------Second Way to get Record ----------------
  // declare FIELDS as global Variable
  @api recordId;

  @wire(getRecord, { recordId: "$recordId", fields: FIELDS })
  account;

  get name() {
    return getFieldValue(this.account.data, NAME_FIELD);
  }
  get phone() {
    return getFieldValue(this.account.data, PHONE_FIELD);
  }

  Name;
  Phone;
  handleInputs(event) {
    this[event.target.label] = event.target.value;
  }
  handleClick() {
    let fields = {
      Name: this.Name,
      Phone: this.Phone
    };
    let recordDetails = {
      apiName: "Account",
      fields: fields
    };
    createRecord(recordDetails)
      .then((x) => {
        console.log("Record Details---" + JSON.stringify(x));
      })
      .catch((err) => {
        console.log("Error Details---" + JSON.stringify(err));
      });
  }
}
