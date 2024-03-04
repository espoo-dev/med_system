import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/features/patients/model/patient.model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropdownSearchPatients extends StatefulWidget {
  final List<Patient> patientList;
  final Patient selectedPatient;
  final Function(Patient?) onChanged;

  const DropdownSearchPatients({
    super.key,
    required this.patientList,
    required this.selectedPatient,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DropdownSearchPatientsState createState() => _DropdownSearchPatientsState();
}

class _DropdownSearchPatientsState extends State<DropdownSearchPatients> {
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Patient>(
      dropdownButtonProps: DropdownButtonProps(
        color: Theme.of(context).colorScheme.primary,
      ),
      dropdownBuilder: (context, selectedItem) {
        return Text(selectedItem?.name ?? "");
      },
      selectedItem: widget.selectedPatient,
      popupProps: PopupProps.dialog(
        title: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Busque um paciente",
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
            hintText: "Ex: Roberto",
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
                  "Paciente não encontrado",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MyButtonWidget(
                    text: "Adicionar paciente",
                    onTap: () {
                      widget.onChanged(Patient(id: null, name: text));
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
        interceptCallBacks: true,
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
      items: widget.patientList,
      itemAsString: (Patient patient) => patient.name ?? "",
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
            'Paciente',
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
