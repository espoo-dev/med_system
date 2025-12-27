import 'package:distrito_medico/features/doctor_registration/domain/entities/signup_entity.dart';
import 'package:distrito_medico/features/doctor_registration/domain/usecases/signup_usecase.dart';
import 'package:mobx/mobx.dart';

part 'signup_viewmodel.g.dart';

enum SignUpState { idle, loading, success, error }

// ignore: library_private_types_in_public_api
class SignUpViewModel = _SignUpViewModelBase with _$SignUpViewModel;

abstract class _SignUpViewModelBase with Store {
  final SignUpUseCase signUpUseCase;

  _SignUpViewModelBase({required this.signUpUseCase});

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @observable
  SignUpState state = SignUpState.idle;

  @observable
  String errorMessage = '';

  @observable
  SignUpEntity? signUpResult;

  @computed
  bool get isLoading => state == SignUpState.loading;

  @computed
  bool get passwordsDoNotMatch =>
      confirmPassword.isNotEmpty && password != confirmPassword;

  @computed
  bool get canSubmit =>
      email.trim().isNotEmpty &&
      password.trim().isNotEmpty &&
      confirmPassword.trim().isNotEmpty &&
      !passwordsDoNotMatch;

  @action
  void setEmail(String value) {
    email = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  @action
  Future<void> signUp() async {
    state = SignUpState.loading;
    errorMessage = '';

    final params = SignUpParams(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    final result = await signUpUseCase(params);

    result.fold(
      (failure) {
        errorMessage = failure.message;
        state = SignUpState.error;
      },
      (entity) {
        signUpResult = entity;
        state = SignUpState.success;
      },
    );
  }

  @action
  void resetState() {
    state = SignUpState.idle;
    errorMessage = '';
  }

  @action
  void reset() {
    email = '';
    password = '';
    confirmPassword = '';
    state = SignUpState.idle;
    errorMessage = '';
    signUpResult = null;
  }
}
