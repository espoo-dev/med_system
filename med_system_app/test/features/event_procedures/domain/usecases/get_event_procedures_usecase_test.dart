import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/event_procedures/domain/entities/event_procedure_entity.dart';
import 'package:distrito_medico/features/event_procedures/domain/entities/event_procedure_result_entity.dart';
import 'package:distrito_medico/features/event_procedures/domain/repositories/event_procedure_repository.dart';
import 'package:distrito_medico/features/event_procedures/domain/usecases/get_event_procedures_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEventProcedureRepository extends Mock
    implements EventProcedureRepository {}

void main() {
  late GetEventProceduresUseCase usecase;
  late MockEventProcedureRepository mockRepository;

  setUp(() {
    mockRepository = MockEventProcedureRepository();
    usecase = GetEventProceduresUseCase(mockRepository);
  });

  const tEventProceduresList = [
    EventProcedureEntity(id: 1, procedure: 'Consulta', patient: 'João'),
  ];
  const tEventProcedureResult = EventProcedureResultEntity(
    items: tEventProceduresList,
    total: '100.00',
    totalPaid: '50.00',
    totalUnpaid: '50.00',
  );

  test('should get event procedures from the repository', () async {
    // arrange
    when(() => mockRepository.getEventProcedures(
          page: 1,
          perPage: 10,
        )).thenAnswer((_) async => const Right(tEventProcedureResult));

    // act
    final result = await usecase(const GetEventProceduresParams(page: 1, perPage: 10));

    // assert
    expect(result, const Right(tEventProcedureResult));
    verify(() => mockRepository.getEventProcedures(page: 1, perPage: 10))
        .called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return a failure when the repository call is unsuccessful',
      () async {
    // arrange
    when(() => mockRepository.getEventProcedures(
          page: 1,
          perPage: 10,
        )).thenAnswer((_) async => const Left(ServerFailure(message: 'Server Error')));

    // act
    final result = await usecase(const GetEventProceduresParams(page: 1, perPage: 10));

    // assert
    expect(result, const Left(ServerFailure(message: 'Server Error')));
    verify(() => mockRepository.getEventProcedures(page: 1, perPage: 10))
        .called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
