import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

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

class RequiredValidator {
  static String? validate(bool validatorValue, String value) {
    if (validatorValue && value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }
}

class MinLengthValidator {
  static String? validate(int validatorValue, String value) {
    if (value.length < validatorValue) {
      return 'Tamanho mínimo $validatorValue';
    }
    return null;
  }
}

class MaxLengthValidator {
  static String? validate(int validatorValue, String value) {
    if (value.length > validatorValue) {
      return 'Tamanho máximo $validatorValue';
    }
    return null;
  }
}

class RegexValidator {
  static String? validate(String validatorValue, String value) {
    if (!RegExp(validatorValue).hasMatch(value)) {
      return 'Formato inválido';
    }
    return null;
  }
}

class MatchPasswordValidator {
  static String? validate(String validatorValue, String value) {
    if (validatorValue != value) {
      return 'As senhas não conferem';
    }
    return null;
  }
}

// ignore: must_be_immutable
class MyTextFormField extends StatefulWidget {
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
  double? fontSize;
  List<TextInputFormatter>? inputFormatters;
  MyTextFormField(
      // ignore: avoid_init_to_null
      {super.key,
      // ignore: avoid_init_to_null
      this.onSave = null,
      @required this.label,
      @required this.placeholder,
      // ignore: avoid_init_to_null
      this.validation = null,
      @required this.inputType,
      this.initialValue,
      this.readOnly = false,
      this.autoValidate = false,
      this.validators,
      this.onChanged,
      this.maxLength,
      this.obscureText = false,
      this.inputFormatters,
      this.fontSize,
      this.autofocus = false});

  @override
  // ignore: library_private_types_in_public_api
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
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
          obscureText: widget.obscureText ?? false,
          autofocus: widget.autofocus ?? false,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters ?? [],
          enabled: true,
          onSaved: widget.onSave ?? funcEmpty(),
          style: TextStyle(fontSize: widget.fontSize ?? 12),
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
}
