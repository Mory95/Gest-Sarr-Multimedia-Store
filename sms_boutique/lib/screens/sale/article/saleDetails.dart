// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SaleDetails extends StatefulWidget {
  String saleId;
  SaleDetails({super.key, required this.saleId});

  @override
  State<SaleDetails> createState() => _SaleDetailsState();
}

class _SaleDetailsState extends State<SaleDetails> {
  final db = FirebaseFirestore.instance.collection('ventes');
  List<Map<String, dynamic>> vente = [];
  int length = 0;

  getSale() async {
    await db.where('id', isEqualTo: widget.saleId).get().then((sale) {
      var val = sale.docs.first.data();
      setState(() {
        length = val['nbSales'];
        for (var i = 0; i < length; i++) {
          // print(val['vente${i + 1}']['nom']);
          vente.add({
            'nom': val['vente${i + 1}']['nom'],
            'prix': val['vente${i + 1}']['prix'],
            'qty': val['vente${i + 1}']['qty'],
            'total': val['vente${i + 1}']['total'],
          });
        }
        // print(vente);
      });
      // print(sale.docs.first.data()['nbSales']);
    });
  }

  @override
  void initState() {
    super.initState();
    getSale();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
        ),
        // body: ListView.builder(
        //   itemCount: length,
        //   itemBuilder: ((context, index) {
        //     return Card(
        //       child: ListTile(
        //         title: Text(vente[index]['nom']),
        //         subtitle: Text(vente[index]['prix'].toString()),
        //         trailing: Text(vente[index]['qty'].toString()),
        //       ),
        //     );
        //   }),
        // ),
        body: ListView(
          children: [
            _createDataTable(),
          ],
        ));
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return const [
      DataColumn(label: Text('Nom')),
      DataColumn(
          label: Expanded(
              child: Text(
        'Prix/u',
        overflow: TextOverflow.ellipsis,
      ))),
      DataColumn(label: Text('Qté')),
      DataColumn(label: Text('Total'))
    ];
  }

  List<DataRow> _createRows() {
    return vente
        .map((book) => DataRow(cells: [
              DataCell(Text(book['nom'])),
              DataCell(Text(book['prix'].toString())),
              DataCell(Text(book['qty'].toString())),
              DataCell(Text('${book['total']}f'))
            ]))
        .toList();
  }
}
