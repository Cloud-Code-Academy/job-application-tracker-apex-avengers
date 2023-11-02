// Mock class to simulate the HTTP callout response
public with sharing class JoobleIntegrationMock implements HttpCalloutMock {
    protected Integer code;
    protected String status;
    protected String body;
    protected Map<String, String> responseHeaders;

    public JoobleIntegrationMock(Integer code, String status, String body) {
        this.code = code;
        this.status = status;
        this.body = body;
        responseHeaders = new Map<String, String>();
        responseHeaders.put('Content-Type', 'application/json');
    }

    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
       
        res.setBody('{"totalCount":1,"jobs":[{"title":"Salesforce Developer","location":"Remote","snippet":"This is Job description...","salary":"4000","link":"https://joblink.com","company":"TechABC Inc.","id":"1234","updated":"2023-10-25T10:10:10Z"}]}');
        return res;
    }
}
