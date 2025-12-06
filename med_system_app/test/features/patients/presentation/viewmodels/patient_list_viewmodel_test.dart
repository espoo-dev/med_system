import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/patients/domain/entities/patient_entity.dart';
import 'package:distrito_medico/features/patients/domain/usecases/delete_patient_usecase.dart';
import 'package:distrito_medico/features/patients/domain/usecases/get_all_patients_usecase.dart';
import 'package:distrito_medico/features/patients/presentation/viewmodels/patient_list_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAllPatientsUseCase extends Mock implements GetAllPatientsUseCase {}

class MockDeletePatientUseCase extends Mock implements DeletePatientUseCase {}

void main() {
  late PatientListViewModel viewModel;
  late MockGetAllPatientsUseCase mockGetAllPatientsUseCase;
  late MockDeletePatientUseCase mockDeletePatientUseCase;

  setUp(() {
    mockGetAllPatientsUseCase = MockGetAllPatientsUseCase();
    mockDeletePatientUseCase = MockDeletePatientUseCase();
    viewModel = PatientListViewModel(
      getAllPatientsUseCase: mockGetAllPatientsUseCase,
      deletePatientUseCase: mockDeletePatientUseCase,
    );
  });

  setUpAll(() {
    registerFallbackValue(const GetAllPatientsParams());
    registerFallbackValue(const DeletePatientParams(id: 0));
  });

  const tPatient = PatientEntity(id: 1, name: 'Test', deletable: true);
  const tList = [tPatient];

  group('PatientListViewModel', () {
    test('deve carregar pacientes com sucesso', () async {
      // Arrange
      when(() => mockGetAllPatientsUseCase(any()))
          .thenAnswer((_) async => const Right(tList));

      // Act
      await viewModel.loadPatients(refresh: true);

      // Assert
      expect(viewModel.state, PatientListState.success);
      expect(viewModel.patients, tList);
      expect(viewModel.patientsCount, 1);
    });

    test('deve deletar paciente com sucesso', () async {
      // Arrange
      viewModel.patients.add(tPatient);
      when(() => mockDeletePatientUseCase(any()))
          .thenAnswer((_) async => const Right(unit));

      // Act
      await viewModel.deletePatient(1);

      // Assert
      expect(viewModel.deleteState, DeletePatientState.success);
      expect(viewModel.patients, isEmpty);
    });

    test('deve tratar erro ao carregar pacientes', () async {
      // Arrange
      when(() => mockGetAllPatientsUseCase(any())).thenAnswer(
        (_) async => const Left(ServerFailure(message: 'Erro')),
      );

      // Act
      await viewModel.loadPatients(refresh: true);

      // Assert
      expect(viewModel.state, PatientListState.error);
      expect(viewModel.errorMessage, 'Erro');
    });
  });
}
