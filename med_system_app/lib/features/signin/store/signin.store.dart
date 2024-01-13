import 'package:med_system_app/core/api/network_exceptions.dart';
import 'package:med_system_app/features/signin/model/user.model.dart';
import 'package:med_system_app/features/signin/repository/signin_repository.dart';
import 'package:mobx/mobx.dart';
part 'signin.store.g.dart';

// ignore: library_private_types_in_public_api
class SignInStore = _SignInBaseStore with _$SignInStore;

enum SignInState { idle, success, error, loading }

abstract class _SignInBaseStore with Store {
  final SignInRepository _signInRepository;

  _SignInBaseStore(this._signInRepository);

  @observable
  UserModel? _currentUser;

  @action
  setCurrentUser(UserModel userModelResponse) =>
      _currentUser = userModelResponse;

  UserModel? get currentUser => _currentUser;

  @observable
  String _email = "";

  @observable
  String _password = "";

  @action
  changeEmail(String value) {
    _email = value;
  }

  @action
  changePassword(String value) {
    _password = value;
  }

  get email => _email;
  get password => _password;

  @observable
  var signInState = SignInState.idle;

  @observable
  String _errorMessage = "";
  get errorMessage => _errorMessage;

  @observable
  bool _isAuthenticated = false;

  get isAuthenticated => _isAuthenticated;
  @action
  setAuthentication(bool isAuth) {
    _isAuthenticated = isAuth;
  }

  getUserStorage() async {
    _currentUser = await _signInRepository.getUserStorage();
    if (_currentUser != null) {
      setAuthentication(true);
      return _currentUser;
    }
    return _currentUser;
  }

  @action
  forceLogout() async {
    _isAuthenticated = false;
    await _signInRepository.clearUserStorage();
  }

  signIn(String document, String password) async {
    signInState = SignInState.loading;
    var authResult = await _signInRepository.signIn(document, password);
    authResult.when(success: (dynamic result) async {
      if (result is UserModel) {
        setCurrentUser(await _signInRepository.getUserStorage());
        signInState = SignInState.success;
      } else {
        handleError(result.message);
        signInState = SignInState.error;
      }
    }, failure: (NetworkExceptions error) {
      handleError(NetworkExceptions.getErrorMessage(error));
      signInState = SignInState.error;
    });
  }

  handleError(String reason) {
    _errorMessage = reason;
  }
}
