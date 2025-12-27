import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';

/// Classe base abstrata para todos os Use Cases
/// R = Return type (tipo de retorno)
/// P = Params type (tipo de parâmetros)
abstract class UseCase<R, P> {
  /// Executa o caso de uso
  Future<Either<Failure, R>> call(P params);
}

/// Classe usada quando um Use Case não precisa de parâmetros
class NoParams {
  const NoParams();
}
