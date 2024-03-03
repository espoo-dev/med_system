import 'dart:async';

import 'package:distrito_medico/core/theme/animations.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessPage extends StatelessWidget {
  final String title;
  final Widget goToPage;

  const SuccessPage({super.key, required this.title, required this.goToPage});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      to(context, goToPage);
    });

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Lottie.asset(animationSuccess,
                          height: 250, width: 250),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
