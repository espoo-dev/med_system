import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';
import 'package:distrito_medico/features/patients/domain/repositories/patient_repository.dart';
import 'package:distrito_medico/features/patients/domain/usecases/get_all_patients_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPatientRepository extends Mock implements PatientRepository {}

void main() {
  late GetAllPatientsUseCase useCase;
  late MockPatientRepository mockRepository;

  setUp(() {
    mockRepository = MockPatientRepository();
    useCase = GetAllPatientsUseCase(mockRepository);
  });

  const tPatientList = [
    PatientEntity(id: 1, name: 'Patient 1', deletable: true),
    PatientEntity(id: 2, name: 'Patient 2', deletable: false),
  ];

  group('GetAllPatientsUseCase', () {
    test('deve retornar lista de pacientes quando sucesso', () async {
      // Arrange
      when(() => mockRepository.getAllPatients(
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer((_) async => const Right(tPatientList));

      // Act
      final result = await useCase(const GetAllPatientsParams());

      // Assert
      expect(result, const Right(tPatientList));
      verify(() => mockRepository.getAllPatients(page: 1, perPage: 10000))
          .called(1);
    });

    test('deve retornar ValidationFailure quando página for inválida', () async {
      // Act
      final result = await useCase(
        const GetAllPatientsParams(page: 0),
      );

      // Assert
      expect(
        result,
        const Left(ValidationFailure(message: 'Página deve ser maior que 0')),
      );
      verifyZeroInteractions(mockRepository);
    });

    test('deve retornar ServerFailure quando repositório falhar', () async {
      // Arrange
      when(() => mockRepository.getAllPatients(
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer(
        (_) async => const Left(ServerFailure(message: 'Erro no servidor')),
      );

      // Act
      final result = await useCase(const GetAllPatientsParams());

      // Assert
      expect(
        result,
        const Left(ServerFailure(message: 'Erro no servidor')),
      );
    });
  });
}
