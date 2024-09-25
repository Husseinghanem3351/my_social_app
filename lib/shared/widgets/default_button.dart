import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({super.key,required this.onTap, required this.buttonWidget});
  final void Function()? onTap;
  final Widget buttonWidget;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all( 10.0),
        child: Center(child: buttonWidget,)

    ));
  }
}
