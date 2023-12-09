import 'package:flutter/material.dart';

class MyButtonWidget extends StatefulWidget {
  final String? text;
  final Function? onTap;
  final bool? isLoading;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? disabledColor;
  final Color? textColor;

  const MyButtonWidget(
      {super.key,
      @required this.text,
      @required this.onTap,
      this.isLoading = false,
      this.height,
      this.width,
      this.backgroundColor,
      this.disabledColor,
      this.textColor});

  @override
  State<MyButtonWidget> createState() => _MyButtonWidgetState();
}

class _MyButtonWidgetState extends State<MyButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 50,
      child: ElevatedButton(
          onPressed: widget.isLoading ?? true ? functionEmpty() : widget.onTap,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return widget.backgroundColor ??
                      Theme.of(context).colorScheme.secondary;
                } else if (states.contains(MaterialState.disabled)) {
                  return widget.disabledColor ??
                      Theme.of(context).colorScheme.secondary;
                }
                return widget.backgroundColor ??
                    Theme.of(context).colorScheme.primary;
              },
            ),
          ),
          child: widget.isLoading ?? false
              ? Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor:
                              const AlwaysStoppedAnimation(Colors.white),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          strokeWidth: 2,
                        ),
                      )
                    ],
                  ),
                )
              : Text(
                  widget.text ?? "",
                  style: TextStyle(color: widget.textColor ?? Colors.white),
                )),
    );
  }

  functionEmpty() {}
}
