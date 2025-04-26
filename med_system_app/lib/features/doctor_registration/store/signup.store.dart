import 'package:distrito_medico/features/doctor_registration/repository/signup_repository.dart';
import 'package:distrito_medico/features/signin/model/user.model.dart';
import 'package:mobx/mobx.dart';
import 'package:distrito_medico/core/api/network_exceptions.dart';

part 'signup.store.g.dart';

class SignUpStore = _SignUpBaseStore with _$SignUpStore;

enum SignUpState { idle, success, error, loading }

abstract class _SignUpBaseStore with Store {
  final SignUpRepository _signUpRepository;

  _SignUpBaseStore(this._signUpRepository);

  @observable
  String _email = '';

  @observable
  String _password = '';

  @observable
  String _confirmPassword = '';

  @observable
  SignUpState signUpState = SignUpState.idle;

  @observable
  String _errorMessage = '';

  @observable
  UserModel? _userModel;

  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String get errorMessage => _errorMessage;
  UserModel? get userModel => _userModel;

  @computed
  bool get passwordsDoNotMatch =>
      _confirmPassword.isNotEmpty && _password != _confirmPassword;

  @computed
  bool get canSubmit =>
      _email.isNotEmpty &&
      _password.isNotEmpty &&
      _confirmPassword.isNotEmpty &&
      !passwordsDoNotMatch;

  @action
  changeEmail(String value) => _email = value;

  @action
  changePassword(String value) => _password = value;

  @action
  changeConfirmPassword(String value) => _confirmPassword = value;

  @action
  Future<void> signUp() async {
    signUpState = SignUpState.loading;

    if (_password != _confirmPassword) {
      _errorMessage = "As senhas não coincidem.";
      signUpState = SignUpState.error;
      return;
    }

    final result = await _signUpRepository.signUp(
      _email,
      _password,
    );

    result.when(
      success: (_) {
        signUpState = SignUpState.success;
      },
      failure: (error) {
        handleError(NetworkExceptions.getErrorMessage(error));
        signUpState = SignUpState.error;
      },
    );
  }

  @action
  void handleError(String reason) {
    _errorMessage = reason;
  }
}
