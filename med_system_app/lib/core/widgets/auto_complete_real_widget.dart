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

// Widget para a lista de sugestões
class SuggestionsList extends StatelessWidget {
  final List<String> suggestions;
  final ValueChanged<String> onSuggestionSelected;

  const SuggestionsList({
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

// Componente principal AutoCompleteReal
// ignore: must_be_immutable
class AutoCompleteReal extends StatefulWidget {
  final Key? key; // Adicionando a chave
  final Function? onSave;
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
  final bool? isCurrency;
  final double? fontSize;
  final List<TextInputFormatter>? inputFormatters;
  final List<String>? suggestions;

  AutoCompleteReal({
    this.key, // Adicionando a chave
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
    this.fontSize,
    this.isCurrency = false,
    this.suggestions,
    this.autofocus = false,
  });

  @override
  _AutoCompleteRealState createState() => _AutoCompleteRealState();
}

class _AutoCompleteRealState extends State<AutoCompleteReal> {
  late List<String> filteredSuggestions;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
    filteredSuggestions = widget.suggestions ?? [];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _filterSuggestions(String query) {
    setState(() {
      if (widget.isCurrency!) {
        if (query.isEmpty) {
          filteredSuggestions = [];
        } else {
          String cleanedQuery = query.replaceAll(RegExp(r'[^0-9]'), '');
          filteredSuggestions =
              addSpaceToCurrency(widget.suggestions!).where((suggestion) {
            String cleanedSuggestion =
                suggestion.replaceAll(RegExp(r'[^0-9]'), '');
            return cleanedSuggestion.contains(cleanedQuery);
          }).toList();
        }
      } else {
        filteredSuggestions = query.isEmpty
            ? []
            : widget.suggestions!
                .where((suggestion) =>
                    suggestion.toLowerCase().contains(query.toLowerCase()))
                .toList();
      }
    });
  }

  List<String> addSpaceToCurrency(List<String> amounts) {
    return amounts.map((amount) {
      return amount.replaceFirst("R\$", "R\$ ");
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          key: widget.key, // Adicionando a chave
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
            hintText: widget.placeholder,
          ),
        ),
        if (_controller.text.isNotEmpty && filteredSuggestions.isNotEmpty)
          SuggestionsList(
            suggestions: filteredSuggestions,
            onSuggestionSelected: (suggestion) {
              setState(() {
                _controller.text = suggestion;
                filteredSuggestions = [];
              });
              widget.onChanged?.call(suggestion);
            },
          ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
