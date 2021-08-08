import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AnimateTruck extends StatefulWidget {
  const AnimateTruck({Key? key}) : super(key: key);

  @override
  _AnimateTruckState createState() => _AnimateTruckState();
}

class _AnimateTruckState extends State<AnimateTruck> {
  SMITrigger? _bump;
  String message = "";

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'bumpy',
        onStateChange: _onStateChange);
    artboard.addController(controller!);
    _bump = controller.findInput<bool>('bump') as SMITrigger;
  }

  void _onStateChange(
    String stateMachineName,
    String stateName,
  ) =>
      setState(
        () => debugPrint('State Changed in $stateMachineName to $stateName'),
      );

  void _hitBump() => {setState(() => _bump?.fire())};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Animation'),
      ),
      body: Center(
        child: GestureDetector(
          child: RiveAnimation.asset(
            'assets/vehicles.riv',
            fit: BoxFit.fitHeight,
            onInit: _onRiveInit,
          ),
          onTap: _hitBump,
        ),
      ),
    );
  }
}
