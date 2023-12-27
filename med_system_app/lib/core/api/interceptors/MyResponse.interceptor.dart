import 'dart:async';
import 'package:chopper/chopper.dart';

class MyResponseInterceptor implements ResponseInterceptor {
  @override
  FutureOr<Response> onResponse(Response response) {
    if (response.statusCode == 401) {}
    return response;
  }
}
