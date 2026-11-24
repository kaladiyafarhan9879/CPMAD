import 'dart:math';
import 'package:flutter/material.dart';

class RandomColorPage extends StatefulWidget {
  const RandomColorPage({super.key});

  @override
  State<RandomColorPage> createState() => _RandomColorPageState();
}

class _RandomColorPageState extends State<RandomColorPage> {
  final Random _random = Random();

  Color _backgroundColor = Colors.blue;
  Color _textColor = Colors.white;
  Color _buttonColor = Colors.blue;

  Color _getRandomColor() {
    return Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  void _changeColors() {
    setState(() {
      _backgroundColor = _getRandomColor();

      // Choose black or white for readable contrast.
      _textColor = _backgroundColor.computeLuminance() > 0.5
          ? Colors.black
          : Colors.white;

      _buttonColor = _getRandomColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('Random Color'),
        backgroundColor: _backgroundColor,
        foregroundColor: _textColor,
      ),
      body: Center(
        child: Text(
          'Tap the button to change colors',
          style: TextStyle(color: _textColor, fontSize: 22),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeColors,
        backgroundColor: _buttonColor,
        foregroundColor: _textColor,
        child: const Icon(Icons.color_lens),
      ),
    );
  }
}
