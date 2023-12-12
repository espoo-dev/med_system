import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:med_system_app/core/theme/icons.dart';

class ListEventsWidget extends StatefulWidget {
  final List<EventItem> items;

  const ListEventsWidget({super.key, required this.items});

  @override
  State<ListEventsWidget> createState() => _ListEventsWidgetState();
}

class _ListEventsWidgetState extends State<ListEventsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              const Text("Últimos Eventos",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  )),
              const Spacer(),
              InkWell(
                  child: Text(
                'Ver todos',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary),
              )),
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
                EventItem item = widget.items[index];
                debugPrint(widget.items.length.toString());
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width * 0.28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: const Color(0xFFECF2F3),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(item.name,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              )),
                          const SizedBox(width: 15),
                          Text(item.value,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              )),
                        ],
                      ),
                      leading: SvgPicture.asset(
                        iconCheckCoreAsset,
                        width: 18,
                        height: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onTap: () {},
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

class EventItem {
  final String name;
  final String value;

  const EventItem({
    required this.name,
    required this.value,
  });
}
