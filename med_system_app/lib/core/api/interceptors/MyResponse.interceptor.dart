import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:distrito_medico/features/signin/store/signin.store.dart';
import 'package:get_it/get_it.dart';

class MyResponseInterceptor implements ResponseInterceptor {
  final signStore = GetIt.I.get<SignInStore>();
  @override
  FutureOr<Response> onResponse(Response response) {
    if (response.statusCode == 401) {
      signStore.forceLogout();
    }
    return response;
  }
}
