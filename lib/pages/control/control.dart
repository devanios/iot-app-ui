import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:iot_app_ui/pages/control/options.dart';
import 'package:iot_app_ui/pages/control/widgets/option_widget.dart';
import 'package:iot_app_ui/pages/control/widgets/power_widget.dart';
import 'package:iot_app_ui/pages/control/widgets/slider/slider_widget.dart';
import 'package:iot_app_ui/pages/control/widgets/speed_widget.dart';
import 'package:iot_app_ui/pages/control/widgets/temp_widget.dart';
import 'package:iot_app_ui/utils/slider_utils.dart';
import 'package:iot_app_ui/widgets/custom_appbar.dart';
import 'package:rainbow_color/rainbow_color.dart';

class ControlPanelPage extends StatefulWidget {
  final String tag;

  const ControlPanelPage({super.key, required this.tag});

  @override
  _ControlPanelPageState createState() => _ControlPanelPageState();
}

class _ControlPanelPageState extends State<ControlPanelPage>
    with TickerProviderStateMixin {
  Options option = Options.cooling;
  bool isActive = false;
  int speed = 1;
  double temp = 22.85;
  double progressVal = .49;

  var activeColor = Rainbow(spectrum: [
    const Color(0xFF33C0BA),
    const Color(0xFF1086D4),
    const Color(0xFF6D04E2),
    const Color(0xFFC421A0),
    const Color(0xFFE4262F)
  ], rangeStart: .0, rangeEnd: 1.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Colors.white,
              activeColor[progressVal].withOpacity(.5),
              activeColor[progressVal]
            ],
          ),
        ),
        child: AnimatedBackground(
          behaviour: RandomParticleBehaviour(
            options: ParticleOptions(
              baseColor: const Color(0xffffffff),
              opacityChangeRate: .25,
              minOpacity: .1,
              maxOpacity: .3,
              spawnMaxSpeed: speed * 120,
              spawnMinSpeed: speed * 60,
              spawnMaxRadius: 5.0,
              spawnMinRadius: 2.0,
              particleCount: isActive ? speed * 150 : 0,
            ),
          ),
          vsync: this,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Column(
                children: [
                  const CustomAppBar(title: "Smart AC"),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        options(),
                        slider(),
                        controls(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget options() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        OptionWidget(
          icon: 'assets/svg/clock.svg',
          isSelected: option == Options.timer,
          onTap: () => setState(() {
            option = Options.timer;
          }),
          size: 32,
        ),
        OptionWidget(
          icon: 'assets/svg/snow.svg',
          isSelected: option == Options.cooling,
          onTap: () => setState(() {
            option = Options.cooling;
          }),
          size: 25,
        ),
        OptionWidget(
          icon: 'assets/svg/bright.svg',
          isSelected: option == Options.heat,
          onTap: () => setState(() {
            option = Options.heat;
          }),
          size: 35,
        ),
        OptionWidget(
          icon: 'assets/svg/drop.svg',
          isSelected: option == Options.dry,
          onTap: () => setState(() {
            option = Options.dry;
          }),
          size: 28,
        ),
      ],
    );
  }

  Widget slider() {
    return SliderWidget(
      progressVal: progressVal,
      color: activeColor[progressVal],
      onChange: (value) {
        setState(() {
          temp = value;
          progressVal = normalize(value, kMinDegree, kMaxDegree);
        });
      },
    );
  }

  Widget controls() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SpeedWidget(
                speed: speed,
                changeSpeed: (val) {
                  speed = val;
                },
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: PowerWidget(
                isActive: isActive,
                onChanged: (val) => setState(
                  () {
                    isActive = val;
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        TempWidget(
          temp: temp,
          changeTemp: (val) => setState(
            () {
              temp = val;

              progressVal = normalize(val, kMinDegree, kMaxDegree);
            },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
