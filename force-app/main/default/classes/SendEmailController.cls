public class SendEmailController {
    public String toAddress { get; set; }
    public String ccAddress { get; set; }
    public String emailBody { get; set; }
    public String quoteName { get; set; }
    public String Subject { get; set; }
    public Id quoteId { get; set; }
    public String contactEmail { get; set; }
    public String contactName { get; set; }
    public String accountName { get; set; }
    public List<Quotes__c> opp{get; set;}
    public SendEmailController(){
        quoteId = ApexPages.currentPage().getParameters().get('id');
        opp = [SELECT Id, Name, Contact__c, Account__c, Account__r.Name, Contact__r.Email, Contact__r.Name FROM Quotes__c WHERE Id = :quoteId];
        for (Quotes__c q : opp) {
            // Accessing email from the related Contact object
            contactEmail = q.Contact__r.Email;
            contactName = q.Contact__r.Name;
            accountName = q.Account__r.Name;
            quoteName = q.Name;
        }
    toAddress = contactEmail;
        ccAddress = 'pasupulatink@gmail.com';
        Subject = 'Email for ' + quoteName;
        emailBody = 'Hi, ' + '<strong>' + contactName + '</strong>' +
            '<br></br> Hope you are doing well.<br></br>' + 
            'Below are the details about your opportunity, please validate and confirm if there is some update is required.' + '<br></br>' +
            '<strong>Account Name: </Strong>' + accountName + '<br></br>' +
            '<strong>Contact Name: </Strong>' + contactName + '<br></br>' +
            '<strong>Email: </Strong>' + contactEmail + '<br></br>' +
            'Please contact us for any concerns <br></br> Regards,<br></br><Strong>Salesforce service Team</Strong>';
    
    }
    
    public PageReference sendEmail() {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setBody(getQuotePDFBlob());
        attachment.setFileName('QuotePDF.pdf');
        mail.setToAddresses(new String[]{toAddress});
        mail.setSubject(subject);
        mail.setHtmlBody(emailBody);
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment });
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ mail });
        PageReference opportunityPage = new ApexPages.StandardController(new Quotes__c(Id = quoteId)).view();
        opportunityPage.setRedirect(true);
        return opportunityPage;
    }
    private Blob getQuotePDFBlob() {
    Quotes__c quote = [SELECT Id, Name FROM Quotes__c WHERE Id = :quoteId];
    
    // Generate the PDF by rendering the Quote as a PDF
    PageReference quotePage = new PageReference('/apex/QuotePDF');
    quotePage.getParameters().put('id', quoteId);
    quotePage.getParameters().put('renderAs', 'pdf');
    
    // Get the PDF content as a Blob
    Blob pdfBlob = quotePage.getContentAsPDF();
    
    return pdfBlob;
    }
    public PageReference cancel(){
        PageReference pf = new PageReference('/'+quoteId);
        return pf;
    }
  
    

}