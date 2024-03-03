import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:distrito_medico/features/signin/store/signin.store.dart';
import 'package:get_it/get_it.dart';

class MyRequestInterceptor implements RequestInterceptor {
  final signStore = GetIt.I.get<SignInStore>();

  @override
  FutureOr<Request> onRequest(Request request) async {
    Uri uri = request.url;

    if (!uri.toString().contains('sign_in')) {
      if (signStore.currentUser?.token != null) {
        return applyHeaders(request,
            {'Authorization': 'Bearer ${signStore.currentUser!.token!}'});
      }
    }

    return request;
  }
}
