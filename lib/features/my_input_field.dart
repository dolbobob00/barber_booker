import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyInputField extends StatefulWidget {
  MyInputField(
      {super.key,
      this.focusNode,
      this.textEditingController,
      this.secureText,
      this.prefix,
      this.labelText,
      this.suffix,
      this.underTextField,
      this.icon});
  final FocusNode? focusNode;
  bool? secureText;
  final String? labelText;
  final Widget? icon;
  final Widget? suffix;
  final Widget? underTextField;
  final Widget? prefix;
  final TextEditingController? textEditingController;

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  @override
  Widget build(BuildContext context) {
    final themeof = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            focusNode: widget.focusNode,
            obscureText: widget.secureText ?? false,
            controller: widget.textEditingController,
            style: themeof.textTheme.labelMedium!.copyWith(
              color: themeof.colorScheme.inversePrimary,
            ),
            decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  25,
                ),
              ),
              contentPadding: const EdgeInsets.all(
                8,
              ),
              labelStyle: themeof.textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
              prefixIcon: widget.prefix,
              suffixIcon: widget.suffix,
              labelText: widget.labelText,
              suffix: widget.icon != null
                  ? InkWell(
                      splashColor: const Color(0x4C4A4848),
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        if (widget.secureText != null) {
                          setState(() {
                            widget.secureText = !widget.secureText!;
                          });
                        }
                      },
                      child: widget.icon,
                    )
                  //  IconButton(
                  //     color: themeof.colorScheme.secondary,
                  //     onPressed: () {
                  //       if (widget.secureText != null) {
                  //         setState(() {
                  //           widget.secureText = !widget.secureText!;
                  //         });
                  //       }
                  //     },
                  //     icon: widget.icon!,
                  //   )
                  : null,
            ),
          ),
          widget.underTextField ?? Container(),
        ],
      ),
    );
  }
}
