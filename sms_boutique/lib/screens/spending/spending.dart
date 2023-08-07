import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sms_boutique/screens/spending/spendDetail.dart';

class Spend extends StatefulWidget {
  const Spend({super.key});

  @override
  State<Spend> createState() => _SpendState();
}

class _SpendState extends State<Spend> {
  List<String> allSpend = [];
  List<int> nbSpend = [];
  List<int> total = [];
  int nb = 0;
  final db = FirebaseFirestore.instance.collection('spending');

  getAllSpending() async {
    await db.get().then((value) {
      for (var element in value.docs) {
        // print(element.id);
        setState(() {
          allSpend.add(element.id);
          nbSpend.add(element.get('nbSpend'));
          total.add(element.get('totalJournee'));
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getAllSpending();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Liste des Dépenses'),
        ),
        body: ListView.builder(
            itemCount: allSpend.length,
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          SpendDetail(spendId: allSpend[index]),
                    ),
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text(allSpend[index]),
                    subtitle: Text('${total[index].toString()}FCFA'),
                    trailing: Text(nbSpend[index].toString()),
                  ),
                ),
              );
            })),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/addSpend'),
          child: const Icon(Icons.add),
        ));
  }
}
