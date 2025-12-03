import 'package:flutter/material.dart';

/// Shows a dialog for deleting a recurrent medical shift
/// Returns: null if cancelled, true if delete all, false if delete only this one
Future<bool?> showDeleteRecurrenceDialog({
  required BuildContext context,
}) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: const Text('Excluir Plantão Recorrente'),
        content: const Text(
          'Este plantão faz parte de uma recorrência. O que deseja fazer?',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(null); // Cancelled
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Delete only this one
            },
            child: const Text('Somente este plantão'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Delete all
            },
            child: const Text('Excluir todos'),
          ),
        ],
      );
    },
  );
}
