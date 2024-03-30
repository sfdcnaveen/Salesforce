import { LightningElement } from "lwc";

export default class ParentComponent extends LightningElement {
  handleInput(event) {
    let fName = event.target.value;
    const childComp = this.template.querySelector("c-child-component");
    childComp.valuesFromParent(fName);
  }
}
