import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sms_boutique/screens/sale/repair/detailService.dart';

class Repair extends StatefulWidget {
  const Repair({super.key});

  @override
  State<Repair> createState() => _RepairState();
}

class _RepairState extends State<Repair> {
  List<String> allRepair = [];
  List<int> nbRepair = [];
  List<int> total = [];
  int nb = 0;
  // int nb = 0;
  final db = FirebaseFirestore.instance.collection('repair_services');

  getAllRepairService() async {
    await db.get().then((value) {
      for (var element in value.docs) {
        setState(() {
          // print(element.id);
          allRepair.add(element.id);
          nbRepair.add(element.get('nbRepair'));
          total.add(element.get('totalJournee'));
        });
        // print(allRepair.length);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getAllRepairService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
          body: ListView.builder(
              itemCount: allRepair.length,
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsRepairService(repairId: allRepair[index]),
                      ),
                    );
                  },
                  child: Card(
                      child: ListTile(
                    title: Text(allRepair[index]),
                    subtitle: Text('${total[index].toString()}f'),
                    trailing: Text(nbRepair[index].toString()),
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
