import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:wifi_info_flutter/wifi_info_flutter.dart';

class SafeSyncServer {
  HttpServer _server;
  final void Function(Map<String, dynamic>) _sendParsedRequest;

  SafeSyncServer(this._sendParsedRequest) {
    initServer();
    serverIPTracker = StreamController<String>();
    serverIPTracker.add('...');
  }

  StreamController<String> serverIPTracker;

  Future<void> initServer() async {
    _server = await HttpServer.bind(
      InternetAddress.anyIPv6,
      8989,
    );

    await for (HttpRequest request in _server) {
      try {
        if (request.method == 'POST') {
          await _handleDataPosted(request);
        } else if (request.method == 'GET') {
          print('GET REQUEST RECIEVED. NOT IMPLEMENTED');
        }
      } catch (e) {
        print('Exception in handleRequest: $e');
      }
    }

    WifiInfo().getWifiIP().then((ip) => serverIPTracker.add(ip));
  }

  Future<void> _handleDataPosted(HttpRequest request) async {
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
