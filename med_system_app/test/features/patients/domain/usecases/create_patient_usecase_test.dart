import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';
import 'package:distrito_medico/features/patients/domain/repositories/patient_repository.dart';
import 'package:distrito_medico/features/patients/domain/usecases/create_patient_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPatientRepository extends Mock implements PatientRepository {}

void main() {
  late CreatePatientUseCase useCase;
  late MockPatientRepository mockRepository;

  setUp(() {
    mockRepository = MockPatientRepository();
    useCase = CreatePatientUseCase(mockRepository);
  });

  const tName = 'New Patient';
  const tPatient = PatientEntity(id: 1, name: tName, deletable: true);

  group('CreatePatientUseCase', () {
    test('deve criar paciente com sucesso', () async {
      // Arrange
      when(() => mockRepository.createPatient(name: any(named: 'name')))
          .thenAnswer((_) async => const Right(tPatient));

      // Act
      final result = await useCase(const CreatePatientParams(name: tName));

      // Assert
      expect(result, const Right(tPatient));
      verify(() => mockRepository.createPatient(name: tName)).called(1);
    });

    test('deve retornar ValidationFailure quando nome for vazio', () async {
      // Act
      final result = await useCase(const CreatePatientParams(name: ''));

      // Assert
      expect(
        result,
        const Left(
            ValidationFailure(message: 'Nome do paciente não pode ser vazio')),
      );
      verifyZeroInteractions(mockRepository);
    });

    test('deve retornar ValidationFailure quando nome for muito curto',
        () async {
      // Act
      final result = await useCase(const CreatePatientParams(name: 'Ab'));

      // Assert
      expect(
        result,
        const Left(ValidationFailure(
            message: 'Nome do paciente deve ter no mínimo 3 caracteres')),
      );
      verifyZeroInteractions(mockRepository);
    });
  });
}
