// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddRepair extends StatefulWidget {
  const AddRepair({super.key});

  @override
  State<AddRepair> createState() => _AddRepairState();
}

class _AddRepairState extends State<AddRepair> {
  final _formKey = GlobalKey<FormState>();

  final libelle = TextEditingController();
  final details = TextEditingController();
  final prix = TextEditingController();

  String dateDay = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final repair = FirebaseFirestore.instance.collection('repair_services');
  int nb = 1;
  int totalJournee = 0;

  addRepair() async {
    await repair.get().then((value) {
      String lib = libelle.text;
      String det = details.text;
      int price = int.parse(prix.text);
      var test = value.docs.where((element) => element.id == dateDay);
      if (test.isEmpty) {
        repair.doc(dateDay).set({
          'id': dateDay,
          'nbRepair': nb,
          'totalJournee': price,
          'vente$nb': {
            'libelle': lib,
            'detail': det,
            'prix': price,
          },
        });
      } else {
        setState(() {
          nb = test.first.get('nbRepair') + 1;
          totalJournee = test.first.get('totalJournee') + price;
        });
        repair.doc(dateDay).update({
          'vente$nb': {
            'libelle': lib,
            'detail': det,
            'prix': price,
          },
          'nbRepair': nb,
          'totalJournee':
              totalJournee, // on doit afficher le totalité des ventes journalier
        });
      }
    });
    setState(() {
      // libelle.text = '';
      // details.text = '';
      // prix.text = '';
    });
  }

  @override
  void initState() {
    super.initState();
    // repair.doc(dateDay).set({'id': dateDay, 'nbRepair': 0, 'totalJournee': 0});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un service"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: libelle,
                  decoration: const InputDecoration(labelText: 'Libelle'),
                  validator: (libelle) {
                    if (libelle == null || libelle.isEmpty) {
                      return 'Veillez saisir un libellé';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: details,
                  keyboardType: TextInputType.multiline,
                  // maxLines: null,
                  // expands: true,
                  decoration: const InputDecoration(labelText: 'Details'),
                  validator: (details) {
                    if (details == null || details.isEmpty) {
                      return 'Veillez saisir les détails';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: prix,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  decoration: const InputDecoration(labelText: 'Prix'),
                  validator: (prix) {
                    if (prix == null || prix.isEmpty) {
                      return 'Veillez saisir le prix';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addRepair();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
