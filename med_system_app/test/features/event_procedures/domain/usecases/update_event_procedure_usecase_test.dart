import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/event_procedures/domain/entities/event_procedure_entity.dart';
import 'package:distrito_medico/features/event_procedures/domain/repositories/event_procedure_repository.dart';
import 'package:distrito_medico/features/event_procedures/domain/usecases/update_event_procedure_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEventProcedureRepository extends Mock
    implements EventProcedureRepository {}

void main() {
  late UpdateEventProcedureUseCase usecase;
  late MockEventProcedureRepository mockRepository;

  setUp(() {
    mockRepository = MockEventProcedureRepository();
    usecase = UpdateEventProcedureUseCase(mockRepository);
  });

  const tParams = UpdateEventProcedureParams(
    id: 1,
    hospitalId: 2,
    patientServiceNumber: '54321',
    date: '2025-12-15',
    roomType: 'Apartamento',
    urgency: true,
    paid: true,
    healthInsuranceAttributes: {'name': 'Bradesco'},
    patientAttributes: {'name': 'Maria Santos'},
    procedureAttributes: {'name': 'Cirurgia'},
  );

  const tEventProcedure = EventProcedureEntity(
    id: 1,
    patient: 'Maria Santos',
    procedure: 'Cirurgia',
    hospital: 'Hospital XYZ',
  );

  test('should update event procedure from repository', () async {
    // arrange
    when(() => mockRepository.updateEventProcedure(
          id: any(named: 'id'),
          hospitalId: any(named: 'hospitalId'),
          patientServiceNumber: any(named: 'patientServiceNumber'),
          date: any(named: 'date'),
          roomType: any(named: 'roomType'),
          urgency: any(named: 'urgency'),
          paidAt: any(named: 'paidAt'),
          paid: any(named: 'paid'),
          payment: any(named: 'payment'),
          healthInsuranceAttributes: any(named: 'healthInsuranceAttributes'),
          patientAttributes: any(named: 'patientAttributes'),
          procedureAttributes: any(named: 'procedureAttributes'),
        )).thenAnswer((_) async => const Right(tEventProcedure));

    // act
    final result = await usecase(tParams);

    // assert
    expect(result, const Right(tEventProcedure));
    verify(() => mockRepository.updateEventProcedure(
          id: tParams.id,
          hospitalId: tParams.hospitalId,
          patientServiceNumber: tParams.patientServiceNumber,
          date: tParams.date,
          roomType: tParams.roomType,
          urgency: tParams.urgency,
          paidAt: tParams.paidAt,
          paid: tParams.paid,
          payment: tParams.payment,
          healthInsuranceAttributes: tParams.healthInsuranceAttributes,
          patientAttributes: tParams.patientAttributes,
          procedureAttributes: tParams.procedureAttributes,
        )).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when repository fails', () async {
    // arrange
    const tFailure = ServerFailure(message: 'Update failed');
    when(() => mockRepository.updateEventProcedure(
          id: any(named: 'id'),
          hospitalId: any(named: 'hospitalId'),
          patientServiceNumber: any(named: 'patientServiceNumber'),
          date: any(named: 'date'),
          roomType: any(named: 'roomType'),
          urgency: any(named: 'urgency'),
          paidAt: any(named: 'paidAt'),
          paid: any(named: 'paid'),
          payment: any(named: 'payment'),
          healthInsuranceAttributes: any(named: 'healthInsuranceAttributes'),
          patientAttributes: any(named: 'patientAttributes'),
          procedureAttributes: any(named: 'procedureAttributes'),
        )).thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await usecase(tParams);

    // assert
    expect(result, const Left(tFailure));
  });
}
