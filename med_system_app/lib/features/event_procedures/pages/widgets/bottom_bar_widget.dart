import 'package:flutter/material.dart';

class BottomAppBarContent extends StatefulWidget {
  final String total;
  final String totalUnpayd;
  final String totalPayd;

  const BottomAppBarContent({
    super.key,
    required this.total,
    required this.totalUnpayd,
    required this.totalPayd,
  });

  @override
  State<BottomAppBarContent> createState() => _BottomAppBarContentState();
}

class _BottomAppBarContentState extends State<BottomAppBarContent> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.0,
      color: Colors.white,
      child: BottomAppBar(
        elevation: 0.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    widget.total,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'A Receber',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    widget.totalUnpayd,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Recebidos',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    widget.totalPayd,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
