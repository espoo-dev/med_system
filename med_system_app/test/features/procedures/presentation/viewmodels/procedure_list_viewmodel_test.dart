import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/procedures/domain/entities/procedure_entity.dart';
import 'package:distrito_medico/features/procedures/domain/usecases/get_all_procedures_usecase.dart';
import 'package:distrito_medico/features/procedures/presentation/viewmodels/procedure_list_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAllProceduresUseCase extends Mock
    implements GetAllProceduresUseCase {}

void main() {
  late ProcedureListViewModel viewModel;
  late MockGetAllProceduresUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetAllProceduresUseCase();
    viewModel = ProcedureListViewModel(getAllProceduresUseCase: mockUseCase);
  });

  setUpAll(() {
    registerFallbackValue(const GetAllProceduresParams());
  });

  const tProcedure = ProcedureEntity(
    id: 1,
    name: 'Test',
    code: '123',
    description: 'Desc',
    amountCents: '1000',
  );
  const tList = [tProcedure];

  group('ProcedureListViewModel', () {
    test('deve carregar procedimentos com sucesso', () async {
      // Arrange
      when(() => mockUseCase(any()))
          .thenAnswer((_) async => const Right(tList));

      // Act
      await viewModel.loadProcedures(refresh: true);

      // Assert
      expect(viewModel.state, ProcedureListState.success);
      expect(viewModel.procedures, tList);
      expect(viewModel.proceduresCount, 1);
    });

    test('deve tratar erro ao carregar procedimentos', () async {
      // Arrange
      when(() => mockUseCase(any())).thenAnswer(
        (_) async => const Left(ServerFailure(message: 'Erro')),
      );

      // Act
      await viewModel.loadProcedures(refresh: true);

      // Assert
      expect(viewModel.state, ProcedureListState.error);
      expect(viewModel.errorMessage, 'Erro');
    });
  });
}
