import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:med_system_app/features/hospitals/model/hospital.model.dart';

class DropdownSearchHospitals extends StatefulWidget {
  final List<Hospital> hospitalList;
  final Hospital selectedHospital;
  final Function(Hospital?) onChanged;

  const DropdownSearchHospitals({
    super.key,
    required this.hospitalList,
    required this.selectedHospital,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DropdownSearchHospitalState createState() => _DropdownSearchHospitalState();
}

class _DropdownSearchHospitalState extends State<DropdownSearchHospitals> {
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Hospital>(
      dropdownButtonProps: DropdownButtonProps(
        color: Theme.of(context).colorScheme.primary,
      ),
      dropdownBuilder: (context, selectedItem) {
        return Text(selectedItem?.name ?? "");
      },
      selectedItem: widget.selectedHospital,
      popupProps: PopupProps.dialog(
        title: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Busque um hospital",
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
            hintText: "Ex: Hospital.",
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
              "Hospital não encontrado",
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
      items: widget.hospitalList,
      itemAsString: (Hospital hospital) => hospital.name ?? "",
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
            'Hospital',
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
