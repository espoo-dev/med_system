import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';
import 'package:distrito_medico/features/health_insurances/domain/usecases/create_health_insurance_usecase.dart';
import 'package:distrito_medico/features/health_insurances/presentation/viewmodels/create_health_insurance_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateHealthInsuranceUseCase extends Mock
    implements CreateHealthInsuranceUseCase {}

void main() {
  late CreateHealthInsuranceViewModel viewModel;
  late MockCreateHealthInsuranceUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockCreateHealthInsuranceUseCase();
    viewModel = CreateHealthInsuranceViewModel(
      createHealthInsuranceUseCase: mockUseCase,
    );
    registerFallbackValue(const CreateHealthInsuranceParams(name: 'dummy'));
  });

  const tHealthInsurance = HealthInsuranceEntity(id: 1, name: 'Unimed');

  test('deve criar convênio com sucesso', () async {
    // Arrange
    when(() => mockUseCase(any()))
        .thenAnswer((_) async => const Right(tHealthInsurance));
    viewModel.setName('Unimed');

    // Act
    await viewModel.createHealthInsurance();

    // Assert
    expect(viewModel.state, CreateHealthInsuranceState.success);
    expect(viewModel.createdHealthInsurance, tHealthInsurance);
  });

  test('deve tratar erro ao criar convênio', () async {
    // Arrange
    when(() => mockUseCase(any())).thenAnswer(
        (_) async => const Left(ServerFailure(message: 'Erro ao criar')));
    viewModel.setName('Unimed');

    // Act
    await viewModel.createHealthInsurance();

    // Assert
    expect(viewModel.state, CreateHealthInsuranceState.error);
    expect(viewModel.errorMessage, 'Erro ao criar');
  });

  test('não deve submeter se nome for vazio', () async {
    // Act
    viewModel.setName('');
    await viewModel.createHealthInsurance();

    // Assert
    expect(viewModel.state, CreateHealthInsuranceState.idle);
    verifyZeroInteractions(mockUseCase);
  });
}
