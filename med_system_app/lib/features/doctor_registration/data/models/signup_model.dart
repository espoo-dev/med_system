import 'package:distrito_medico/features/doctor_registration/domain/entities/signup_entity.dart';

/// Model para resposta de cadastro
class SignUpModel extends SignUpEntity {
  const SignUpModel({
    required super.success,
    super.message,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      success: json['success'] ?? true,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      if (message != null) 'message': message,
    };
  }

  SignUpEntity toEntity() {
    return SignUpEntity(
      success: success,
      message: message,
    );
  }

  factory SignUpModel.fromEntity(SignUpEntity entity) {
    return SignUpModel(
      success: entity.success,
      message: entity.message,
    );
  }
}
