import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:distrito_medico/features/auth/presentation/viewmodels/signin_viewmodel.dart';
import 'package:get_it/get_it.dart';

class MyResponseInterceptor implements ResponseInterceptor {
  final signInViewModel = GetIt.I.get<SignInViewModel>();
  @override
  FutureOr<Response> onResponse(Response response) {
    if (response.statusCode == 401) {
      signInViewModel.logout();
    }
    return response;
  }
}
