import 'package:distrito_medico/core/theme/animations.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/widgets/my_button_widget.dart';
import 'package:distrito_medico/features/event_procedures/pages/add_event_procedure_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyPageEventsProcedure extends StatelessWidget {
  const EmptyPageEventsProcedure({super.key});

  @override
  Widget build(BuildContext context) {
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
                      child: Lottie.asset(animationEventProcedure,
                          height: 250, width: 250),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Center(
                      child: Text(
                        "Você não possui eventos procedimentos cadastrados.",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    MyButtonWidget(
                        text: 'Cadastrar novo evento',
                        disabledColor: Colors.grey,
                        onTap: () {
                          push(
                              context,
                              const AddEventProcedurePage(
                                backToHome: true,
                              ));
                        })
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
