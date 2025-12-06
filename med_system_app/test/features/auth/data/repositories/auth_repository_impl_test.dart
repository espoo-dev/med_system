import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/exceptions.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:distrito_medico/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:distrito_medico/features/auth/data/models/user_model.dart';
import 'package:distrito_medico/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tEmail = 'test@test.com';
  const tPassword = '1234';
  const tUserModel = UserModel(
    token: 'test_token',
    refreshToken: 'test_refresh_token',
    expiresIn: 3600,
    tokenType: 'Bearer',
    resourceOwner: ResourceOwnerModel(
      id: 1,
      email: tEmail,
      createdAt: '2024-01-01',
      updatedAt: '2024-01-01',
    ),
  );

  // Registrar fallback values para mocktail
  setUpAll(() {
    registerFallbackValue(tUserModel);
  });

  group('signIn', () {
    test(
        'deve retornar UserEntity quando login remoto e salvamento local forem bem-sucedidos',
        () async {
      // Arrange
      when(() => mockRemoteDataSource.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => tUserModel);

      when(() => mockLocalDataSource.saveUser(any()))
          .thenAnswer((_) async => {});

      // Act
      final result = await repository.signIn(
        email: tEmail,
        password: tPassword,
      );

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Should return Right'),
        (user) {
          expect(user.token, tUserModel.token);
          expect(user.resourceOwner.email, tEmail);
        },
      );

      verify(() => mockRemoteDataSource.signIn(
            email: tEmail,
            password: tPassword,
          )).called(1);
      verify(() => mockLocalDataSource.saveUser(tUserModel)).called(1);
    });

    test('deve retornar ServerFailure quando credenciais forem inválidas',
        () async {
      // Arrange
      when(() => mockRemoteDataSource.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(
        const ServerException(message: 'E-mail ou senha inválidos'),
      );

      // Act
      final result = await repository.signIn(
        email: tEmail,
        password: tPassword,
      );

      // Assert
      expect(
        result,
        const Left(ServerFailure(message: 'E-mail ou senha inválidos')),
      );
      verify(() => mockRemoteDataSource.signIn(
            email: tEmail,
            password: tPassword,
          )).called(1);
      verifyZeroInteractions(mockLocalDataSource);
    });

    test('deve retornar CacheFailure quando houver erro ao salvar localmente',
        () async {
      // Arrange
      when(() => mockRemoteDataSource.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => tUserModel);

      when(() => mockLocalDataSource.saveUser(any())).thenThrow(
        const CacheException(message: 'Erro ao salvar usuário'),
      );

      // Act
      final result = await repository.signIn(
        email: tEmail,
        password: tPassword,
      );

      // Assert
      expect(
        result,
        const Left(CacheFailure(message: 'Erro ao salvar usuário')),
      );
    });
  });

  group('getCurrentUser', () {
    test('deve retornar UserEntity quando houver usuário salvo', () async {
      // Arrange
      when(() => mockLocalDataSource.getUser())
          .thenAnswer((_) async => tUserModel);

      // Act
      final result = await repository.getCurrentUser();

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (failure) => fail('Should return Right'),
        (user) {
          expect(user.token, tUserModel.token);
          expect(user.resourceOwner.email, tEmail);
        },
      );

      verify(() => mockLocalDataSource.getUser()).called(1);
    });

    test('deve retornar CacheFailure quando não houver usuário salvo',
        () async {
      // Arrange
      when(() => mockLocalDataSource.getUser()).thenThrow(
        const CacheException(message: 'Nenhum usuário encontrado no cache'),
      );

      // Act
      final result = await repository.getCurrentUser();

      // Assert
      expect(
        result,
        const Left(
            CacheFailure(message: 'Nenhum usuário encontrado no cache')),
      );
    });
  });

  group('logout', () {
    test('deve retornar Unit quando logout for bem-sucedido', () async {
      // Arrange
      when(() => mockLocalDataSource.clearUser())
          .thenAnswer((_) async => {});

      // Act
      final result = await repository.logout();

      // Assert
      expect(result, const Right(unit));
      verify(() => mockLocalDataSource.clearUser()).called(1);
    });

    test('deve retornar CacheFailure quando houver erro ao fazer logout',
        () async {
      // Arrange
      when(() => mockLocalDataSource.clearUser()).thenThrow(
        const CacheException(message: 'Erro ao limpar dados'),
      );

      // Act
      final result = await repository.logout();

      // Assert
      expect(
        result,
        const Left(CacheFailure(message: 'Erro ao limpar dados')),
      );
    });
  });

  group('isAuthenticated', () {
    test('deve retornar true quando houver usuário salvo', () async {
      // Arrange
      when(() => mockLocalDataSource.hasUser()).thenAnswer((_) async => true);

      // Act
      final result = await repository.isAuthenticated();

      // Assert
      expect(result, true);
      verify(() => mockLocalDataSource.hasUser()).called(1);
    });

    test('deve retornar false quando não houver usuário salvo', () async {
      // Arrange
      when(() => mockLocalDataSource.hasUser()).thenAnswer((_) async => false);

      // Act
      final result = await repository.isAuthenticated();

      // Assert
      expect(result, false);
    });

    test('deve retornar false quando houver erro', () async {
      // Arrange
      when(() => mockLocalDataSource.hasUser())
          .thenThrow(Exception('Erro inesperado'));

      // Act
      final result = await repository.isAuthenticated();

      // Assert
      expect(result, false);
    });
  });
}
