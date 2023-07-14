import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms_boutique/screens/sale/article/saleDetails.dart';

class AllSales extends StatefulWidget {
  const AllSales({super.key});

  @override
  State<AllSales> createState() => _AllSalesState();
}

class _AllSalesState extends State<AllSales> {
  List<String> allSales = [];
  List<int> nbSales = [];
  List<int> total = [];
  int nb = 0;
  final db = FirebaseFirestore.instance.collection('ventes');

  getAllSales() async {
    await db.get().then((value) {
      for (var element in value.docs) {
        setState(() {
          allSales.add(element.id);
          nbSales.add(element.get('nbSales'));
          total.add(element.get('total'));
        });
      }
    });
  }

  getSales() async {
    // details vente
    await db.get().then((value) {
      for (var element in value.docs) {
        setState(() {
          allSales.add(element.id);
          nbSales.add(element.get('nbSales'));
          // print(element.id);
          for (var i = 0; i < element.data()['nbSales']; i++) {
            // print(element.data().containsKey('vente${i + 1}'));
            // print(element.data()['vente${i + 1}']);
            // print(element.data().containsKey('vente${i + 1}'));
            if (element.data().containsKey('vente${i + 1}')) {
              print(element.data()['vente${i + 1}']['nom']);
              print(element.data()['vente${i + 1}']['prix']);
              print(element.data()['vente${i + 1}']['qty']);
              print(element.data()['vente${i + 1}']['total']);
            }
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // getCounts();
    getAllSales();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('List des ventes'),
        //   actions: [
        //     IconButton(
        //         onPressed: () => print('seach'),
        //         icon: const Icon(Icons.attach_money_outlined))
        //   ],
        // ),
        body: ListView.builder(
            itemCount: allSales.length,
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () {
                  // print(allSales[index]);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          SaleDetails(saleId: allSales[index]),
                    ),
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text(allSales[index]),
                    subtitle: Text('${total[index].toString()}FCFA'),
                    trailing: Text(nbSales[index].toString()),
                  ),
                ),
              );
            })),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/addSale'),
          child: const Icon(Icons.add),
        ));
  }
}
