import 'package:flutter/material.dart';

class Accounting extends StatefulWidget {
  const Accounting({super.key});

  @override
  State<Accounting> createState() => _AccountingState();
}

class _AccountingState extends State<Accounting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comptabilité'),
        actions: [
          Text("Total de vente"),
        ],
      ),
      body: SingleChildScrollView(child: Text('Le compte')),
    );
  }
}
