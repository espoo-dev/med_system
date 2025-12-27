import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/auth/domain/entities/user_entity.dart';
import 'package:distrito_medico/features/auth/domain/repositories/auth_repository.dart';
import 'package:distrito_medico/features/auth/domain/usecases/signin_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignInUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SignInUseCase(mockRepository);
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

  group('SignInUseCase', () {
    test('deve retornar UserEntity quando login for bem-sucedido', () async {
      // Arrange
      when(() => mockRepository.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => const Right(tUserEntity));

      // Act
      final result = await useCase(
        const SignInParams(email: tEmail, password: tPassword),
      );

      // Assert
      expect(result, const Right(tUserEntity));
      verify(() => mockRepository.signIn(
            email: tEmail,
            password: tPassword,
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('deve retornar ValidationFailure quando email estiver vazio',
        () async {
      // Act
      final result = await useCase(
        const SignInParams(email: '', password: tPassword),
      );

      // Assert
      expect(
        result,
        const Left(ValidationFailure(message: 'Email não pode ser vazio')),
      );
      verifyZeroInteractions(mockRepository);
    });

    test('deve retornar ValidationFailure quando email for inválido',
        () async {
      // Act
      final result = await useCase(
        const SignInParams(email: 'invalid-email', password: tPassword),
      );

      // Assert
      expect(
        result,
        const Left(ValidationFailure(message: 'Email inválido')),
      );
      verifyZeroInteractions(mockRepository);
    });

    test('deve retornar ValidationFailure quando senha estiver vazia',
        () async {
      // Act
      final result = await useCase(
        const SignInParams(email: tEmail, password: ''),
      );

      // Assert
      expect(
        result,
        const Left(ValidationFailure(message: 'Senha não pode ser vazia')),
      );
      verifyZeroInteractions(mockRepository);
    });

    test('deve retornar ValidationFailure quando senha for muito curta',
        () async {
      // Act
      final result = await useCase(
        const SignInParams(email: tEmail, password: '123'),
      );

      // Assert
      expect(
        result,
        const Left(ValidationFailure(
            message: 'Senha deve ter no mínimo 4 caracteres')),
      );
      verifyZeroInteractions(mockRepository);
    });

    test('deve retornar AuthFailure quando credenciais forem inválidas',
        () async {
      // Arrange
      when(() => mockRepository.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async =>
              const Left(AuthFailure(message: 'Credenciais inválidas')));

      // Act
      final result = await useCase(
        const SignInParams(email: tEmail, password: tPassword),
      );

      // Assert
      expect(
        result,
        const Left(AuthFailure(message: 'Credenciais inválidas')),
      );
      verify(() => mockRepository.signIn(
            email: tEmail,
            password: tPassword,
          )).called(1);
    });
  });
}
