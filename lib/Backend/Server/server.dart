import 'dart:convert';
import 'dart:io';

class SafeSyncServer {
  HttpServer server;
  List<String> _lastResponses = new List<String>(3); // Handle repetitions
  final Function(Map) sendParsedRequest;

  SafeSyncServer(this.sendParsedRequest) {
    initServer();
  }

  void initServer() async {
    server = await HttpServer.bind(
      InternetAddress.anyIPv6,
      8989,
    );

    await for (var request in server) {
      try {
        if (request.method == 'POST') {
          _handleDataPosted(request);
        } else if (request.method == 'GET') {
          print('GET REQUEST RECIEVED. NOT IMPLEMENTED');
        }
      } catch (e) {
        print('Exception in handleRequest: $e');
      }
    }
  }

  void _handleDataPosted(HttpRequest request) async {
    ContentType contentType = request.headers.contentType;
    HttpResponse response = request.response;
    if (contentType?.mimeType == 'application/json') {
      try {
        String content = await utf8.decoder.bind(request).join();
        Map data = jsonDecode(content) as Map;

        // Duplicate Response Protection
        bool responseHandledAlready = false;
        for (String _response in _lastResponses) {
          if (response.toString() == _response) responseHandledAlready = true;
        }
        if (!responseHandledAlready) {
          sendParsedRequest(data);
          _lastResponses[0] = _lastResponses[1];
          _lastResponses[1] = _lastResponses[2];
          _lastResponses[2] = content;
        }

        request.response
          ..statusCode = HttpStatus.ok
          ..write('Request Handled.');
      } catch (e) {
        response
          ..statusCode = HttpStatus.internalServerError
          ..write('Exception during request handling: $e.');
      }
    } else {
      response
        ..statusCode = HttpStatus.methodNotAllowed
        ..write('Unsupported request: ${request.method}.');
    }
    await response.close();
  }
}
