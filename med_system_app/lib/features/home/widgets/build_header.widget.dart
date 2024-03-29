import 'package:distrito_medico/core/theme/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderHomeWidget extends StatefulWidget {
  final VoidCallback?
      onMenuPressed; // Parâmetro de função de retorno de chamada

  const HeaderHomeWidget({
    super.key,
    this.onMenuPressed,
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
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (widget.onMenuPressed != null) {
                    widget.onMenuPressed!();
                  }
                },
                child: SvgPicture.asset(
                  iconMenuHomeAsset,
                  width: 24,
                  height: 18,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset(
                iconLogoAsset,
                width: 50,
                height: 50,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
