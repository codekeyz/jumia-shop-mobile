import 'package:flutter/material.dart';

class BasKetScreen extends StatefulWidget {
  const BasKetScreen({Key? key}) : super(key: key);

  @override
  State<BasKetScreen> createState() => _BasKetScreenState();
}

class _BasKetScreenState extends State<BasKetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
    );
  }
}
