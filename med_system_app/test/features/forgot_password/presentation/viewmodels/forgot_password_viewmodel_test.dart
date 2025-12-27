import 'package:distrito_medico/features/forgot_passoword/presentation/viewmodels/forgot_password_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ForgotPasswordViewModel viewModel;

  setUp(() {
    viewModel = ForgotPasswordViewModel();
  });

  group('ForgotPasswordViewModel', () {
    test('should start with idle state', () {
      // assert
      expect(viewModel.state, ForgotPasswordState.idle);
      expect(viewModel.isLoading, false);
      expect(viewModel.hasError, false);
      expect(viewModel.errorMessage, '');
      expect(viewModel.loadingProgress, 0);
    });

    test('setLoading should change state to loading', () {
      // act
      viewModel.setLoading();

      // assert
      expect(viewModel.state, ForgotPasswordState.loading);
      expect(viewModel.isLoading, true);
      expect(viewModel.hasError, false);
      expect(viewModel.errorMessage, '');
    });

    test('setLoaded should change state to loaded', () {
      // act
      viewModel.setLoaded();

      // assert
      expect(viewModel.state, ForgotPasswordState.loaded);
      expect(viewModel.isLoading, false);
      expect(viewModel.hasError, false);
      expect(viewModel.errorMessage, '');
    });

    test('setError should change state to error with message', () {
      // arrange
      const errorMsg = 'Erro ao carregar página';

      // act
      viewModel.setError(errorMsg);

      // assert
      expect(viewModel.state, ForgotPasswordState.error);
      expect(viewModel.isLoading, false);
      expect(viewModel.hasError, true);
      expect(viewModel.errorMessage, errorMsg);
    });

    test('setProgress should update loading progress', () {
      // act
      viewModel.setProgress(50);

      // assert
      expect(viewModel.loadingProgress, 50);

      // act
      viewModel.setProgress(100);

      // assert
      expect(viewModel.loadingProgress, 100);
    });

    test('reset should return to initial state', () {
      // arrange
      viewModel.setLoading();
      viewModel.setProgress(75);
      viewModel.setError('Some error');

      // act
      viewModel.reset();

      // assert
      expect(viewModel.state, ForgotPasswordState.idle);
      expect(viewModel.isLoading, false);
      expect(viewModel.hasError, false);
      expect(viewModel.errorMessage, '');
      expect(viewModel.loadingProgress, 0);
    });

    test('computed properties should reflect current state', () {
      // idle
      expect(viewModel.isLoading, false);
      expect(viewModel.hasError, false);

      // loading
      viewModel.setLoading();
      expect(viewModel.isLoading, true);
      expect(viewModel.hasError, false);

      // loaded
      viewModel.setLoaded();
      expect(viewModel.isLoading, false);
      expect(viewModel.hasError, false);

      // error
      viewModel.setError('Error');
      expect(viewModel.isLoading, false);
      expect(viewModel.hasError, true);
    });

    test('setLoading should clear previous error message', () {
      // arrange
      viewModel.setError('Previous error');
      expect(viewModel.errorMessage, 'Previous error');

      // act
      viewModel.setLoading();

      // assert
      expect(viewModel.errorMessage, '');
    });

    test('setLoaded should clear previous error message', () {
      // arrange
      viewModel.setError('Previous error');
      expect(viewModel.errorMessage, 'Previous error');

      // act
      viewModel.setLoaded();

      // assert
      expect(viewModel.errorMessage, '');
    });
  });
}
