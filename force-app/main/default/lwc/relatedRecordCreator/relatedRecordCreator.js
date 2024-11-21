import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import createRelatedRecords from '@salesforce/apex/RelatedRecordCreatorController.createRelatedRecords';
import getPicklistValues from '@salesforce/apex/RelatedRecordCreatorController.getPicklistValues';

export default class RelatedRecordCreator extends NavigationMixin(LightningElement) {
    @track accountData = {
        Name: '',
        Industry: '',
        Phone: ''
    };
    @track contactData = {
        FirstName: '',
        LastName: '',
        Email: ''
    };
    @track opportunityData = {
        Name: '',
        StageName: '',
        CloseDate: ''
    };

    @track industryOptions = [];
    @track stageOptions = [];

    @wire(getPicklistValues)
    wiredPicklistValues({ error, data }) {
        if (data) {
            this.industryOptions = data.industryValues;
            this.stageOptions = data.stageValues;
        } else if (error) {
            console.error('Error fetching picklist values', error);
        }
    }

    handleInputChange(event) {
        const { name, value } = event.target;
        const [objectType, field] = name.split('_');

        if (objectType === 'account') {
            this.accountData[field] = value;
        } else if (objectType === 'contact') {
            this.contactData[field] = value;
        } else if (objectType === 'opportunity') {
            this.opportunityData[field] = value;
        }
    }

    handleSubmit() {
        const allValid = [...this.template.querySelectorAll('lightning-input, lightning-combobox')]
            .reduce((validSoFar, inputField) => {
                inputField.reportValidity();
                return validSoFar && inputField.checkValidity();
            }, true);

        if (allValid) {
            createRelatedRecords({
                accountData: this.accountData,
                contactData: this.contactData,
                opportunityData: this.opportunityData
            })
                .then(result => {
                    this.showToast('Success', 'Records created successfully', 'success');
                    this.navigateToAccount(result.accountId);
                })
                .catch(error => {
                    this.showToast('Error', 'Error creating records: ' + error.body.message, 'error');
                });
        }
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: variant,
            }),
        );
    }

    navigateToAccount(accountId) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: accountId,
                objectApiName: 'Account',
                actionName: 'view'
            },
        });
    }
}
