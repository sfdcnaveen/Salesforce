public class Pixabay {
    @future(callout=true)
    public static void getPicture(){
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:Pixabay/?key=9200291-f02da0e342de5652c0740a0f4&q=Flower');
        request.setMethod('GET');
        
        Http http = new Http();
        HttpResponse response = new HttpResponse();
        
        System.debug(response.getStatusCode());
    }

}