import 'dart:async';
import 'package:chopper/chopper.dart';

class MyRequestInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    return request;
  }
}
