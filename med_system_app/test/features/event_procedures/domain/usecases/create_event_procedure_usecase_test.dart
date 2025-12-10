import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/features/event_procedures/domain/entities/event_procedure_entity.dart';
import 'package:distrito_medico/features/event_procedures/domain/repositories/event_procedure_repository.dart';
import 'package:distrito_medico/features/event_procedures/domain/usecases/create_event_procedure_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEventProcedureRepository extends Mock
    implements EventProcedureRepository {}

void main() {
  late CreateEventProcedureUseCase usecase;
  late MockEventProcedureRepository mockRepository;

  setUp(() {
    mockRepository = MockEventProcedureRepository();
    usecase = CreateEventProcedureUseCase(mockRepository);
  });

  const tParams = CreateEventProcedureParams(
    hospitalId: 1,
    patientServiceNumber: '12345',
    date: '2025-12-10',
    roomType: 'Enfermaria',
    urgency: false,
    paid: false,
    healthInsuranceAttributes: {'name': 'Unimed'},
    patientAttributes: {'name': 'João Silva'},
    procedureAttributes: {'name': 'Consulta'},
  );

  const tEventProcedure = EventProcedureEntity(
    id: 1,
    patient: 'João Silva',
    procedure: 'Consulta',
    hospital: 'Hospital ABC',
  );

  test('should create event procedure from repository', () async {
    // arrange
    when(() => mockRepository.createEventProcedure(
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
    verify(() => mockRepository.createEventProcedure(
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
    const tFailure = ServerFailure(message: 'Server error');
    when(() => mockRepository.createEventProcedure(
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
