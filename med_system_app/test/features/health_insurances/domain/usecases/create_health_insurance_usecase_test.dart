import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';
import 'package:distrito_medico/features/health_insurances/domain/repositories/health_insurance_repository.dart';
import 'package:distrito_medico/features/health_insurances/domain/usecases/create_health_insurance_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHealthInsuranceRepository extends Mock
    implements HealthInsuranceRepository {}

void main() {
  late CreateHealthInsuranceUseCase useCase;
  late MockHealthInsuranceRepository mockRepository;

  setUp(() {
    mockRepository = MockHealthInsuranceRepository();
    useCase = CreateHealthInsuranceUseCase(mockRepository);
  });

  const tHealthInsurance = HealthInsuranceEntity(id: 1, name: 'Unimed');
  const tName = 'Unimed';

  test('deve criar convênio quando dados são válidos', () async {
    // Arrange
    when(() => mockRepository.createHealthInsurance(name: any(named: 'name')))
        .thenAnswer((_) async => const Right(tHealthInsurance));

    // Act
    final result = await useCase(const CreateHealthInsuranceParams(name: tName));

    // Assert
    expect(result, const Right(tHealthInsurance));
    verify(() => mockRepository.createHealthInsurance(name: tName)).called(1);
  });

  test('deve retornar ValidationFailure quando nome é vazio', () async {
    // Act
    final result = await useCase(const CreateHealthInsuranceParams(name: ''));

    // Assert
    expect(result, const Left(ValidationFailure(message: 'Nome não pode ser vazio')));
    verifyZeroInteractions(mockRepository);
  });
}
