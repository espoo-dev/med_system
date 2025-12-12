import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:distrito_medico/features/auth/presentation/viewmodels/signin_viewmodel.dart';
import 'package:get_it/get_it.dart';

class MyRequestInterceptor implements Interceptor {
  final signInViewModel = GetIt.I.get<SignInViewModel>();

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final request = chain.request;
    Uri uri = request.url;

    if (!uri.toString().contains('sign_in')) {
      if (signInViewModel.currentUser?.token != null) {
        final newRequest = applyHeaders(request,
            {'Authorization': 'Bearer ${signInViewModel.currentUser!.token}'});
        return chain.proceed(newRequest);
      }
    }

    return chain.proceed(request);
  }
}
