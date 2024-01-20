import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            // ignore: prefer_typing_uninitialized_variables
            var error;
            // ignore: avoid_function_literals_in_foreach_calls
            widget.validators?.entries.forEach((val) {
              error ??= getError(val.key, val.value, value ?? "");
            });
            return error;
          },
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
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

  getError(String validatorKey, dynamic validatorValue, String value) {
    switch (validatorKey) {
      case 'required':
        if (validatorValue == true && value.isEmpty) {
          return 'Campo obrigatório';
        }
        break;
      case 'minLength':
        if (value.length < validatorValue) {
          return 'Tamanho mínimo $validatorValue';
        }
        break;
      case 'maxLength':
        if (value.length > validatorValue) {
          return 'Tamanho máximo $validatorValue';
        }
        break;
      case 'regex':
        if (!RegExp(validatorValue).hasMatch(value)) {
          return 'Formato inválido';
        }
        break;
      case 'matchPasswordWith':
        if (validatorValue != value) {
          return 'As senhas não conferem';
        }
        break;
      default:
        return "";
    }
  }

  funcEmpty() {}
}
