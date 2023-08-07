// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Les ventes de téléphone'),
    );
  }
}
