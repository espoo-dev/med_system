import 'package:flutter/material.dart';

class ErrorRetryWidget extends StatefulWidget {
  final String? title;
  final String? message;
  final Function? function;

  const ErrorRetryWidget(this.title, this.message, this.function, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ErrorWidgetState createState() => _ErrorWidgetState();
}

class _ErrorWidgetState extends State<ErrorRetryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.title ?? '',
            style: const TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.message ?? '',
            style: const TextStyle(
                color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          OutlinedButton.icon(
            label: const Text('Tentar novamente'),
            icon: const Icon(Icons.refresh),
            onPressed: widget.function ?? functionEmpty(),
          )
        ],
      ),
    );
  }

  functionEmpty() {
    debugPrint('function empty');
  }
}
