import 'package:dartz/dartz.dart';
import 'package:distrito_medico/features/procedures/domain/entities/procedure_entity.dart';
import 'package:distrito_medico/features/procedures/domain/usecases/update_procedure_usecase.dart';
import 'package:distrito_medico/features/procedures/presentation/viewmodels/update_procedure_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUpdateProcedureUseCase extends Mock
    implements UpdateProcedureUseCase {}

void main() {
  late UpdateProcedureViewModel viewModel;
  late MockUpdateProcedureUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockUpdateProcedureUseCase();
    viewModel = UpdateProcedureViewModel(updateProcedureUseCase: mockUseCase);
  });

  setUpAll(() {
    registerFallbackValue(const UpdateProcedureParams(
      id: 0,
      name: '',
      code: '',
      description: '',
      amountCents: '',
    ));
  });

  const tProcedure = ProcedureEntity(
    id: 1,
    name: 'Test',
    code: '123',
    description: 'Desc',
    amountCents: '1000',
  );

  group('UpdateProcedureViewModel', () {
    test('deve atualizar procedimento com sucesso', () async {
      // Arrange
      viewModel.loadProcedure(tProcedure);
      viewModel.setName('Updated Name');
      when(() => mockUseCase(any()))
          .thenAnswer((_) async => const Right(tProcedure));

      // Act
      await viewModel.updateProcedure();

      // Assert
      expect(viewModel.state, UpdateProcedureState.success);
      expect(viewModel.updatedProcedure, tProcedure);
    });

    test('deve validar dados corretamente', () {
      viewModel.reset();
      expect(viewModel.canSubmit, false);

      viewModel.setProcedureId(1);
      viewModel.setName('Test');
      viewModel.setCode('123');
      viewModel.setAmountCents('1000');
      expect(viewModel.canSubmit, true);
    });
  });
}
