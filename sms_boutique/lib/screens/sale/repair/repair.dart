import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Repair extends StatefulWidget {
  const Repair({super.key});

  @override
  State<Repair> createState() => _RepairState();
}

class _RepairState extends State<Repair> {
  List<String> allRepair = [];
  List<int> nbRepair = [];
  List<int> total = [];
  // int nb = 0;
  final db = FirebaseFirestore.instance.collection('repair_services');

  getAllSales() async {
    await db.get().then((value) {
      for (var element in value.docs) {
        setState(() {
          allRepair.add(element.id);
          nbRepair.add(element.get('nbRepair'));
          total.add(element.get('total'));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
          body: ListView.builder(
              itemCount: 5,
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: () => print('cool'),
                  child: Card(
                      child: ListTile(
                    title: Text("Changement d'écran"),
                    subtitle: Text('2500f'),
                    trailing: Text('2'),
                  )),
                );
              })),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/addRepair'),
            child: const Icon(Icons.add),
          )),
    );
  }
}
