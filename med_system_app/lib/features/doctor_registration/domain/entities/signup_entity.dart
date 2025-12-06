import 'package:equatable/equatable.dart';

/// Entidade de domínio para registro de médico
/// Representa o resultado do cadastro de um novo usuário médico
class SignUpEntity extends Equatable {
  final bool success;
  final String? message;

  const SignUpEntity({
    required this.success,
    this.message,
  });

  @override
  List<Object?> get props => [success, message];

  @override
  String toString() => 'SignUpEntity(success: $success, message: $message)';
}
