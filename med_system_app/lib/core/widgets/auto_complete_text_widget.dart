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
  final void Function(String?)? onSave;
  final String? label;
  final String? placeholder;
  final Function? validation;
  final TextInputType? inputType;
  final String? initialValue;
  final bool? readOnly;
  final bool? autoValidate;
  final Map<String, dynamic>? validators;
  final Function? onChanged;
  final int? maxLength;
  final bool? obscureText;
  final bool? autofocus;
  final double? fontSize;
  final List<TextInputFormatter>? inputFormatters;
  final List<String>? suggestions;

  const AutoCompleteTextField({
    super.key,
    this.onSave,
    this.label,
    this.placeholder,
    this.validation,
    this.inputType,
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
    this.autofocus = false,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AutoCompleteTextFieldState createState() => _AutoCompleteTextFieldState();
}

class _AutoCompleteTextFieldState extends State<AutoCompleteTextField> {
  late ValueNotifier<List<String>> _filteredSuggestions;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue ?? '';
    _filteredSuggestions = ValueNotifier(widget.suggestions ?? []);
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    _filterSuggestions(_controller.text);
  }

  void _filterSuggestions(String query) {
    if (widget.suggestions != null) {
      _filteredSuggestions.value = query.isEmpty
          ? []
          : widget.suggestions!
              .where((suggestion) =>
                  suggestion.toLowerCase().contains(query.toLowerCase()))
              .toList();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _filteredSuggestions.dispose();
    super.dispose();
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
          },
          obscureText: widget.obscureText ?? false,
          autofocus: widget.autofocus ?? false,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters ?? [],
          enabled: true,
          onSaved: widget.onSave, // Pass the function directly
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
        ValueListenableBuilder<List<String>>(
          valueListenable: _filteredSuggestions,
          builder: (context, suggestions, child) {
            return suggestions.isNotEmpty
                ? SuggestionsList(
                    suggestions: suggestions,
                    onSuggestionSelected: (suggestion) {
                      setState(() {
                        _controller.text = suggestion;
                        _filteredSuggestions.value = [];
                      });
                      widget.onChanged?.call(suggestion);
                    },
                  )
                : const SizedBox.shrink();
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class SuggestionsList extends StatelessWidget {
  final List<String> suggestions;
  final ValueChanged<String> onSuggestionSelected;

  const SuggestionsList({super.key, 
    required this.suggestions,
    required this.onSuggestionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        height: 100,
        child: ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(suggestions[index]),
              onTap: () {
                onSuggestionSelected(suggestions[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
