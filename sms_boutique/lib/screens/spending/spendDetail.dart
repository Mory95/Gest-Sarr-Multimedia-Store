// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SpendDetail extends StatefulWidget {
  String spendId;
  SpendDetail({super.key, required this.spendId});

  @override
  State<SpendDetail> createState() => _SpendDetailState();
}

class _SpendDetailState extends State<SpendDetail> {
  final db = FirebaseFirestore.instance.collection('spending');
  List<Map<String, dynamic>> spend = [];

  getAllSpend() async {
    await db.where('id', isEqualTo: widget.spendId).get().then((value) {
      var val = value.docs.first.data();
      setState(() {
        for (var i = 0; i < val['nbSpend']; i++) {
          setState(() {
            spend.add({
              'libelle': val['depense${i + 1}']['libelle'],
              'detail': val['depense${i + 1}']['detail'],
              'somme': val['depense${i + 1}']['somme'],
            });
          });
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAllSpend();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('détail dépense'),
      ),
      body: ListView(
        children: [
          _createDataTable(),
        ],
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return const [
      DataColumn(label: Text('Libelle')),
      DataColumn(label: Text('Detail')),
      DataColumn(label: Text('somme')),
    ];
  }

  List<DataRow> _createRows() {
    return spend
        .map((rep) => DataRow(cells: [
              DataCell(Text(rep['libelle'])),
              DataCell(Text(rep['detail'].toString())),
              DataCell(Text('${rep['somme'].toString()}f')),
            ]))
        .toList();
  }
}
