import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';
import OPPORTUNITY_OBJECT from '@salesforce/schema/Opportunity';
import NAME_FIELD from '@salesforce/schema/Opportunity.Name';
import CLOSE_DATE_FIELD from '@salesforce/schema/Opportunity.CloseDate';
import STAGE_NAME_FIELD from '@salesforce/schema/Opportunity.StageName';

export default class CreateOpportunityLWC extends NavigationMixin(LightningElement) {
    opportunityName = '';
    closeDate = '';
    stageName = '';

    // List of fields for lightning-record-form
    fields = [NAME_FIELD, CLOSE_DATE_FIELD, STAGE_NAME_FIELD];

    // Handle input change
    handleOpportunityNameChange(event) {
        this.opportunityName = event.target.value;
    }

    handleCloseDateChange(event) {
        this.closeDate = event.target.value;
    }

    handleStageNameChange(event) {
        this.stageName = event.target.value;
    }

    // Method to create opportunity using createRecord
    createOpportunity() {
        const fields = {};
        fields[NAME_FIELD.fieldApiName] = this.opportunityName;
        fields[CLOSE_DATE_FIELD.fieldApiName] = this.closeDate;
        fields[STAGE_NAME_FIELD.fieldApiName] = this.stageName;

        const recordInput = { apiName: OPPORTUNITY_OBJECT.objectApiName, fields };

        createRecord(recordInput)
            .then(opportunity => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Opportunity created with ID: ' + opportunity.id,
                        variant: 'success',
                    }),
                );
                // Navigate to the newly created Opportunity record page
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: opportunity.id,
                        objectApiName: 'Opportunity',
                        actionName: 'view'
                    }
                });
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
    }

    // Success handler for lightning-record-form
    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: "Success",
            message: "Opportunity created successfully! Record ID: " + event.detail.id,
            variant: "success",
        });
        this.dispatchEvent(evt);

        // Navigate to the newly created Opportunity record page
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.detail.id,
                objectApiName: 'Opportunity',
                actionName: 'view'
            }
        });
    }

    // Error handler for lightning-record-form
    handleError(event) {
        const evt = new ShowToastEvent({
            title: "Error",
            message: event.detail.message,
            variant: "error",
        });
        this.dispatchEvent(evt);
    }
}