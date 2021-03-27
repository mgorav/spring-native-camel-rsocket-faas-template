package function;

public class RequestHandler {
    public String handle(byte[] requestPayload) {
        return String.format("SpringBoot, request handler, Echo: %s", new String(requestPayload));
    }
}
