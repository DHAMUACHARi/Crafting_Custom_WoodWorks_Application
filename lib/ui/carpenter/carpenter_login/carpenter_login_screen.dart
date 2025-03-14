import 'package:flutter/material.dart';
class CarpenterLoginScreen extends StatelessWidget {
  const CarpenterLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carpenter Login '),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.green,
         image: DecorationImage(image: AssetImage('assert/user_asserts/google_image.png'))
        ),
      ),
    );
  }
}
