import 'package:dartz/dartz.dart';
import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';
import 'package:distrito_medico/features/health_insurances/domain/repositories/health_insurance_repository.dart';
import 'package:distrito_medico/features/health_insurances/domain/usecases/get_all_health_insurances_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHealthInsuranceRepository extends Mock
    implements HealthInsuranceRepository {}

void main() {
  late GetAllHealthInsurancesUseCase useCase;
  late MockHealthInsuranceRepository mockRepository;

  setUp(() {
    mockRepository = MockHealthInsuranceRepository();
    useCase = GetAllHealthInsurancesUseCase(mockRepository);
  });

  final tHealthInsurances = [
    const HealthInsuranceEntity(id: 1, name: 'Unimed'),
    const HealthInsuranceEntity(id: 2, name: 'Bradesco'),
  ];

  test('deve obter lista de convênios do repositório', () async {
    // Arrange
    when(() => mockRepository.getAllHealthInsurances(
          page: any(named: 'page'),
          perPage: any(named: 'perPage'),
        )).thenAnswer((_) async => Right(tHealthInsurances));

    // Act
    final result = await useCase(const GetAllHealthInsurancesParams());

    // Assert
    expect(result, Right(tHealthInsurances));
    verify(() => mockRepository.getAllHealthInsurances(page: 1, perPage: 10))
        .called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
