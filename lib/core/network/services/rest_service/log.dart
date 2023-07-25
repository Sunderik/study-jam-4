part of rest_service;

Future<void> printResponseLog(String method, Response response) async {
  final headersLog = StringBuffer();
  response.headers.forEach((key, value) {
    headersLog.write('\n\t\t$key: $value');
  });
  final logBody = StringBuffer()
    ..write('\tType: $method\n')
    ..write('\tUrl:  ${response.request!.url}\n')
    ..write('\tStatus: ${response.statusCode}\n')
    ..write('\tLength: ${response.contentLength}\n')
    ..write('\tHeaders: $headersLog\n');

  logger.i('Get Response: \n$logBody');
}

Future<void> printRequestLog(String method, Request request) async {
  final headersLog = StringBuffer();
  request.headers.forEach((key, value) {
    headersLog.write('\n\t\t$key: $value');
  });
  final logBody = StringBuffer()
    ..write('\tType: $method\n')
    ..write('\tUrl:  ${request.url}\n')
    ..write('\tHeaders: $headersLog\n');
  if (request.body.isNotEmpty) {
    final bodyLog = StringBuffer();
    // ignore: avoid_dynamic_calls
    jsonDecode(request.body)?.forEach((key, value) {
      bodyLog.write('\n\t\t$key: $value');
    });

    logBody.write('\n\tBody: $bodyLog');
  }
  logger.i('Send Request: [${DateTime.now()}]\n$logBody');
}
