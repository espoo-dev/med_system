import 'package:dartz/dartz.dart';
import 'package:distrito_medico/features/procedures/domain/entities/procedure_entity.dart';
import 'package:distrito_medico/features/procedures/domain/usecases/create_procedure_usecase.dart';
import 'package:distrito_medico/features/procedures/presentation/viewmodels/create_procedure_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateProcedureUseCase extends Mock
    implements CreateProcedureUseCase {}

void main() {
  late CreateProcedureViewModel viewModel;
  late MockCreateProcedureUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockCreateProcedureUseCase();
    viewModel = CreateProcedureViewModel(createProcedureUseCase: mockUseCase);
  });

  setUpAll(() {
    registerFallbackValue(const CreateProcedureParams(
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

  group('CreateProcedureViewModel', () {
    test('deve criar procedimento com sucesso', () async {
      // Arrange
      viewModel.setName('Test');
      viewModel.setCode('123');
      viewModel.setDescription('Desc');
      viewModel.setAmountCents('1000');
      when(() => mockUseCase(any()))
          .thenAnswer((_) async => const Right(tProcedure));

      // Act
      await viewModel.createProcedure();

      // Assert
      expect(viewModel.state, CreateProcedureState.success);
      expect(viewModel.createdProcedure, tProcedure);
    });

    test('deve validar dados corretamente', () {
      viewModel.setName('');
      viewModel.setCode('');
      viewModel.setAmountCents('');
      expect(viewModel.canSubmit, false);

      viewModel.setName('Test');
      viewModel.setCode('123');
      viewModel.setAmountCents('1000');
      expect(viewModel.canSubmit, true);
    });

    test('deve limpar valor antes de enviar', () async {
      // Arrange
      viewModel.setName('Test');
      viewModel.setCode('123');
      viewModel.setDescription('Desc');
      viewModel.setAmountCents('R\$ 1.000,00');
      
      when(() => mockUseCase(any())).thenAnswer((invocation) async {
        final params = invocation.positionalArguments[0] as CreateProcedureParams;
        expect(params.amountCents, '100000'); // Assumindo que remove tudo não numérico
        return const Right(tProcedure);
      });

      // Act
      await viewModel.createProcedure();
    });
  });
}
