import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/procedures/domain/entities/procedure_entity.dart';
import 'package:distrito_medico/features/procedures/domain/repositories/procedure_repository.dart';
import 'package:distrito_medico/features/procedures/domain/usecases/create_procedure_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProcedureRepository extends Mock implements ProcedureRepository {}

void main() {
  late CreateProcedureUseCase useCase;
  late MockProcedureRepository mockRepository;

  setUp(() {
    mockRepository = MockProcedureRepository();
    useCase = CreateProcedureUseCase(mockRepository);
  });

  const tName = 'New Procedure';
  const tCode = '123';
  const tDescription = 'New Description';
  const tAmountCents = '1000';
  const tProcedure = ProcedureEntity(
    id: 1,
    name: tName,
    code: tCode,
    description: tDescription,
    amountCents: tAmountCents,
  );

  group('CreateProcedureUseCase', () {
    test('deve criar procedimento com sucesso', () async {
      // Arrange
      when(() => mockRepository.createProcedure(
            name: any(named: 'name'),
            code: any(named: 'code'),
            description: any(named: 'description'),
            amountCents: any(named: 'amountCents'),
          )).thenAnswer((_) async => const Right(tProcedure));

      // Act
      final result = await useCase(
        const CreateProcedureParams(
          name: tName,
          code: tCode,
          description: tDescription,
          amountCents: tAmountCents,
        ),
      );

      // Assert
      expect(result, const Right(tProcedure));
      verify(() => mockRepository.createProcedure(
            name: tName,
            code: tCode,
            description: tDescription,
            amountCents: tAmountCents,
          )).called(1);
    });

    test('deve retornar ValidationFailure quando nome for vazio', () async {
      // Act
      final result = await useCase(
        const CreateProcedureParams(
          name: '',
          code: tCode,
          description: tDescription,
          amountCents: tAmountCents,
        ),
      );

      // Assert
      expect(
        result,
        const Left(
            ValidationFailure(message: 'Nome do procedimento não pode ser vazio')),
      );
      verifyZeroInteractions(mockRepository);
    });
  });
}
