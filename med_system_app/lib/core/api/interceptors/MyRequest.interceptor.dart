import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:distrito_medico/features/auth/presentation/viewmodels/signin_viewmodel.dart';
import 'package:get_it/get_it.dart';

class MyRequestInterceptor implements RequestInterceptor {
  final signInViewModel = GetIt.I.get<SignInViewModel>();

  @override
  FutureOr<Request> onRequest(Request request) async {
    Uri uri = request.url;

    if (!uri.toString().contains('sign_in')) {
      if (signInViewModel.currentUser?.token != null) {
        return applyHeaders(request,
            {'Authorization': 'Bearer ${signInViewModel.currentUser!.token}'});
      }
    }

    return request;
  }
}
