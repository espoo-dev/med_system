import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/health_insurances/domain/entities/health_insurance_entity.dart';
import 'package:distrito_medico/features/health_insurances/domain/repositories/health_insurance_repository.dart';
import 'package:distrito_medico/features/health_insurances/domain/usecases/update_health_insurance_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHealthInsuranceRepository extends Mock
    implements HealthInsuranceRepository {}

void main() {
  late UpdateHealthInsuranceUseCase useCase;
  late MockHealthInsuranceRepository mockRepository;

  setUp(() {
    mockRepository = MockHealthInsuranceRepository();
    useCase = UpdateHealthInsuranceUseCase(mockRepository);
  });

  const tHealthInsurance = HealthInsuranceEntity(id: 1, name: 'Unimed Atualizada');
  const tId = 1;
  const tName = 'Unimed Atualizada';

  test('deve atualizar convênio quando dados são válidos', () async {
    // Arrange
    when(() => mockRepository.updateHealthInsurance(
          id: any(named: 'id'),
          name: any(named: 'name'),
        )).thenAnswer((_) async => const Right(tHealthInsurance));

    // Act
    final result = await useCase(
        const UpdateHealthInsuranceParams(id: tId, name: tName));

    // Assert
    expect(result, const Right(tHealthInsurance));
    verify(() => mockRepository.updateHealthInsurance(id: tId, name: tName))
        .called(1);
  });

  test('deve retornar ValidationFailure quando id é inválido', () async {
    // Act
    final result = await useCase(
        const UpdateHealthInsuranceParams(id: 0, name: tName));

    // Assert
    expect(result, const Left(ValidationFailure(message: 'ID inválido')));
    verifyZeroInteractions(mockRepository);
  });

  test('deve retornar ValidationFailure quando nome é vazio', () async {
    // Act
    final result = await useCase(
        const UpdateHealthInsuranceParams(id: tId, name: ''));

    // Assert
    expect(result, const Left(ValidationFailure(message: 'Nome não pode ser vazio')));
    verifyZeroInteractions(mockRepository);
  });
}
