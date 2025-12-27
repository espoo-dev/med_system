import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('teste de igualdade de failures', () {
    const f1 = Left(ServerFailure(message: 'Erro'));
    const f2 = Left(ServerFailure(message: 'Erro'));
    expect(f1, f2);
  });
}
