// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailsRepairService extends StatefulWidget {
  String repairId;
  DetailsRepairService({super.key, required this.repairId});

  @override
  State<DetailsRepairService> createState() => _DetailsRepairServiceState();
}

class _DetailsRepairServiceState extends State<DetailsRepairService> {
  final db = FirebaseFirestore.instance.collection('repair_services');
  List<Map<String, dynamic>> repair = [];

  getAllRepairService() async {
    await db.where('id', isEqualTo: widget.repairId).get().then((value) {
      var val = value.docs.first.data();
      setState(() {
        for (var i = 0; i < val['nbRepair']; i++) {
          setState(() {
            repair.add({
              'libelle': val['vente${i + 1}']['libelle'],
              'detail': val['vente${i + 1}']['detail'],
              'prix': val['vente${i + 1}']['prix'],
            });
          });
        }
      });
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
      appBar: AppBar(title: const Text('Detail du service')),
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
      DataColumn(label: Text('Prix')),
    ];
  }

  List<DataRow> _createRows() {
    return repair
        .map((rep) => DataRow(cells: [
              DataCell(Text(rep['libelle'])),
              DataCell(Text(rep['detail'].toString())),
              DataCell(Text('${rep['prix'].toString()}f')),
              // DataCell(Text('${rep['total']}f'))
            ]))
        .toList();
  }
}
