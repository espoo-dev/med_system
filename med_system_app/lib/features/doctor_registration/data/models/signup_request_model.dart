/// Model para requisição de cadastro
class SignUpRequestModel {
  final String email;
  final String password;

  const SignUpRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
