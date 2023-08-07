// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ShowDialogTest extends StatefulWidget {
  const ShowDialogTest({super.key});

  @override
  State<ShowDialogTest> createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialogTest> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Cool"),
      actions: [
        TextButton(onPressed: () {}, child: const Text('Valider')),
        TextButton(onPressed: () {}, child: const Text('Annuler')),
      ],
    );
  }
}


// Future<void> _showMyDialog(Category category) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         content: Form(
  //           child: Wrap(
  //             children: <Widget>[
  //               TextFormField(
  //                 controller: ctrName,
  //                 decoration: const InputDecoration(labelText: 'name'),
  //                 validator: (value) {
  //                   if (value == null || value.isEmpty) {
  //                     return 'Donne un nom';
  //                   }
  //                   return null;
  //                 },
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       if (_formKey.currentState!.validate()) {
  //                         updateCategory(Category(id: id, name: ctrName.text));
  //                       }
  //                     },
  //                     child: const Text('Valider'),
  //                   ),
  //                   const SizedBox(
  //                     width: 15.0,
  //                   ),
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: const Text('Annuler'),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
