import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/procedures/domain/entities/procedure_entity.dart';
import 'package:distrito_medico/features/procedures/domain/repositories/procedure_repository.dart';
import 'package:distrito_medico/features/procedures/domain/usecases/get_all_procedures_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProcedureRepository extends Mock implements ProcedureRepository {}

void main() {
  late GetAllProceduresUseCase useCase;
  late MockProcedureRepository mockRepository;

  setUp(() {
    mockRepository = MockProcedureRepository();
    useCase = GetAllProceduresUseCase(mockRepository);
  });

  const tProcedureList = [
    ProcedureEntity(
      id: 1,
      name: 'Procedure 1',
      code: '123',
      description: 'Desc 1',
      amountCents: '1000',
    ),
    ProcedureEntity(
      id: 2,
      name: 'Procedure 2',
      code: '456',
      description: 'Desc 2',
      amountCents: '2000',
    ),
  ];

  group('GetAllProceduresUseCase', () {
    test('deve retornar lista de procedimentos quando sucesso', () async {
      // Arrange
      when(() => mockRepository.getAllProcedures(
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer((_) async => const Right(tProcedureList));

      // Act
      final result = await useCase(const GetAllProceduresParams());

      // Assert
      expect(result, const Right(tProcedureList));
      verify(() => mockRepository.getAllProcedures(page: 1, perPage: 10))
          .called(1);
    });

    test('deve retornar ValidationFailure quando página for inválida', () async {
      // Act
      final result = await useCase(
        const GetAllProceduresParams(page: 0),
      );

      // Assert
      expect(
        result,
        const Left(ValidationFailure(message: 'Página deve ser maior que 0')),
      );
      verifyZeroInteractions(mockRepository);
    });

    test('deve retornar ServerFailure quando repositório falhar', () async {
      // Arrange
      when(() => mockRepository.getAllProcedures(
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer(
        (_) async => const Left(ServerFailure(message: 'Erro no servidor')),
      );

      // Act
      final result = await useCase(const GetAllProceduresParams());

      // Assert
      expect(
        result,
        const Left(ServerFailure(message: 'Erro no servidor')),
      );
    });
  });
}
