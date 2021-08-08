import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AnimateJeep extends StatefulWidget {
  const AnimateJeep({Key? key}) : super(key: key);

  @override
  _AnimateJeepState createState() => _AnimateJeepState();
}

class _AnimateJeepState extends State<AnimateJeep> {
  SMIBool? _bump;
  String message = "";

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'weather',
        onStateChange: _onStateChange);
    artboard.addController(controller!);
    // _bump = controller.findInput<bool>('Raining') as SMITrigger;

    for (final input in controller.inputs) {
      _bump = input as SMIBool;
    }

    debugPrint('xxx');
  }

  void _onStateChange(
    String stateMachineName,
    String stateName,
  ) =>
      setState(
        () => debugPrint('Changed: $stateMachineName to $stateName'),
      );

  void _hitBump() => {setState(() => _bump!.value = !(_bump!.value))};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jeep Animation'),
      ),
      body: Center(
        child: GestureDetector(
          child: RiveAnimation.asset(
            'assets/vehicles.riv',
            artboard: "Jeep",
            fit: BoxFit.fitHeight,
            onInit: _onRiveInit,
          ),
          onTap: _hitBump,
        ),
      ),
    );
  }
}
