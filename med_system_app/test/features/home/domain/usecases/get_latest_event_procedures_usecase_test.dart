import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/event_procedures/domain/entities/event_procedure_entity.dart';
import 'package:distrito_medico/features/event_procedures/domain/entities/event_procedure_list_entity.dart';
import 'package:distrito_medico/features/home/domain/repositories/home_repository.dart';
import 'package:distrito_medico/features/home/domain/usecases/get_latest_event_procedures_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late GetLatestEventProceduresUseCase useCase;
  late MockHomeRepository mockRepository;

  setUp(() {
    mockRepository = MockHomeRepository();
    useCase = GetLatestEventProceduresUseCase(mockRepository);
  });

  const tParams = GetLatestEventProceduresParams(page: 1, perPage: 3);

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

  group('GetLatestEventProceduresUseCase', () {
    test('should get latest event procedures from repository', () async {
      // arrange
      when(() => mockRepository.getLatestEventProcedures(
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer((_) async => Right(tEventProcedureListEntity));

      // act
      final result = await useCase(tParams);

      // assert
      expect(result, Right(tEventProcedureListEntity));
      verify(() => mockRepository.getLatestEventProcedures(
            page: tParams.page,
            perPage: tParams.perPage,
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return ServerFailure when repository fails', () async {
      // arrange
      const tFailure = ServerFailure(message: 'Server error');
      when(() => mockRepository.getLatestEventProcedures(
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer((_) async => const Left(tFailure));

      // act
      final result = await useCase(tParams);

      // assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.getLatestEventProcedures(
            page: tParams.page,
            perPage: tParams.perPage,
          )).called(1);
    });

    test('should use default parameters when not provided', () async {
      // arrange
      const tDefaultParams = GetLatestEventProceduresParams();
      when(() => mockRepository.getLatestEventProcedures(
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
          )).thenAnswer((_) async => Right(tEventProcedureListEntity));

      // act
      await useCase(tDefaultParams);

      // assert
      verify(() => mockRepository.getLatestEventProcedures(
            page: 1,
            perPage: 3,
          )).called(1);
    });
  });
}
