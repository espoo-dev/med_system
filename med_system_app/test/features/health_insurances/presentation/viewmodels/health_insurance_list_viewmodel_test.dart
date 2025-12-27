import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';
import 'package:distrito_medico/features/health_insurances/domain/usecases/get_all_health_insurances_usecase.dart';
import 'package:distrito_medico/features/health_insurances/presentation/viewmodels/health_insurance_list_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAllHealthInsurancesUseCase extends Mock
    implements GetAllHealthInsurancesUseCase {}

void main() {
  late HealthInsuranceListViewModel viewModel;
  late MockGetAllHealthInsurancesUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetAllHealthInsurancesUseCase();
    viewModel = HealthInsuranceListViewModel(
      getAllHealthInsurancesUseCase: mockUseCase,
    );
    registerFallbackValue(const GetAllHealthInsurancesParams());
  });

  const tHealthInsurance = HealthInsuranceEntity(id: 1, name: 'Unimed');
  final tList = [tHealthInsurance];

  test('deve carregar lista com sucesso', () async {
    // Arrange
    when(() => mockUseCase(any())).thenAnswer((_) async => Right(tList));

    // Act
    await viewModel.loadHealthInsurances();

    // Assert
    expect(viewModel.state, HealthInsuranceListState.success);
    expect(viewModel.healthInsurances, tList);
    expect(viewModel.errorMessage, '');
  });

  test('deve tratar erro ao carregar lista', () async {
    // Arrange
    when(() => mockUseCase(any())).thenAnswer(
        (_) async => const Left(ServerFailure(message: 'Erro ao carregar')));

    // Act
    await viewModel.loadHealthInsurances();

    // Assert
    expect(viewModel.state, HealthInsuranceListState.error);
    expect(viewModel.errorMessage, 'Erro ao carregar');
  });
}
