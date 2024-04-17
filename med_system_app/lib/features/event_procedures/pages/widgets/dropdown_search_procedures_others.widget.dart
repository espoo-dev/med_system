import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/features/procedures/model/procedure.model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

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
    return DropdownSearch<Procedure>(
      dropdownButtonProps: DropdownButtonProps(
        color: Theme.of(context).colorScheme.primary,
      ),
      dropdownBuilder: (context, selectedItem) {
        return Text(selectedItem?.name ?? "");
      },
      selectedItem: widget.selectedProcedure,
      popupProps: PopupProps.dialog(
        dialogProps: const DialogProps(backgroundColor: Colors.white),
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
              child: MyButtonWidget(
                text: "Adicionar Procedimento",
                onTap: () {
                  widget.onChanged(Procedure(
                    id: null,
                    name: text,
                  ));
                  Navigator.pop(context);
                },
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
