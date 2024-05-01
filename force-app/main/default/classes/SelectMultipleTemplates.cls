public class SelectMultipleTemplates {
    @AuraEnabled
    public static List<EmailTemplate> getEmailTemplates(){
        List<EmailTemplate> emailTemplatesList = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate];
        return emailTemplatesList;
    }

}