import 'package:mobx/mobx.dart';

part 'forgot_password_viewmodel.g.dart';

enum ForgotPasswordState { idle, loading, loaded, error }

// ignore: library_private_types_in_public_api
class ForgotPasswordViewModel = _ForgotPasswordViewModelBase
    with _$ForgotPasswordViewModel;

abstract class _ForgotPasswordViewModelBase with Store {
  @observable
  ForgotPasswordState state = ForgotPasswordState.idle;

  @observable
  String errorMessage = '';

  @observable
  int loadingProgress = 0;

  @computed
  bool get isLoading => state == ForgotPasswordState.loading;

  @computed
  bool get hasError => state == ForgotPasswordState.error;

  @action
  void setLoading() {
    state = ForgotPasswordState.loading;
    errorMessage = '';
  }

  @action
  void setLoaded() {
    state = ForgotPasswordState.loaded;
    errorMessage = '';
  }

  @action
  void setError(String message) {
    state = ForgotPasswordState.error;
    errorMessage = message;
  }

  @action
  void setProgress(int progress) {
    loadingProgress = progress;
  }

  @action
  void reset() {
    state = ForgotPasswordState.idle;
    errorMessage = '';
    loadingProgress = 0;
  }
}
