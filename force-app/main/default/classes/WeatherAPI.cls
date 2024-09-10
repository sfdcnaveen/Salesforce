public class WeatherAPI {
    @future(callout=true)
    public static void getWeather(){
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:WeatherAPI/current.json?q=Jaipur');
        request.setMethod('GET');
        
        Http http = new Http();
        HttpResponse response = http.send(request);
        System.debug('##Status Code--'+response.getStatusCode());
        
        if(response.getStatusCode() == 200){
            System.debug('##Response--'+response.getBody());
            /*
            Map<object, object> results = (Map<object, object) JSON.deserializeUntyped(response.getBody());
            List<object> location = (List<object>) results.get('location');
            List<object> current = (List<object>) results.get('current');
            */
        }
    }
    
    @AuraEnabled
    public static string getWeather(String city){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:WeatherAPI/current.json?q='+city);
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        return res.getBody();
    }

}