import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:distrito_medico/features/auth/presentation/viewmodels/signin_viewmodel.dart';
import 'package:get_it/get_it.dart';

class MyResponseInterceptor implements Interceptor {
  final signInViewModel = GetIt.I.get<SignInViewModel>();
  
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final response = await chain.proceed(chain.request);
    
    if (response.statusCode == 401) {
      signInViewModel.logout();
    }
    
    return response;
  }
}
