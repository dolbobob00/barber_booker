import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive/hive.dart';

class NeuroWrapper extends StatelessWidget {
  const NeuroWrapper(
      {super.key, required this.widget, required this.shape, this.color});
  final Widget widget;
  final NeumorphicBoxShape shape;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        intensity: Hive.box('app_settings').get('isLight') ? 0.66 : 0.46,
        surfaceIntensity: 0.8,
        oppositeShadowLightSource: true,
        shadowLightColor: Hive.box('app_settings').get('isLight')
            ? const Color.fromRGBO(255, 255, 255, 1)
            : const Color.fromARGB(255, 118, 117, 116),
        boxShape: shape,
        border: Hive.box('app_settings').get('isLight')
            ? const NeumorphicBorder(
                color: Color(0x33000000),
                width: 0,
              )
            : const NeumorphicBorder(
                color: Color.fromRGBO(148, 153, 0, 0.2),
                width: 0.8,
              ),
        depth: 16,
        lightSource: LightSource.topLeft,
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
      child: widget,
    );
  }
}
