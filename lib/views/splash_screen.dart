import 'package:flutter/material.dart';
import 'dart:async';

import 'main_screen.dart';

import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  String _displayedText = "";
  String _fullText = "Smart Savings, Smart Future";
  int _charIndex = 0;
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();

    // Start typing effect
    _typingTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_charIndex < _fullText.length) {
        if (mounted) {  // Check if widget is still in tree
          setState(() {
            _displayedText += _fullText[_charIndex];
            _charIndex++;
          });
        }
      } else {
        timer.cancel();
      }
    });

    // Navigate after delay
    Future.delayed(Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen()));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _typingTimer?.cancel(); // Cancel timer to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade700,
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _displayedText,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Your money, your control!",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

