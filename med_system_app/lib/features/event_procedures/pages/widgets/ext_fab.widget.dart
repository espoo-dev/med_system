import 'package:flutter/material.dart';
import 'package:med_system_app/core/utils/navigation_utils.dart';
import 'package:med_system_app/features/event_procedures/pages/add_event_procedure_page.dart';

Widget buildExtendedFAB(BuildContext context) => AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
      width: 150,
      height: 50,
      child: FloatingActionButton.extended(
        onPressed: () {
          to(context, const AddEventProcedurePage());
        },
        icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
        label: Center(
          child: Text(
            "Novo evento",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
    );
