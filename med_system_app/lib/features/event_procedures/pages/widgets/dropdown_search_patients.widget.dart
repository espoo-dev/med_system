import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:med_system_app/features/patients/model/patient.model.dart';

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
          return const Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Paciente não encontrado",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          );
        },
        isFilterOnline: true,
        showSearchBox: true,
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