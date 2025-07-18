import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String message;

  const ErrorScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: Center(child: Text('Oops: $message')),
      );
}