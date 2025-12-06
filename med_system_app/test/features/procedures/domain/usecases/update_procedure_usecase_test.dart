import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/procedures/domain/entities/procedure_entity.dart';
import 'package:distrito_medico/features/procedures/domain/repositories/procedure_repository.dart';
import 'package:distrito_medico/features/procedures/domain/usecases/update_procedure_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProcedureRepository extends Mock implements ProcedureRepository {}

void main() {
  late UpdateProcedureUseCase useCase;
  late MockProcedureRepository mockRepository;

  setUp(() {
    mockRepository = MockProcedureRepository();
    useCase = UpdateProcedureUseCase(mockRepository);
  });

  const tId = 1;
  const tName = 'Updated Procedure';
  const tCode = '123';
  const tDescription = 'Updated Description';
  const tAmountCents = '1000';
  const tProcedure = ProcedureEntity(
    id: tId,
    name: tName,
    code: tCode,
    description: tDescription,
    amountCents: tAmountCents,
  );

  group('UpdateProcedureUseCase', () {
    test('deve atualizar procedimento com sucesso', () async {
      // Arrange
      when(() => mockRepository.updateProcedure(
            id: any(named: 'id'),
            name: any(named: 'name'),
            code: any(named: 'code'),
            description: any(named: 'description'),
            amountCents: any(named: 'amountCents'),
          )).thenAnswer((_) async => const Right(tProcedure));

      // Act
      final result = await useCase(
        const UpdateProcedureParams(
          id: tId,
          name: tName,
          code: tCode,
          description: tDescription,
          amountCents: tAmountCents,
        ),
      );

      // Assert
      expect(result, const Right(tProcedure));
      verify(() => mockRepository.updateProcedure(
            id: tId,
            name: tName,
            code: tCode,
            description: tDescription,
            amountCents: tAmountCents,
          )).called(1);
    });

    test('deve retornar ValidationFailure quando ID for inválido', () async {
      // Act
      final result = await useCase(
        const UpdateProcedureParams(
          id: 0,
          name: tName,
          code: tCode,
          description: tDescription,
          amountCents: tAmountCents,
        ),
      );

      // Assert
      expect(
        result,
        const Left(ValidationFailure(message: 'ID do procedimento inválido')),
      );
      verifyZeroInteractions(mockRepository);
    });
  });
}
