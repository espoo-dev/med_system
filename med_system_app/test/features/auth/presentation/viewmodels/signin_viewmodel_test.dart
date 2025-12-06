import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/auth/domain/entities/user_entity.dart';
import 'package:distrito_medico/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:distrito_medico/features/auth/domain/usecases/logout_usecase.dart';
import 'package:distrito_medico/features/auth/domain/usecases/signin_usecase.dart';
import 'package:distrito_medico/features/auth/presentation/viewmodels/signin_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignInUseCase extends Mock implements SignInUseCase {}

class MockGetCurrentUserUseCase extends Mock
    implements GetCurrentUserUseCase {}

class MockLogoutUseCase extends Mock implements LogoutUseCase {}

void main() {
  late SignInViewModel viewModel;
  late MockSignInUseCase mockSignInUseCase;
  late MockGetCurrentUserUseCase mockGetCurrentUserUseCase;
  late MockLogoutUseCase mockLogoutUseCase;

  setUp(() {
    mockSignInUseCase = MockSignInUseCase();
    mockGetCurrentUserUseCase = MockGetCurrentUserUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    viewModel = SignInViewModel(
      signInUseCase: mockSignInUseCase,
      getCurrentUserUseCase: mockGetCurrentUserUseCase,
      logoutUseCase: mockLogoutUseCase,
    );
  });

  // Registrar fallback values
  setUpAll(() {
    registerFallbackValue(const SignInParams(email: '', password: ''));
    registerFallbackValue(const NoParams());
  });

  const tEmail = 'test@test.com';
  const tPassword = '1234';
  const tUserEntity = UserEntity(
    token: 'test_token',
    refreshToken: 'test_refresh_token',
    expiresIn: 3600,
    tokenType: 'Bearer',
    resourceOwner: ResourceOwner(
      id: 1,
      email: tEmail,
      createdAt: '2024-01-01',
      updatedAt: '2024-01-01',
    ),
  );

  group('SignInViewModel', () {
    group('setEmail', () {
      test('deve atualizar o email', () {
        // Act
        viewModel.setEmail(tEmail);

        // Assert
        expect(viewModel.email, tEmail);
      });
    });

    group('setPassword', () {
      test('deve atualizar a senha', () {
        // Act
        viewModel.setPassword(tPassword);

        // Assert
        expect(viewModel.password, tPassword);
      });
    });

    group('canSubmit', () {
      test('deve retornar false quando email estiver vazio', () {
        // Arrange
        viewModel.setEmail('');
        viewModel.setPassword(tPassword);

        // Assert
        expect(viewModel.canSubmit, false);
      });

      test('deve retornar false quando senha estiver vazia', () {
        // Arrange
        viewModel.setEmail(tEmail);
        viewModel.setPassword('');

        // Assert
        expect(viewModel.canSubmit, false);
      });

      test('deve retornar false quando ambos estiverem vazios', () {
        // Arrange
        viewModel.setEmail('');
        viewModel.setPassword('');

        // Assert
        expect(viewModel.canSubmit, false);
      });

      test('deve retornar true quando ambos estiverem preenchidos', () {
        // Arrange
        viewModel.setEmail(tEmail);
        viewModel.setPassword(tPassword);

        // Assert
        expect(viewModel.canSubmit, true);
      });
    });

    group('signIn', () {
      test('deve mudar estado para loading e depois success quando login for bem-sucedido',
          () async {
        // Arrange
        viewModel.setEmail(tEmail);
        viewModel.setPassword(tPassword);

        when(() => mockSignInUseCase(any()))
            .thenAnswer((_) async => const Right(tUserEntity));

        // Act
        final future = viewModel.signIn();

        // Assert - Estado loading
        expect(viewModel.state, SignInState.loading);
        expect(viewModel.isLoading, true);

        await future;

        // Assert - Estado success
        expect(viewModel.state, SignInState.success);
        expect(viewModel.isLoading, false);
        expect(viewModel.currentUser, tUserEntity);
        expect(viewModel.errorMessage, '');
      });

      test('deve mudar estado para loading e depois error quando login falhar',
          () async {
        // Arrange
        viewModel.setEmail(tEmail);
        viewModel.setPassword(tPassword);

        when(() => mockSignInUseCase(any())).thenAnswer((_) async =>
            const Left(AuthFailure(message: 'Credenciais inválidas')));

        // Act
        final future = viewModel.signIn();

        // Assert - Estado loading
        expect(viewModel.state, SignInState.loading);

        await future;

        // Assert - Estado error
        expect(viewModel.state, SignInState.error);
        expect(viewModel.isLoading, false);
        expect(viewModel.errorMessage, 'Credenciais inválidas');
        expect(viewModel.currentUser, null);
      });
    });

    group('loadCurrentUser', () {
      test('deve carregar usuário quando houver usuário salvo', () async {
        // Arrange
        when(() => mockGetCurrentUserUseCase(any()))
            .thenAnswer((_) async => const Right(tUserEntity));

        // Act
        await viewModel.loadCurrentUser();

        // Assert
        expect(viewModel.currentUser, tUserEntity);
        expect(viewModel.isAuthenticated, true);
      });

      test('deve deixar currentUser null quando não houver usuário salvo',
          () async {
        // Arrange
        when(() => mockGetCurrentUserUseCase(any())).thenAnswer((_) async =>
            const Left(CacheFailure(message: 'Nenhum usuário encontrado')));

        // Act
        await viewModel.loadCurrentUser();

        // Assert
        expect(viewModel.currentUser, null);
        expect(viewModel.isAuthenticated, false);
      });
    });

    group('logout', () {
      test('deve limpar dados do usuário quando logout for bem-sucedido',
          () async {
        // Arrange
        viewModel.setEmail(tEmail);
        viewModel.setPassword(tPassword);
        viewModel.currentUser = tUserEntity;

        when(() => mockLogoutUseCase(any()))
            .thenAnswer((_) async => const Right(unit));

        // Act
        await viewModel.logout();

        // Assert
        expect(viewModel.currentUser, null);
        expect(viewModel.email, '');
        expect(viewModel.password, '');
        expect(viewModel.state, SignInState.idle);
        expect(viewModel.isAuthenticated, false);
      });

      test('deve definir errorMessage quando logout falhar', () async {
        // Arrange
        when(() => mockLogoutUseCase(any())).thenAnswer((_) async =>
            const Left(CacheFailure(message: 'Erro ao limpar dados')));

        // Act
        await viewModel.logout();

        // Assert
        expect(viewModel.errorMessage, 'Erro ao limpar dados');
      });
    });

    group('resetState', () {
      test('deve resetar estado e errorMessage', () {
        // Arrange
        viewModel.state = SignInState.error;
        viewModel.errorMessage = 'Algum erro';

        // Act
        viewModel.resetState();

        // Assert
        expect(viewModel.state, SignInState.idle);
        expect(viewModel.errorMessage, '');
      });
    });

    group('isLoading', () {
      test('deve retornar true quando estado for loading', () {
        // Arrange
        viewModel.state = SignInState.loading;

        // Assert
        expect(viewModel.isLoading, true);
      });

      test('deve retornar false quando estado não for loading', () {
        // Arrange
        viewModel.state = SignInState.idle;

        // Assert
        expect(viewModel.isLoading, false);
      });
    });

    group('isAuthenticated', () {
      test('deve retornar true quando houver currentUser', () {
        // Arrange
        viewModel.currentUser = tUserEntity;

        // Assert
        expect(viewModel.isAuthenticated, true);
      });

      test('deve retornar false quando não houver currentUser', () {
        // Arrange
        viewModel.currentUser = null;

        // Assert
        expect(viewModel.isAuthenticated, false);
      });
    });
  });
}
