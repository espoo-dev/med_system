import 'package:distrito_medico/core/widgets/error.widget.dart';
import 'package:flutter/material.dart';

class ErrorRetryPage extends StatelessWidget {
  final VoidCallback onRetry;
  final String title;
  final String message;

  const ErrorRetryPage({
    super.key,
    required this.onRetry,
    this.title = 'Erro',
    this.message = 'Ocorreu um erro ao carregar os dados.',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ErrorRetryWidget(
        title,
        message,
        onRetry,
      ),
    );
  }
}
