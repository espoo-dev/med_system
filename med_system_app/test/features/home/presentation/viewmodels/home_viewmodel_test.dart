import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/event_procedures/domain/entities/event_procedure_entity.dart';
import 'package:distrito_medico/features/event_procedures/domain/entities/event_procedure_list_entity.dart';
import 'package:distrito_medico/features/home/domain/usecases/get_latest_event_procedures_usecase.dart';
import 'package:distrito_medico/features/home/domain/usecases/get_latest_medical_shifts_usecase.dart';
import 'package:distrito_medico/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_entity.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_list_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetLatestEventProceduresUseCase extends Mock
    implements GetLatestEventProceduresUseCase {}

class MockGetLatestMedicalShiftsUseCase extends Mock
    implements GetLatestMedicalShiftsUseCase {}

void main() {
  late HomeViewModel viewModel;
  late MockGetLatestEventProceduresUseCase mockGetEventProceduresUseCase;
  late MockGetLatestMedicalShiftsUseCase mockGetMedicalShiftsUseCase;

  setUp(() {
    mockGetEventProceduresUseCase = MockGetLatestEventProceduresUseCase();
    mockGetMedicalShiftsUseCase = MockGetLatestMedicalShiftsUseCase();

    viewModel = HomeViewModel(
      mockGetEventProceduresUseCase,
      mockGetMedicalShiftsUseCase,
    );

    // Register fallback values
    registerFallbackValue(const GetLatestEventProceduresParams());
    registerFallbackValue(const GetLatestMedicalShiftsParams());
  });

  group('loadLatestEventProcedures', () {
    final tEventProcedures = [
      const EventProcedureEntity(
        id: 1,
        patient: 'João Silva',
        procedure: 'Consulta',
        hospital: 'Hospital ABC',
        totalAmountCents: '15000',
        paid: false,
      ),
      const EventProcedureEntity(
        id: 2,
        patient: 'Maria Santos',
        procedure: 'Exame',
        hospital: 'Hospital XYZ',
        totalAmountCents: '25000',
        paid: true,
      ),
    ];

    final tEventProcedureListEntity = EventProcedureListEntity(items: tEventProcedures);

    test('should load event procedures successfully', () async {
      // arrange
      when(() => mockGetEventProceduresUseCase(any()))
          .thenAnswer((_) async => Right(tEventProcedureListEntity));

      // act
      await viewModel.loadLatestEventProcedures();

      // assert
      expect(viewModel.eventProcedures.length, 2);
      expect(viewModel.eventProcedures, tEventProcedures);
      expect(viewModel.errorMessage, null);
      verify(() => mockGetEventProceduresUseCase(any())).called(1);
    });

    test('should set error message when loading fails', () async {
      // arrange
      const tFailure = ServerFailure(message: 'Server error');
      when(() => mockGetEventProceduresUseCase(any()))
          .thenAnswer((_) async => const Left(tFailure));

      // act
      await viewModel.loadLatestEventProcedures();

      // assert
      expect(viewModel.eventProcedures.length, 0);
      expect(viewModel.errorMessage, 'Server error');
    });
  });

  group('loadLatestMedicalShifts', () {
    final tMedicalShifts = [
      const MedicalShiftEntity(
        id: 1,
        hospitalName: 'Hospital ABC',
        workload: '12',
        startDate: '2025-12-10',
        startHour: '08:00',
        amountCents: '50000',
        paid: false,
        shift: 'Daytime',
      ),
    ];
    
    final tMedicalShiftListEntity = MedicalShiftListEntity(items: tMedicalShifts);

    test('should load medical shifts successfully', () async {
      // arrange
      when(() => mockGetMedicalShiftsUseCase(any()))
          .thenAnswer((_) async => Right(tMedicalShiftListEntity));

      // act
      await viewModel.loadLatestMedicalShifts();

      // assert
      expect(viewModel.medicalShifts.length, 1);
      expect(viewModel.medicalShifts, tMedicalShifts);
      expect(viewModel.errorMessage, null);
      verify(() => mockGetMedicalShiftsUseCase(any())).called(1);
    });

    test('should set error message when loading fails', () async {
      // arrange
      const tFailure = ServerFailure(message: 'Server error');
      when(() => mockGetMedicalShiftsUseCase(any()))
          .thenAnswer((_) async => const Left(tFailure));

      // act
      await viewModel.loadLatestMedicalShifts();

      // assert
      expect(viewModel.medicalShifts.length, 0);
      expect(viewModel.errorMessage, 'Server error');
    });
  });

  group('fetchAllData', () {
    final tEventProcedures = [
      const EventProcedureEntity(id: 1, patient: 'João'),
    ];
    final tMedicalShifts = [
      const MedicalShiftEntity(id: 1, hospitalName: 'Hospital ABC'),
    ];

    final tEventProcedureListEntity = EventProcedureListEntity(items: tEventProcedures);
    final tMedicalShiftListEntity = MedicalShiftListEntity(items: tMedicalShifts);

    test('should load both event procedures and medical shifts', () async {
      // arrange
      when(() => mockGetEventProceduresUseCase(any()))
          .thenAnswer((_) async => Right(tEventProcedureListEntity));
      when(() => mockGetMedicalShiftsUseCase(any()))
          .thenAnswer((_) async => Right(tMedicalShiftListEntity));

      // act
      await viewModel.fetchAllData();

      // assert
      expect(viewModel.eventProcedures.length, 1);
      expect(viewModel.medicalShifts.length, 1);
      expect(viewModel.isLoading, false);
      expect(viewModel.errorMessage, null);
      verify(() => mockGetEventProceduresUseCase(any())).called(1);
      verify(() => mockGetMedicalShiftsUseCase(any())).called(1);
    });

    test('should set isLoading to true while loading', () async {
      // arrange
      when(() => mockGetEventProceduresUseCase(any()))
          .thenAnswer((_) async => Right(tEventProcedureListEntity));
      when(() => mockGetMedicalShiftsUseCase(any()))
          .thenAnswer((_) async => Right(tMedicalShiftListEntity));

      // act
      final future = viewModel.fetchAllData();
      
      // assert (during loading)
      expect(viewModel.isLoading, true);
      
      await future;
      
      // assert (after loading)
      expect(viewModel.isLoading, false);
    });
  });

  group('setSelectedFilter', () {
    test('should change selected filter', () {
      // arrange
      expect(viewModel.selectedFilter, HomeFilterType.procedures);

      // act
      viewModel.setSelectedFilter(HomeFilterType.medicalShifts);

      // assert
      expect(viewModel.selectedFilter, HomeFilterType.medicalShifts);
    });
  });

  group('computed properties', () {
    test('hasData should return true when has event procedures', () {
      // arrange
      viewModel.eventProcedures.add(
        const EventProcedureEntity(id: 1, patient: 'João'),
      );

      // assert
      expect(viewModel.hasData, true);
    });

    test('hasData should return true when has medical shifts', () {
      // arrange
      viewModel.medicalShifts.add(
        const MedicalShiftEntity(id: 1, hospitalName: 'Hospital ABC'),
      );

      // assert
      expect(viewModel.hasData, true);
    });

    test('hasData should return false when empty', () {
      // assert
      expect(viewModel.hasData, false);
    });
  });
}
