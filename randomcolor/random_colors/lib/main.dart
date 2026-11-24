import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const RandomColorApp());
}

class RandomColorApp extends StatelessWidget {
  const RandomColorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RandomColorPage(),
    );
  }
}

class RandomColorPage extends StatefulWidget {
  const RandomColorPage({super.key});

  @override
  State<RandomColorPage> createState() => _RandomColorPageState();
}

class _RandomColorPageState extends State<RandomColorPage> {
  final Random _random = Random();
  Color _backgroundColor = Colors.white;

  void _changeColor() {
    setState(() {
      _backgroundColor = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _changeColor,
        child: const Center(
          child: Text('Tap anywhere to change the color'),
        ),
      ),
    );
  }
}
