import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          _UpperBox(),
          _HeaderIcon(),
          child
        ]
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: const Icon(Icons.person_pin, color: Colors.white, size: 100),
      ),
    );
  }
}

class _UpperBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      //color: Color.fromARGB(255, 54, 120, 244),
      decoration: _upperBackground(),
      child: Stack(
        children: [
          Positioned(top:     70,   left: 30,   child: _Bubble()), 
          Positioned(top:     120,  left: 250,  child: _Bubble()),
          Positioned(top:     10,   right: 20,  child: _Bubble()),
          Positioned(bottom: -20,   right: 70,  child: _Bubble()),
          Positioned(top:     300,  left: 150,  child: _Bubble())
        ]
      ),
    );
  }

  BoxDecoration _upperBackground() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          //Color.fromRGBO(63, 63, 156, 1),
          //Color.fromRGBO(90, 70, 178, 1)
          Color.fromRGBO(13, 71, 161, 1),
          Color.fromRGBO(21, 101, 192, 1)
        ]
      )
    );
  }
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );
  }
}