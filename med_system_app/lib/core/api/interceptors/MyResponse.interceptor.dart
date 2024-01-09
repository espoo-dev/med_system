import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:get_it/get_it.dart';
import 'package:med_system_app/features/signin/store/signin.store.dart';

class MyResponseInterceptor implements ResponseInterceptor {
  final signStore = GetIt.I.get<SignInStore>();
  @override
  FutureOr<Response> onResponse(Response response) {
    if (response.statusCode == 401) {
      //
    }
    return response;
  }
}
