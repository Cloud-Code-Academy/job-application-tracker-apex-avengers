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

    public HTTPResponse respond(HTTPRequest req) {
        HTTPResponse res = new HTTPResponse();
        res.setStatusCode(code);
        res.setStatus(status);
        res.setBody(body);
        res.setHeader('Content-Type', responseHeaders.get('Content-Type'));
        return res;
    }
}
