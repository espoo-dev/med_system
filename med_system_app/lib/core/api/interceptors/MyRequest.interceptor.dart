import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:distrito_medico/features/auth/presentation/viewmodels/signin_viewmodel.dart';
import 'package:get_it/get_it.dart';

/// HTTP Request Interceptor for API authentication.
/// 
/// This interceptor automatically adds JWT authentication tokens to outgoing
/// HTTP requests, except for the sign-in endpoint which doesn't require auth.
/// 
/// **Flow:**
/// 1. Intercepts all outgoing HTTP requests
/// 2. Checks if the request is NOT for sign-in endpoint
/// 3. If user is authenticated, adds Bearer token to Authorization header
/// 4. Proceeds with the modified request
/// 
/// **Updated for Chopper v8.x** - Uses generic Interceptor interface
class MyRequestInterceptor implements Interceptor {
  final signInViewModel = GetIt.I.get<SignInViewModel>();

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final request = chain.request;
    Uri uri = request.url;

    // Skip authentication for sign-in endpoint
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
