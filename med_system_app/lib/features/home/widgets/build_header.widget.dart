import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:med_system_app/core/theme/icons.dart';

class HeaderHomeWidget extends StatefulWidget {
  const HeaderHomeWidget({
    super.key,
  });
  @override
  State<HeaderHomeWidget> createState() => _HeaderHomeWidgetState();
}

class _HeaderHomeWidgetState extends State<HeaderHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SvgPicture.asset(
            iconLogoAsset,
            width: 50,
            height: 50,
            color: Theme.of(context).colorScheme.primary,
          ),
          Row(
            children: [
              InkWell(
                onTap: () async {},
                child: SvgPicture.asset(
                  iconMenuHomeAsset,
                  width: 24,
                  height: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
