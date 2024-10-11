import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
enum SingingCharacter { lafayette, jefferson }
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool isMaterial = true;
  bool isCustomized = false;
  double _currentSliderValue = 20;
  double _currentSliderValueCupertino = 0.0;
  String? _sliderStatus;
  bool isChecked = false;
  SingingCharacter? _character = SingingCharacter.lafayette;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.lightGreen;
    }
    return Colors.redAccent;
  }
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
        platform: isMaterial ? TargetPlatform.android : TargetPlatform.iOS,
        adaptations: <Adaptation<Object>>[
          if (isCustomized) const _SwitchThemeAdaptation()
        ]);
    final ButtonStyle style = OutlinedButton.styleFrom(
      fixedSize: const Size(220, 40),
    );

    return MaterialApp(
      theme: theme,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 56.0),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: AppBar(
                title: const Text('Adaptive Switches'),
                leading: Icon(Icons.chevron_left),
                elevation: 0.0,
                backgroundColor: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
        ),
        body: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 8.0,),
                          OutlinedButton(
                            style: style,
                            onPressed: () {
                              setState(() {
                                isMaterial = !isMaterial;
                              });
                            },
                            child: isMaterial
                                ? const Text('Show cupertino style')
                                : const Text('Show material style'),
                          ),
                          SizedBox(height: 4.0,),
                          OutlinedButton(
                            style: style,
                            onPressed: () {
                              setState(() {
                                isCustomized = !isCustomized;
                              });
                            },
                            child: isCustomized
                                ? const Text('Remove customization')
                                : const Text('Add customization'),
                          ),
                          const SizedBox(height: 20),
                          const SwitchWithLabel(label: 'enabled', enabled: true),
                          const SwitchWithLabel(label: 'disabled', enabled: false),
                          SizedBox(height: 8.0,),
                          Slider(
                            value: _currentSliderValue,
                            max: 100,
                            divisions: 5,
                            label: _currentSliderValue.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValue = value;
                              });
                            },
                          ),
                          SizedBox(height: 8.0,),
                          Text('$_currentSliderValueCupertino'),
                          CupertinoSlider(
                            key: const Key('slider'),
                            value: _currentSliderValueCupertino,
                            // This allows the slider to jump between divisions.
                            // If null, the slide movement is continuous.
                            divisions: 5,
                            // The maximum slider value
                            max: 100,
                            activeColor: CupertinoColors.systemPurple,
                            thumbColor: CupertinoColors.systemPurple,
                            // This is called when sliding is started.
                            onChangeStart: (double value) {
                              setState(() {
                                _sliderStatus = 'Sliding';
                              });
                            },
                            // This is called when sliding has ended.
                            onChangeEnd: (double value) {
                              setState(() {
                                _sliderStatus = 'Finished sliding';
                              });
                            },
                            // This is called when slider value is changed.
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValueCupertino = value;
                              });
                            },
                          ),
                          Text(
                            _sliderStatus ?? '',
                            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 8.0,),
                          CircularProgressIndicator(),
                          SizedBox(height: 8.0,),
                          Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // Cupertino activity indicator with default properties.
                                  CupertinoActivityIndicator(),
                                  SizedBox(height: 10),
                                  Text('Default'),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // Cupertino activity indicator with custom radius and color.
                                  CupertinoActivityIndicator(
                                      radius: 20.0, color: CupertinoColors.activeBlue),
                                  SizedBox(height: 10),
                                  Text(
                                    'radius: 20.0\ncolor: CupertinoColors.activeBlue',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // Cupertino activity indicator with custom radius and disabled
                                  // animation.
                                  CupertinoActivityIndicator(radius: 20.0, animating: false),
                                  SizedBox(height: 10),
                                  Text(
                                    'radius: 20.0\nanimating: false',
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0,),
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          SizedBox(height: 8.0,),
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          SizedBox(height: 8.0,),
                          // CupertinoCheckbox(value: value, onChanged: onChanged)
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ListTile(
                                  title: const Text('Lafayette'),
                                  leading: Radio<SingingCharacter>(
                                    value: SingingCharacter.lafayette,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter? value) {
                                      setState(() {
                                        _character = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Thomas Jefferson'),
                                  leading: Radio<SingingCharacter>(
                                    value: SingingCharacter.jefferson,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter? value) {
                                      setState(() {
                                        _character = value;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 8.0,),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CupertinoListTile(
                                  title: const Text('Lafayette'),
                                  leading: CupertinoRadio<SingingCharacter>(
                                    value: SingingCharacter.lafayette,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter? value) {
                                      setState(() {
                                        _character = value;
                                      });
                                    },
                                  ),
                                ),
                                CupertinoListTile(
                                  title: const Text('Thomas Jefferson'),
                                  leading: CupertinoRadio<SingingCharacter>(
                                    value: SingingCharacter.jefferson,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter? value) {
                                      setState(() {
                                        _character = value;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 8.0,),
                          Center(
                            child: AlertDialogExample(),
                          ),
                          SizedBox(height: 8.0,),
                          Center(
                            child: CupertinoAlertDialogExample(),
                          ),
                          SizedBox(height: 8.0,),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const RadialGradient(
                                colors: [Colors.red, Colors.yellow],
                                radius: 0.75,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0,),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                colors: [Colors.purple, Colors.blueAccent],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                stops: [0.4, 0.7],
                                tileMode: TileMode.repeated,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0,),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.8,
                            // Below is the code for Linear Gradient.
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [Colors.purple, Colors.blue],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0,),
                          Container (
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const SweepGradient(
                                  colors: [
                                    Colors.red,
                                    Colors.yellow,
                                    Colors.blue,
                                    Colors.green,
                                    Colors.red,
                                  ],
                                  stops: <double>[0.0, 0.25, 0.5, 0.75, 1.0],
                                  tileMode: TileMode.clamp,
                                ),
                              )
                          )
                        ],
                      ),
                      SizedBox(height: 8.0,),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const SweepGradient(
                            startAngle: math.pi * 0.2,
                            endAngle: math.pi * 1.7,
                            colors: [
                              Colors.red,
                              Colors.yellow,
                              Colors.blue,
                              Colors.green,
                              Colors.red,
                            ],
                            stops: <double>[0.0, 0.25, 0.5, 0.75, 1.0],
                            tileMode: TileMode.clamp,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AlertDialogExample extends StatelessWidget {
  const AlertDialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}

class CupertinoAlertDialogExample extends StatelessWidget {
  const CupertinoAlertDialogExample({super.key});

  void _showAlertDialog(BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          CupertinoAlertDialog(
            title: const Text('Alert'),
            content: const Text('Proceed with destructive action?'),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(

                /// This parameter indicates this action is the default,
                /// and turns the action's text to bold text.
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
              CupertinoDialogAction(

                /// This parameter indicates the action would perform
                /// a destructive action such as deletion, and turns
                /// the action's text color to red.
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoAlertDialog Sample'),
      ),
      child: Center(
        child: CupertinoButton(
          onPressed: () => _showAlertDialog(context),
          child: const Text('CupertinoAlertDialog'),
        ),
      ),
    );
  }
}
class SwitchWithLabel extends StatefulWidget {
  const SwitchWithLabel({
    super.key,
    required this.enabled,
    required this.label,
  });

  final bool enabled;
  final String label;

  @override
  State<SwitchWithLabel> createState() => _SwitchWithLabelState();
}

class _SwitchWithLabelState extends State<SwitchWithLabel> {
  bool active = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            width: 150,
            padding: const EdgeInsets.only(right: 20),
            child: Text(widget.label)),
        Switch.adaptive(
          value: active,
          onChanged: !widget.enabled
              ? null
              : (bool value) {
            setState(() {
              active = value;
            });
          },
        ),
      ],
    );
  }
}

class _SwitchThemeAdaptation extends Adaptation<SwitchThemeData> {
  const _SwitchThemeAdaptation();

  @override
  SwitchThemeData adapt(ThemeData theme, SwitchThemeData defaultValue) {
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return defaultValue;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.blueAccent;
                }
                return null; // Use the default.
              }),
          trackColor: const MaterialStatePropertyAll<Color>(Colors.lightBlueAccent),
        );
    }
  }
}