import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:med_system_app/features/procedures/model/procedure.model.dart';
import 'package:med_system_app/features/procedures/store/procedure.store.dart';

class AddEventProcedurePage extends StatefulWidget {
  const AddEventProcedurePage({super.key});

  @override
  State<AddEventProcedurePage> createState() => _AddEventProcedureState();
}

class _AddEventProcedureState extends State<AddEventProcedurePage> {
  final procedureStore = GetIt.I.get<ProcedureStore>();

  @override
  void initState() {
    super.initState();
    procedureStore.getAllProcedures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo evento'),
        centerTitle: true,
      ),
      body: Center(
          child: DropdownSearch<Procedure>(
        dropdownButtonProps:
            DropdownButtonProps(color: Theme.of(context).colorScheme.primary),
        dropdownBuilder: (context, selectedItem) {
          return Text(
            selectedItem?.name ?? "",
          );
        },
        popupProps: PopupProps.dialog(
          title: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Busque um procedimento",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
          ),
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              enabled: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(style: BorderStyle.solid)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(style: BorderStyle.solid)),
              prefixIcon: const Icon(
                Icons.search_rounded,
                size: 20,
              ),
              hintText: "Ex: Cesariana (feto único ou múltiplo)",
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
                "Procedimento não encontrado",
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
        items: procedureStore.procedureList,
        itemAsString: (Procedure u) => u.name ?? "",
        onChanged: (Procedure? data) => debugPrint(data.toString()),
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            label: Text(
              'Procedimento',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
      )),
    );
  }
}
