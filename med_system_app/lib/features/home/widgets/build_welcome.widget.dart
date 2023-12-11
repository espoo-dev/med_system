import 'package:flutter/material.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({
    super.key,
  });

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RichText(
            maxLines: 20,
            softWrap: true,
            text: TextSpan(
              children: <TextSpan>[
                const TextSpan(
                    text: 'Olá!',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 30,
                    )),
                TextSpan(
                    text: '\nEveline 👋',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 30,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
