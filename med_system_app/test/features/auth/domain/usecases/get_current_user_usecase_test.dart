import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/auth/domain/entities/user_entity.dart';
import 'package:distrito_medico/features/auth/domain/repositories/auth_repository.dart';
import 'package:distrito_medico/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late GetCurrentUserUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = GetCurrentUserUseCase(mockRepository);
  });

  const tUserEntity = UserEntity(
    token: 'test_token',
    refreshToken: 'test_refresh_token',
    expiresIn: 3600,
    tokenType: 'Bearer',
    resourceOwner: ResourceOwner(
      id: 1,
      email: 'test@test.com',
      createdAt: '2024-01-01',
      updatedAt: '2024-01-01',
    ),
  );

  group('GetCurrentUserUseCase', () {
    test('deve retornar UserEntity quando usuário estiver salvo', () async {
      // Arrange
      when(() => mockRepository.getCurrentUser())
          .thenAnswer((_) async => const Right(tUserEntity));

      // Act
      final result = await useCase(const NoParams());

      // Assert
      expect(result, const Right(tUserEntity));
      verify(() => mockRepository.getCurrentUser()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('deve retornar CacheFailure quando não houver usuário salvo',
        () async {
      // Arrange
      when(() => mockRepository.getCurrentUser()).thenAnswer((_) async =>
          const Left(CacheFailure(message: 'Nenhum usuário encontrado')));

      // Act
      final result = await useCase(const NoParams());

      // Assert
      expect(
        result,
        const Left(CacheFailure(message: 'Nenhum usuário encontrado')),
      );
      verify(() => mockRepository.getCurrentUser()).called(1);
    });
  });
}
