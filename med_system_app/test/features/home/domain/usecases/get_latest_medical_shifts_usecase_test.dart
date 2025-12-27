import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/home/domain/repositories/home_repository.dart';
import 'package:distrito_medico/features/home/domain/usecases/get_latest_medical_shifts_usecase.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_entity.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_list_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late GetLatestMedicalShiftsUseCase useCase;
  late MockHomeRepository mockRepository;

  setUp(() {
    mockRepository = MockHomeRepository();
    useCase = GetLatestMedicalShiftsUseCase(mockRepository);
  });

  const tParams = GetLatestMedicalShiftsParams(page: 1, perPage: 3);

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
    const MedicalShiftEntity(
      id: 2,
      hospitalName: 'Hospital XYZ',
      workload: '24',
      startDate: '2025-12-11',
      startHour: '20:00',
      amountCents: '80000',
      paid: true,
      shift: 'Nighttime',
    ),
  ];
  
  final tMedicalShiftListEntity = MedicalShiftListEntity(items: tMedicalShifts);

  group('GetLatestMedicalShiftsUseCase', () {
    test('should get latest medical shifts from repository', () async {
      // arrange
      when(() => mockRepository.getLatestMedicalShifts(
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer((_) async => Right(tMedicalShiftListEntity));

      // act
      final result = await useCase(tParams);

      // assert
      expect(result, Right(tMedicalShiftListEntity));
      verify(() => mockRepository.getLatestMedicalShifts(
            page: tParams.page,
            perPage: tParams.perPage,
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return ServerFailure when repository fails', () async {
      // arrange
      const tFailure = ServerFailure(message: 'Server error');
      when(() => mockRepository.getLatestMedicalShifts(
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tParams);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getLatestMedicalShifts(
            page: tParams.page,
            perPage: tParams.perPage,
          )).called(1);
    });

    test('should use default parameters when not provided', () async {
      // arrange
      const tDefaultParams = GetLatestMedicalShiftsParams();
      when(() => mockRepository.getLatestMedicalShifts(
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer((_) async => Right(tMedicalShiftListEntity));

      // act
      await useCase(tDefaultParams);

      // assert
      verify(() => mockRepository.getLatestMedicalShifts(
            page: 1,
            perPage: 3,
          )).called(1);
    });
  });
}
