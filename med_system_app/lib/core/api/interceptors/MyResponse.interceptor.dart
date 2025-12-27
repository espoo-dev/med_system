import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:distrito_medico/features/auth/presentation/viewmodels/signin_viewmodel.dart';
import 'package:get_it/get_it.dart';

/// HTTP Response Interceptor for session management.
/// 
/// This interceptor handles authentication failures by automatically
/// logging out users when their session expires or token becomes invalid.
/// 
/// **Flow:**
/// 1. Intercepts all incoming HTTP responses
/// 2. Checks for 401 Unauthorized status code
/// 3. If 401 detected, triggers automatic logout
/// 4. Returns the response for further processing
/// 
/// **Updated for Chopper v8.x** - Uses generic Interceptor interface
class MyResponseInterceptor implements Interceptor {
  final signInViewModel = GetIt.I.get<SignInViewModel>();
  
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final response = await chain.proceed(chain.request);
    
    // Handle unauthorized access - session expired or invalid token
    if (response.statusCode == 401) {
      signInViewModel.logout();
    }
    
    return response;
  }
}
