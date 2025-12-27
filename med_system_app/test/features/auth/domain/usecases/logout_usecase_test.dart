import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/auth/domain/repositories/auth_repository.dart';
import 'package:distrito_medico/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LogoutUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LogoutUseCase(mockRepository);
  });

  group('LogoutUseCase', () {
    test('deve retornar Unit quando logout for bem-sucedido', () async {
      // Arrange
      when(() => mockRepository.logout())
          .thenAnswer((_) async => const Right(unit));

      // Act
      final result = await useCase(const NoParams());

      // Assert
      expect(result, const Right(unit));
      verify(() => mockRepository.logout()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('deve retornar CacheFailure quando houver erro ao limpar dados',
        () async {
      // Arrange
      when(() => mockRepository.logout()).thenAnswer((_) async =>
          const Left(CacheFailure(message: 'Erro ao limpar dados')));

      // Act
      final result = await useCase(const NoParams());

      // Assert
      expect(
        result,
        const Left(CacheFailure(message: 'Erro ao limpar dados')),
      );
      verify(() => mockRepository.logout()).called(1);
    });
  });
}
