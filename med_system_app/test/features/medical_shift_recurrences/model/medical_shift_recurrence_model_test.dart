import 'package:distrito_medico/features/medical_shift_recurrences/model/medical_shift_recurrence.model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MedicalShiftRecurrenceModel', () {
    test('should create model from JSON', () {
      // arrange
      final json = {
        'id': 1,
        'frequency': 'weekly',
        'day_of_week': 1,
        'day_of_month': null,
        'end_date': '2025-12-31',
        'workload': '12',
        'start_date': '2025-01-01',
        'amount_cents': 50000,
        'hospital_name': 'Hospital ABC',
        'start_hour': '08:00',
      };

      // act
      final model = MedicalShiftRecurrenceModel.fromJson(json);

      // assert
      expect(model.id, 1);
      expect(model.frequency, 'weekly');
      expect(model.dayOfWeek, 1);
      expect(model.dayOfMonth, null);
      expect(model.endDate, '2025-12-31');
      expect(model.workload, '12');
      expect(model.startDate, '2025-01-01');
      expect(model.amountCents, 50000);
      expect(model.hospitalName, 'Hospital ABC');
      expect(model.startHour, '08:00');
    });

    test('should convert model to JSON', () {
      // arrange
      final model = MedicalShiftRecurrenceModel(
        id: 1,
        frequency: 'monthly',
        dayOfWeek: null,
        dayOfMonth: 15,
        endDate: '2025-12-31',
        workload: '24',
        startDate: '2025-01-01',
        amountCents: 100000,
        hospitalName: 'Hospital XYZ',
        startHour: '19:00',
      );

      // act
      final json = model.toJson();

      // assert
      expect(json['id'], 1);
      expect(json['frequency'], 'monthly');
      expect(json['day_of_week'], null);
      expect(json['day_of_month'], 15);
      expect(json['end_date'], '2025-12-31');
      expect(json['workload'], '24');
      expect(json['start_date'], '2025-01-01');
      expect(json['amount_cents'], 100000);
      expect(json['hospital_name'], 'Hospital XYZ');
      expect(json['start_hour'], '19:00');
    });

    test('should handle null values', () {
      // arrange
      final json = <String, dynamic>{};

      // act
      final model = MedicalShiftRecurrenceModel.fromJson(json);

      // assert
      expect(model.id, null);
      expect(model.frequency, null);
      expect(model.dayOfWeek, null);
      expect(model.dayOfMonth, null);
      expect(model.endDate, null);
      expect(model.workload, null);
      expect(model.startDate, null);
      expect(model.amountCents, null);
      expect(model.hospitalName, null);
      expect(model.startHour, null);
    });

    test('should create model with constructor', () {
      // act
      final model = MedicalShiftRecurrenceModel(
        id: 2,
        frequency: 'daily',
        dayOfWeek: 3,
        dayOfMonth: 10,
        endDate: '2026-01-01',
        workload: '6',
        startDate: '2025-06-01',
        amountCents: 30000,
        hospitalName: 'Hospital Test',
        startHour: '14:00',
      );

      // assert
      expect(model.id, 2);
      expect(model.frequency, 'daily');
      expect(model.dayOfWeek, 3);
      expect(model.dayOfMonth, 10);
      expect(model.endDate, '2026-01-01');
      expect(model.workload, '6');
      expect(model.startDate, '2025-06-01');
      expect(model.amountCents, 30000);
      expect(model.hospitalName, 'Hospital Test');
      expect(model.startHour, '14:00');
    });

    test('should serialize and deserialize correctly', () {
      // arrange
      final originalModel = MedicalShiftRecurrenceModel(
        id: 5,
        frequency: 'weekly',
        dayOfWeek: 5,
        endDate: '2025-12-31',
        workload: '12',
        startDate: '2025-01-01',
        amountCents: 75000,
        hospitalName: 'Hospital Round Trip',
        startHour: '10:00',
      );

      // act
      final json = originalModel.toJson();
      final deserializedModel = MedicalShiftRecurrenceModel.fromJson(json);

      // assert
      expect(deserializedModel.id, originalModel.id);
      expect(deserializedModel.frequency, originalModel.frequency);
      expect(deserializedModel.dayOfWeek, originalModel.dayOfWeek);
      expect(deserializedModel.endDate, originalModel.endDate);
      expect(deserializedModel.workload, originalModel.workload);
      expect(deserializedModel.startDate, originalModel.startDate);
      expect(deserializedModel.amountCents, originalModel.amountCents);
      expect(deserializedModel.hospitalName, originalModel.hospitalName);
      expect(deserializedModel.startHour, originalModel.startHour);
    });
  });
}
