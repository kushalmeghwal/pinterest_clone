import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    fade = Tween(begin: 6.0, end: 6.0).animate(_controller);

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 1600), () {
      if (!mounted) return;
      context.go('/main'); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: fade,
          child: Image.asset(
            "assets/pinterest-logo.png",
            width: 90,
          ),
        ),
      ),
    );
  }
}
