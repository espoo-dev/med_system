/// Model para a requisição de login
class SignInRequestModel {
  final String email;
  final String password;

  const SignInRequestModel({
    required this.email,
    required this.password,
  });

  /// Converte o SignInRequestModel para JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
