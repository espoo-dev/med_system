import 'package:dartz/dartz.dart';
import 'package:distrito_medico/core/errors/failures.dart';
import 'package:distrito_medico/core/usecases/usecase.dart';
import 'package:distrito_medico/features/auth/domain/entities/user_entity.dart';
import 'package:distrito_medico/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

/// Parâmetros para o SignInUseCase
class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

/// Use Case responsável por realizar o login
/// Contém as regras de negócio de autenticação
class SignInUseCase implements UseCase<UserEntity, SignInParams> {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignInParams params) async {
    // Validação de email
    if (params.email.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Email não pode ser vazio'),
      );
    }

    // Validação básica de formato de email
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!emailRegex.hasMatch(params.email)) {
      return const Left(
        ValidationFailure(message: 'Email inválido'),
      );
    }

    // Validação de senha
    if (params.password.isEmpty) {
      return const Left(
        ValidationFailure(message: 'Senha não pode ser vazia'),
      );
    }

    if (params.password.length < 4) {
      return const Left(
        ValidationFailure(message: 'Senha deve ter no mínimo 4 caracteres'),
      );
    }

    // Se as validações passarem, chama o repository
    return await repository.signIn(
      email: params.email,
      password: params.password,
    );
  }
}
