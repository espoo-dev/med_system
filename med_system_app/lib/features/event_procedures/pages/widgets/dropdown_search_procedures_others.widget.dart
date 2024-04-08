import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/core/widgets/my_text_form_field.widget.dart';
import 'package:distrito_medico/features/procedures/model/procedure.model.dart';
import 'package:distrito_medico/features/procedures/util/real_input_format.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DropdownSearchProceduresOthers extends StatefulWidget {
  final List<Procedure> procedureList;
  final Procedure selectedProcedure;
  final Function(Procedure?) onChanged;

  const DropdownSearchProceduresOthers({
    super.key,
    required this.procedureList,
    required this.selectedProcedure,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DropdownSearchProceduresState createState() =>
      _DropdownSearchProceduresState();
}

class _DropdownSearchProceduresState
    extends State<DropdownSearchProceduresOthers> {
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    late String code;
    late String description;
    late String amountCents;
    return DropdownSearch<Procedure>(
      dropdownButtonProps: DropdownButtonProps(
        color: Theme.of(context).colorScheme.primary,
      ),
      dropdownBuilder: (context, selectedItem) {
        return Text(selectedItem?.name ?? "");
      },
      selectedItem: widget.selectedProcedure,
      popupProps: PopupProps.dialog(
        title: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Busque um procedimento",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        searchFieldProps: TextFieldProps(
          focusNode: _focusNode,
          decoration: InputDecoration(
            enabled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(style: BorderStyle.solid),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(style: BorderStyle.solid),
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              size: 20,
            ),
            hintText: "Nome procedimento ou código",
            hintStyle: const TextStyle(fontSize: 13),
          ),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        emptyBuilder: (context, text) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextFormField(
                      fontSize: 16,
                      label: 'Código do procedimento',
                      placeholder: 'Digite o código do procedimento',
                      inputType: TextInputType.text,
                      onChanged: (value) {
                        code = value;
                      },
                      validators: const {'required': true, 'minLength': 3},
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyTextFormField(
                      fontSize: 16,
                      label: 'Digite a descrição',
                      placeholder: 'Digite a descrição do procedimento',
                      inputType: TextInputType.text,
                      onChanged: (value) {
                        description = value;
                      },
                      validators: const {'required': true, 'minLength': 3},
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyTextFormField(
                      fontSize: 16,
                      label: 'Digite o valor',
                      placeholder: 'Digite o valor do procimento',
                      inputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        RealInputFormatter(moeda: true),
                      ],
                      onChanged: (value) {
                        amountCents = value;
                      },
                      validators: const {'required': true, 'minLength': 3},
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MyButtonWidget(
                        text: "Adicionar Procedimento",
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            widget.onChanged(Procedure(
                                id: null,
                                name: text,
                                description: description,
                                code: code,
                                amountCents: amountCents));
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        isFilterOnline: true,
        showSearchBox: true,
        searchDelay: const Duration(milliseconds: 200),
        itemBuilder: (context, item, isSelected) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              item.name ?? "",
              style: const TextStyle(fontSize: 20),
            ),
          );
        },
      ),
      items: widget.procedureList,
      itemAsString: (Procedure procedure) =>
          "${procedure.code} ${procedure.name}",
      onChanged: widget.onChanged,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                width: 1, color: Theme.of(context).colorScheme.primary),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          label: const Text(
            'Procedimento',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
