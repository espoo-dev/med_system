import 'package:flutter/material.dart';
import 'package:med_system_app/core/model/ui/menu_item.model.dart';

class HorizontalMenuWidget extends StatefulWidget {
  final List<MenuItemModel> menuItems;
  final EdgeInsets? titlePadding;
  const HorizontalMenuWidget({
    super.key,
    required this.menuItems,
    this.titlePadding,
  });

  @override
  State<HorizontalMenuWidget> createState() => _HorizontalMenuWidgetState();
}

class _HorizontalMenuWidgetState extends State<HorizontalMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.menuItems.length,
            itemBuilder: (BuildContext context, int index) {
              MenuItemModel item = widget.menuItems[index];
              return Container(
                width: MediaQuery.of(context).size.width * 0.35,
                height: 150,
                margin: EdgeInsets.fromLTRB(
                    20, 0, index == widget.menuItems.length - 1 ? 20 : 0, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: item.backgroundColor,
                    foregroundColor: Colors.white,
                    elevation: 1.0,
                    shadowColor: Colors.yellow[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: item.image,
                        ),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item.label,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item.description ?? "",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    if (item.action == null) return;
                    // ignore: void_checks
                    return item.action!();
                  },
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
