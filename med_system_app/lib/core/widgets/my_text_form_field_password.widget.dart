import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Classe Validator para centralizar a lógica de validação
class Validator {
  static String? validate(
      String validatorKey, dynamic validatorValue, String value) {
    switch (validatorKey) {
      case 'required':
        return RequiredValidator.validate(validatorValue, value);
      case 'minLength':
        return MinLengthValidator.validate(validatorValue, value);
      case 'maxLength':
        return MaxLengthValidator.validate(validatorValue, value);
      case 'regex':
        return RegexValidator.validate(validatorValue, value);
      case 'matchPasswordWith':
        return MatchPasswordValidator.validate(validatorValue, value);
      default:
        return null;
    }
  }
}

// Validador para campo obrigatório
class RequiredValidator {
  static String? validate(bool validatorValue, String value) {
    if (validatorValue && value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }
}

// Validador para comprimento mínimo
class MinLengthValidator {
  static String? validate(int validatorValue, String value) {
    if (value.length < validatorValue) {
      return 'Tamanho mínimo $validatorValue';
    }
    return null;
  }
}

// Validador para comprimento máximo
class MaxLengthValidator {
  static String? validate(int validatorValue, String value) {
    if (value.length > validatorValue) {
      return 'Tamanho máximo $validatorValue';
    }
    return null;
  }
}

// Validador de expressão regular
class RegexValidator {
  static String? validate(String validatorValue, String value) {
    if (!RegExp(validatorValue).hasMatch(value)) {
      return 'Formato inválido';
    }
    return null;
  }
}

// Validador para conferir senhas
class MatchPasswordValidator {
  static String? validate(String validatorValue, String value) {
    if (validatorValue != value) {
      return 'As senhas não conferem';
    }
    return null;
  }
}

// ignore: must_be_immutable
class MyTextFormFieldPassword extends StatefulWidget {
  Function? onSave;
  String? label;
  String? placeholder;
  Function? validation;
  TextInputType? inputType;
  String? initialValue;
  bool? readOnly;
  bool? autoValidate;
  Map<String, dynamic>? validators;
  Function? onChanged;
  int? maxLength;
  bool? obscureText;
  bool? autofocus;
  List<TextInputFormatter>? inputFormatters;
  double? fontSize;
  // ignore: use_key_in_widget_constructors
  MyTextFormFieldPassword(
      {Key? key,
      this.onSave,
      required this.label,
      required this.placeholder,
      this.validation,
      required this.inputType,
      this.initialValue,
      this.readOnly = false,
      this.autoValidate = false,
      this.validators,
      this.onChanged,
      this.maxLength,
      this.obscureText = false,
      this.inputFormatters,
      this.autofocus = false,
      this.fontSize});

  @override
  // ignore: library_private_types_in_public_api
  _MyTextFormFieldPasswordState createState() =>
      _MyTextFormFieldPasswordState();
}

class _MyTextFormFieldPasswordState extends State<MyTextFormFieldPassword> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          keyboardType: widget.inputType,
          autocorrect: true,
          initialValue: widget.initialValue,
          readOnly: widget.readOnly ?? false,
          onChanged: widget.onChanged ?? funcEmpty(),
          obscureText: !_showPassword,
          autofocus: widget.autofocus ?? false,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters ?? [],
          enabled: true,
          style: TextStyle(fontSize: widget.fontSize ?? 12),
          onSaved: widget.onSave ?? funcEmpty(),
          validator: (String? value) {
            if (widget.validators == null) return null;

            String? error;
            widget.validators?.entries.forEach((val) {
              error ??= Validator.validate(val.key, val.value, value ?? "");
            });

            return error;
          },
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                _toggleVisibility();
              },
              child: Icon(
                _showPassword ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            fillColor: Theme.of(context).colorScheme.primary,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 1, color: Theme.of(context).colorScheme.primary),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  funcEmpty() {}

  void _toggleVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
}
