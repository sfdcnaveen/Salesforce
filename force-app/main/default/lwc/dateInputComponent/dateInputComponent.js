import { LightningElement } from 'lwc';

export default class DateInputComponent extends LightningElement {
    selectedDate;
    formattedDate;

    handleDateChange(event) {
        this.selectedDate = event.target.value;
        this.formattedDate = this.formatDate(this.selectedDate);
    }

    formatDate(dateString) {
        if (dateString) {
            const dateObj = new Date(dateString);
            const formattedDate = new Intl.DateTimeFormat('en-GB', { day: 'numeric', month: 'short', year: 'numeric' }).format(dateObj);
            return formattedDate;
        }
        return '';
    }
}