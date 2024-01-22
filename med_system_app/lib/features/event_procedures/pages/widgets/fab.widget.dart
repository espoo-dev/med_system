import 'package:flutter/material.dart';
import 'package:med_system_app/core/utils/navigation_utils.dart';
import 'package:med_system_app/features/event_procedures/pages/add_event_procedure_page.dart';

Widget buildFAB(BuildContext context) => AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
      width: 50,
      height: 50,
      child: FloatingActionButton.extended(
        onPressed: () {
          to(context, const AddEventProcedurePage());
        },
        icon: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(
            Icons.edit,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        label: const SizedBox(),
      ),
    );
