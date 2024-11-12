import 'package:barber_booker/features/neuro_wrapper.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      this.buttonBackgroundColor,
      required this.func,
      required this.text,
      this.height,
      this.width});
  final VoidCallback func;
  final String text;
  final double? width;
  final double? height;
  final Color? buttonBackgroundColor;
  @override
  Widget build(BuildContext context) {
    return NeuroWrapper(
      color: buttonBackgroundColor,
      widget: InkWell(
        splashColor: Theme.of(context).colorScheme.inversePrimary,
        onTap: func,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: width,
            height: height,
            child: Center(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 22,
                    ),
              ),
            ),
          ),
        ),
      ),
      shape: NeumorphicBoxShape.roundRect(
        BorderRadius.circular(15),
      ),
    );
  }
}
