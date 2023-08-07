// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddSpending extends StatefulWidget {
  const AddSpending({super.key});

  @override
  State<AddSpending> createState() => _AddSpendingState();
}

class _AddSpendingState extends State<AddSpending> {
  final _formKey = GlobalKey<FormState>();

  final libelle = TextEditingController();
  final details = TextEditingController();
  final somme = TextEditingController();

  String dateDay = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final repair = FirebaseFirestore.instance.collection('spending');
  int nb = 1;
  int totalJournee = 0;

  add() async {
    await repair.get().then((value) {
      String lib = libelle.text;
      String det = details.text;
      int val = int.parse(somme.text);
      var spend = value.docs.where((element) => element.id == dateDay);
      if (spend.isEmpty) {
        repair.doc(dateDay).set({
          'id': dateDay,
          'nbSpend': nb,
          'totalJournee': val,
          'depense$nb': {
            'libelle': lib,
            'detail': det,
            'somme': val,
          },
        });
      } else {
        setState(() {
          nb = spend.first.get('nbSpend') + 1;
          totalJournee = spend.first.get('totalJournee') + val;
        });
        repair.doc(dateDay).update({
          'depense$nb': {
            'libelle': lib,
            'detail': det,
            'somme': val,
          },
          'nbSpend': nb,
          'totalJournee':
              totalJournee, // on doit afficher le totalité des ventes journalier
        });
      }
    });
    setState(() {
      libelle.text = '';
      details.text = '';
      somme.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une dépense'),
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
                  controller: somme,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  decoration: const InputDecoration(labelText: 'Somme'),
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
                      add();
                      print('object');
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
