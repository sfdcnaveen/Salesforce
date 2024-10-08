import { LightningElement } from 'lwc';

export default class DateFormat extends LightningElement {
    // This LWC converts a date format from MMDDYYYY format to en-IN
    // if input is 10212024 then output format is 21 Oct 2024
    inputValue = '';
    formattedDate = '';

    handleDateChange(event) {
        this.inputValue = event.target.value;
        if (this.inputValue.length === 8) {
            this.formattedDate = this.formatDate(this.inputValue);
        } else {
            this.formattedDate = 'Invalid format';
        }
    }

    formatDate(dateString) {
        // Extract month, day, and year
        const month = dateString.substring(0, 2);
        const day = dateString.substring(2, 4);
        const year = dateString.substring(4, 8);

        // Convert to JavaScript Date object
        const date = new Date(`${year}-${month}-${day}`);
        const options = { day: 'numeric', month: 'short', year: 'numeric' };

        // Return formatted date
        return date.toLocaleDateString('en-IN', options);
    }
}