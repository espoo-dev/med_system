import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/auth/domain/entities/user_entity.dart';
import 'package:distrito_medico/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:distrito_medico/features/auth/domain/usecases/logout_usecase.dart';
import 'package:distrito_medico/features/auth/domain/usecases/signin_usecase.dart';
import 'package:mobx/mobx.dart';

part 'signin_viewmodel.g.dart';

/// Estados possíveis do SignIn
enum SignInState { idle, loading, success, error }

// ignore: library_private_types_in_public_api
class SignInViewModel = _SignInViewModelBase with _$SignInViewModel;

abstract class _SignInViewModelBase with Store {
  final SignInUseCase signInUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final LogoutUseCase logoutUseCase;

  _SignInViewModelBase({
    required this.signInUseCase,
    required this.getCurrentUserUseCase,
    required this.logoutUseCase,
  });

  // ========== Observables ==========

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  SignInState state = SignInState.idle;

  @observable
  String errorMessage = '';

  @observable
  UserEntity? currentUser;

  // ========== Computed ==========

  @computed
  bool get isLoading => state == SignInState.loading;

  @computed
  bool get isAuthenticated => currentUser != null;

  @computed
  bool get canSubmit => email.isNotEmpty && password.isNotEmpty;

  // ========== Actions ==========

  @action
  void setEmail(String value) {
    email = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void resetState() {
    state = SignInState.idle;
    errorMessage = '';
  }

  @action
  Future<void> signIn() async {
    state = SignInState.loading;
    errorMessage = '';

    final params = SignInParams(email: email, password: password);
    final result = await signInUseCase(params);

    result.fold(
      (failure) {
        errorMessage = failure.message;
        state = SignInState.error;
      },
      (user) {
        currentUser = user;
        state = SignInState.success;
      },
    );
  }

  @action
  Future<void> loadCurrentUser() async {
    final result = await getCurrentUserUseCase(const NoParams());

    result.fold(
      (failure) {
        currentUser = null;
      },
      (user) {
        currentUser = user;
      },
    );
  }

  @action
  Future<void> logout() async {
    final result = await logoutUseCase(const NoParams());

    result.fold(
      (failure) {
        errorMessage = failure.message;
      },
      (_) {
        currentUser = null;
        email = '';
        password = '';
        state = SignInState.idle;
      },
    );
  }
}
