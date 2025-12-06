import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/doctor_registration/domain/entities/signup_entity.dart';
import 'package:distrito_medico/features/doctor_registration/domain/repositories/signup_repository.dart';
import 'package:equatable/equatable.dart';

/// Use Case para registrar um novo médico
class SignUpUseCase implements UseCase<SignUpEntity, SignUpParams> {
  final SignUpRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, SignUpEntity>> call(SignUpParams params) async {
    // Validações
    if (params.email.trim().isEmpty) {
      return const Left(
        ValidationFailure(message: 'Email não pode ser vazio'),
      );
    }

    if (!_isValidEmail(params.email)) {
      return const Left(
        ValidationFailure(message: 'Email inválido'),
      );
    }

    if (params.password.trim().isEmpty) {
      return const Left(
        ValidationFailure(message: 'Senha não pode ser vazia'),
      );
    }

    if (params.password.length < 6) {
      return const Left(
        ValidationFailure(message: 'Senha deve ter no mínimo 6 caracteres'),
      );
    }

    if (params.password != params.confirmPassword) {
      return const Left(
        ValidationFailure(message: 'As senhas não coincidem'),
      );
    }

    return await repository.signUp(
      email: params.email,
      password: params.password,
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    return emailRegex.hasMatch(email);
  }
}

/// Parâmetros para o SignUpUseCase
class SignUpParams extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;

  const SignUpParams({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [email, password, confirmPassword];
}
