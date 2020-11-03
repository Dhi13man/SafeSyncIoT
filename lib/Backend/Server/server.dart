import 'dart:convert';
import 'dart:io';

class SafeSyncServer {
  HttpServer server;
  final Function sendParsedRequest;

  SafeSyncServer(this.sendParsedRequest) {
    initServer();
  }

  void initServer() async {
    server = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      4041,
    );

    await for (var request in server) {
      try {
        if (request.method == 'POST') {
          _handleDataPosted(request);
        } else {}
      } catch (e) {
        print('Exception in handleRequest: $e');
      }
    }
  }

  void _handleDataPosted(HttpRequest request) async {
    ContentType contentType = request.headers.contentType;
    HttpResponse response = request.response;

    if (contentType?.mimeType == 'application/json' /*1*/) {
      try {
        String content = await utf8.decoder.bind(request).join(); /*2*/
        Map data = jsonDecode(content) as Map; /*3*/
        print(data);
        sendParsedRequest(data);

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
