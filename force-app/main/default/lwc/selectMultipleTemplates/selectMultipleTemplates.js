import { LightningElement, track } from "lwc";
import getEmailTemplates from "@salesforce/apex/SelectMultipleTemplates.getEmailTemplates";

export default class SelectMultipleTemplates extends LightningElement {
  @track selectedOptions = [];
  @track templatesArray = [];
  @track disabled = false;
  @track value = [];

  connectedCallback() {
    getEmailTemplates().then((response) => {
      let arr = [];
      // eslint-disable-next-line vars-on-top
      for (var i = 0; i < response.length; i++) {
        arr.push({
          label: i + " " + response[i].DeveloperName,
          value: response[i].Body
        });
      }
      this.templatesArray = arr;
    });
  }

  get options() {
    return this.templatesArray;
  }

  handleChange(event) {
    this.selectedOptions = event.detail;
    this.updateRichTextField();
  }
  updateRichTextField() {
    let selectedBodies = [];
    for (let i = 0; i < this.selectedOptions.length; i++) {
      const selectedValue = this.selectedOptions[i].value;
      const selectedTemplate = this.templatesArray.find(
        (template) => template.value === selectedValue
      );
      if (selectedTemplate) {
        selectedBodies.push(selectedTemplate.value);
      }
    }
    this.value = selectedBodies.join("\n");
  }
}
