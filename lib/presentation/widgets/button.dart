import 'package:flutter/material.dart';
import 'package:invman/presentation/theme/theme.dart';

class ButtonWidget extends StatelessWidget {

  final Widget child;
  final VoidCallback  onPressed;
  final Color?  color;
  // final Gradient gradient;
  ButtonWidget({
    required this.onPressed,
    required this.child,
    this.color,
    // required this.gradient
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      splashColor: Colors.white,
      color: color?? AppColors.mainColor,
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Ink(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child:
        Container(
            constraints: const BoxConstraints(
                maxWidth: 200.0,
                minHeight: 50.0),
            alignment: Alignment.center,
            child: child
        ),
      ),
    );
  }
}