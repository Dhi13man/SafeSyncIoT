import 'dart:convert';
import 'dart:io';

class SafeSyncServer {
  HttpServer _server;
  final void Function(Map<String, dynamic>) _sendParsedRequest;

  SafeSyncServer(this._sendParsedRequest) {
    initServer();
  }

  void initServer() async {
    _server = await HttpServer.bind(
      InternetAddress.anyIPv6,
      8989,
    );

    await for (HttpRequest request in _server) {
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
        Map<String, dynamic> data = jsonDecode(content) as Map<String, dynamic>;

        _sendParsedRequest(data);

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
