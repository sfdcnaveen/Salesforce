public with sharing class PixabayAPI {
  @AuraEnabled
  public static string getPicture(String search) {
    Http http = new Http();
    HttpRequest req = new HttpRequest();
    req.setEndpoint(
      'callout:Pixabay/?key=9200291-f02da0e342de5652c0740a0f4&q=' + search
    );
    req.setMethod('GET');
    HttpResponse res = http.send(req);
    return res.getBody();
  }
}