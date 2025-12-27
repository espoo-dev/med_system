import 'package:flutter/material.dart';
import 'package:distrito_medico/features/medical_shifts/domain/entities/medical_shift_entity.dart';

extension MedicalShiftEntityDisplay on MedicalShiftEntity {
  Icon get shiftIcon {
    if (shift == "Daytime") {
      return const Icon(size: 24.0, Icons.wb_sunny, color: Colors.orange);
    } else {
      return const Icon(size: 24.0, Icons.nightlight_round, color: Colors.blueGrey);
    }
  }

  String get shiftDescription {
    return (shift == "Daytime") ? "Diurno" : "Noturno";
  }
}
