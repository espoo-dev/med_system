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
class AutoCompleteTextField extends StatefulWidget {
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
  List<String>? suggestions;

  AutoCompleteTextField(
      {super.key,
      this.onSave,
      @required this.label,
      @required this.placeholder,
      this.validation,
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
      this.suggestions,
      this.autofocus = false});

  @override
  // ignore: library_private_types_in_public_api
  _AutoCompleteTextFieldState createState() => _AutoCompleteTextFieldState();
}

class _AutoCompleteTextFieldState extends State<AutoCompleteTextField> {
  List<String> filteredSuggestions = [];
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue ?? '';
    filteredSuggestions = widget.suggestions ?? [];
  }

  void _filterSuggestions(String query) {
    if (widget.suggestions != null) {
      setState(() {
        if (query.isEmpty) {
          filteredSuggestions = [];
        } else {
          filteredSuggestions = widget.suggestions!
              .where((suggestion) =>
                  suggestion.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: _controller,
          keyboardType: widget.inputType,
          autocorrect: true,
          readOnly: widget.readOnly ?? false,
          onChanged: (value) {
            widget.onChanged?.call(value);
            _filterSuggestions(value);
          },
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
        if (filteredSuggestions.isNotEmpty)
          Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              height: 100,
              child: ListView.builder(
                itemCount: filteredSuggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredSuggestions[index]),
                    onTap: () {
                      setState(() {
                        _controller.text = filteredSuggestions[index];

                        Future.delayed(const Duration(milliseconds: 200), () {
                          setState(() {
                            filteredSuggestions = [];
                          });
                        });
                      });
                      widget.onChanged?.call(filteredSuggestions[index]);
                    },
                  );
                },
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
