import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_app_ui/pages/control/control.dart';

class Devices extends StatelessWidget {
  final String name;
  final String svg;
  final Color color;
  final bool isActive;
  final Function(bool) onChanged;

  const Devices(
      {super.key,
      required this.name,
      required this.svg,
      required this.color,
      required this.onChanged,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: const Duration(milliseconds: 600),
      closedElevation: 0,
      openElevation: 0,
      openShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      openBuilder: (BuildContext context, VoidCallback _) {
        return ControlPanelPage(tag: name);
      },
      tappable: name == "Smart AC" ? true : false,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              const Radius.circular(20.0),
            ),
            border: Border.all(
              color: Colors.grey[300]!,
              width: .6,
            ),
            color: isActive ? color : Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      svg,
                      color: isActive ? Colors.white : Colors.black,
                      height: 30,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    SizedBox(
                      width: 65,
                      child: Text(
                        name,
                        style: TextStyle(
                          height: 1.2,
                          fontSize: 14,
                          color: isActive ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Transform.scale(
                  alignment: Alignment.center,
                  scaleX: .85,
                  scaleY: .8,
                  child: CupertinoSwitch(
                    value: isActive,
                    onChanged: onChanged,
                    activeColor:
                        isActive ? Colors.white.withOpacity(.4) : Colors.black,
                    trackColor: Colors.black,
                  ),
                )
              ],
            ),
          ),
        );
      },
    ); // TODO: implement build
  }
}
