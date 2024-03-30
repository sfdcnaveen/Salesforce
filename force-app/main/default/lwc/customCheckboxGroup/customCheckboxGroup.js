import { LightningElement } from "lwc";

export default class CustomCheckboxGroup extends LightningElement {
  value = ["HariTeja"];
  options = [
    { label: "Naveen", value: "Naveen" },
    { label: "Nageswari", value: "Nageswari" },
    { label: "HariTeja", value: "HariTeja" },
    { label: "Srinivasulu", value: "Srinivasulu" },
    { label: "Lakshmi", value: "Lakshmi" },
    { label: "Prasanna", value: "Prasanna" },
    { label: "SaiKrupa", value: "SaiKrupa" }
  ];

  get updatedOptions() {
    return this.options.map((x) => {
      return { label: x.label, isChecked: this.value.indexOf(x.value) >= 0 };
    });
  }
  handleInput(event) {
    let fName = event.target.value;
    this.value = fName.split(",");
    //this.value = event.target.value;
  }
}
