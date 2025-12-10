import 'package:distrito_medico/core/theme/icons.dart';
import 'package:distrito_medico/core/utils/navigation_utils.dart';
import 'package:distrito_medico/core/utils/utils.dart';
import 'package:distrito_medico/features/event_procedures/model/event_procedure.model.dart';
import 'package:distrito_medico/features/event_procedures/domain/entities/event_procedure_entity.dart';
import 'package:distrito_medico/features/event_procedures/pages/edit_event_procedure_page.dart';
import 'package:distrito_medico/features/event_procedures/pages/event_procedures_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListEventsWidget extends StatefulWidget {
  final List<EventProcedures> items;

  const ListEventsWidget({super.key, required this.items});

  @override
  State<ListEventsWidget> createState() => _ListEventsWidgetState();
}

class _ListEventsWidgetState extends State<ListEventsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              const Text("Últimos procedimentos",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  )),
              const Spacer(),
              InkWell(
                onTap: () {
                  push(context, const EventProceduresPage());
                },
                child: Text(
                  'Ver todos',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.28,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                EventProcedures item = widget.items[index];
                String iconAsset =
                    item.paid! ? iconCheckCoreAsset : iconCloseCoreAsset;

                Color iconColor = item.paid!
                    ? Theme.of(context).colorScheme.primary
                    : const Color(0xFFED7290);

                Color textColor = item.paid!
                    ? Theme.of(context).colorScheme.primary
                    : const Color(0xFFED7290);

                return Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: const Color(0xFFECF2F3),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(
                            item.procedure?.toString().truncate() ?? "",
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            item.totalAmountCents ?? "",
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      leading: SvgPicture.asset(iconAsset,
                          width: 18,
                          height: 18,
                          colorFilter: ColorFilter.mode(
                            iconColor,
                            BlendMode.srcIn,
                          )),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 18.0,
                        color: iconColor,
                      ),
                      onTap: () {
                        // Convert EventProcedures model to EventProcedureEntity
                        final entity = EventProcedureEntity(
                          id: item.id,
                          procedure: item.procedure,
                          patient: item.patient,
                          hospital: item.hospital,
                          healthInsurance: item.healthInsurance,
                          patientServiceNumber: item.patientServiceNumber,
                          date: item.date,
                          roomType: item.roomType,
                          urgency: item.urgency,
                          paidAt: item.paidAt,
                          paid: item.paid,
                          totalAmountCents: item.totalAmountCents,
                          payment: item.payment,
                          procedureValue: item.procedureValue,
                          procedureDescription: item.precedureDescription,
                        );
                        
                        push(
                            context,
                            EditEventProcedurePage(
                              eventProcedure: entity,
                              backToHome: true,
                            ));
                      },
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
