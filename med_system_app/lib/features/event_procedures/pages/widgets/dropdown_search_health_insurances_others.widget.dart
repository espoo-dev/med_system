import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/features/health_insurances/model/health_insurances.model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropdownHealthInsurancesOthers extends StatefulWidget {
  final List<HealthInsurance> healthInsuranceList;
  final HealthInsurance selectedHealthInsurance;
  final Function(HealthInsurance?) onChanged;

  const DropdownHealthInsurancesOthers({
    super.key,
    required this.healthInsuranceList,
    required this.selectedHealthInsurance,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DropdownHealthInsurancesState createState() =>
      _DropdownHealthInsurancesState();
}

class _DropdownHealthInsurancesState
    extends State<DropdownHealthInsurancesOthers> {
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<HealthInsurance>(
      dropdownButtonProps: DropdownButtonProps(
        color: Theme.of(context).colorScheme.primary,
      ),
      dropdownBuilder: (context, selectedItem) {
        return Text(selectedItem?.name ?? "");
      },
      selectedItem: widget.selectedHealthInsurance,
      popupProps: PopupProps.dialog(
        dialogProps: const DialogProps(backgroundColor: Colors.white),
        title: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Busque um convênio",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        searchFieldProps: TextFieldProps(
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
            hintText: "Ex: Convênio.",
            hintStyle: const TextStyle(fontSize: 13),
          ),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        emptyBuilder: (context, text) {
          return Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                const Text(
                  "Convênio não encontrado",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MyButtonWidget(
                    text: "Adicionar Convênio",
                    onTap: () {
                      widget.onChanged(HealthInsurance(id: null, name: text));
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
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
      items: widget.healthInsuranceList,
      itemAsString: (HealthInsurance hospital) => hospital.name ?? "",
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
            'Convênio',
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
