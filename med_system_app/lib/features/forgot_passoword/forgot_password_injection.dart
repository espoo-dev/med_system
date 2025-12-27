import 'package:distrito_medico/features/forgot_passoword/presentation/viewmodels/forgot_password_viewmodel.dart';
import 'package:get_it/get_it.dart';

void setupForgotPasswordInjection(GetIt getIt) {
  // ========== ViewModels ==========
  getIt.registerFactory(
    () => ForgotPasswordViewModel(),
  );
}
