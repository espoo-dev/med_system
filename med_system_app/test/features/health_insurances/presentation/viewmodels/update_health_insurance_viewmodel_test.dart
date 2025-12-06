import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';
import 'package:distrito_medico/features/health_insurances/domain/usecases/update_health_insurance_usecase.dart';
import 'package:distrito_medico/features/health_insurances/presentation/viewmodels/update_health_insurance_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUpdateHealthInsuranceUseCase extends Mock
    implements UpdateHealthInsuranceUseCase {}

void main() {
  late UpdateHealthInsuranceViewModel viewModel;
  late MockUpdateHealthInsuranceUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockUpdateHealthInsuranceUseCase();
    viewModel = UpdateHealthInsuranceViewModel(
      updateHealthInsuranceUseCase: mockUseCase,
    );
    registerFallbackValue(
        const UpdateHealthInsuranceParams(id: 1, name: 'dummy'));
  });

  const tHealthInsurance = HealthInsuranceEntity(id: 1, name: 'Unimed');

  test('deve atualizar convênio com sucesso', () async {
    // Arrange
    when(() => mockUseCase(any()))
        .thenAnswer((_) async => const Right(tHealthInsurance));
    viewModel.setHealthInsurance(tHealthInsurance);
    viewModel.setName('Unimed Atualizada');

    // Act
    await viewModel.updateHealthInsurance();

    // Assert
    expect(viewModel.state, UpdateHealthInsuranceState.success);
    expect(viewModel.updatedHealthInsurance, tHealthInsurance);
  });

  test('deve tratar erro ao atualizar convênio', () async {
    // Arrange
    when(() => mockUseCase(any())).thenAnswer(
        (_) async => const Left(ServerFailure(message: 'Erro ao atualizar')));
    viewModel.setHealthInsurance(tHealthInsurance);
    viewModel.setName('Unimed Atualizada');

    // Act
    await viewModel.updateHealthInsurance();

    // Assert
    expect(viewModel.state, UpdateHealthInsuranceState.error);
    expect(viewModel.errorMessage, 'Erro ao atualizar');
  });

  test('não deve submeter se id for nulo', () async {
    // Act
    viewModel.setName('Unimed');
    await viewModel.updateHealthInsurance();

    // Assert
    expect(viewModel.state, UpdateHealthInsuranceState.idle);
    verifyZeroInteractions(mockUseCase);
  });
}
