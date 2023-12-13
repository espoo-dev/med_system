import 'package:flutter/material.dart';

class ProceduresPage extends StatefulWidget {
  const ProceduresPage({super.key});

  @override
  State<ProceduresPage> createState() => _ProceduresPageState();
}

class _ProceduresPageState extends State<ProceduresPage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Stack(
        children: [
          Center(
            child: Text("Procedimentos"),
          )
        ],
      ),
    );
  }
}
