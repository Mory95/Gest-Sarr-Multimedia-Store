import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sms_boutique/services/categoryService.dart';

import '../../models/category.dart';

class CategoryArticle extends StatefulWidget {
  const CategoryArticle({super.key});

  @override
  State<CategoryArticle> createState() => _CategoryArticleState();
}

class _CategoryArticleState extends State<CategoryArticle> {
  List<Category> allCategories = [];
  String id = '';
  final ctrName = TextEditingController();
  final ctrAddName = TextEditingController();
  // final ctrAddName = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Liste des categories'),
        ),
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('categories').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Error'));
              }
              if (snapshot.hasData) {
                allCategories = snapshot.data!.docs
                    .map((doc) => Category.fromJson(doc.data()))
                    .toList();
                return ListView.builder(
                    itemCount: allCategories.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(allCategories[index].name.toString()),
                          trailing: Wrap(
                            children: [
                              ///// modification de categorie /////
                              CircleAvatar(
                                backgroundColor: Colors.grey[700],
                                child: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    id = allCategories[index].id;
                                    ctrName.text =
                                        allCategories[index].name.toString();
                                    // _showMyDialog(Category(id: allCategories[index].id,name: allCategories[index].name));
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: Form(
                                          key: _formKey,
                                          child: TextFormField(
                                            controller: ctrName,
                                            autofocus: true,
                                            decoration: const InputDecoration(
                                                labelText: 'Nom'),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Donne le nouveau nom';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                updateCategory(Category(
                                                    id: id,
                                                    name: ctrName.text));
                                                id = '';
                                                ctrName.text = '';
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text('Modifier'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              id = '';
                                              ctrName.text = '';
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Annuler'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              ///// suppression d'une categorie /////
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Text(
                                                'Est vous sur de vouloir supprimer ‼'),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    id =
                                                        allCategories[index].id;
                                                    deleteCategory(Category(
                                                        id: id,
                                                        name: ctrName.text));
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Oui')),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Non')),
                                            ],
                                          ));
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return const CircularProgressIndicator();
              }
            }),
        ///// Ajout d'une categorie /////
        floatingActionButton: FloatingActionButton(
          // onPressed: () => _showMyDialog(Category(id: '', name: null)),
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                content: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: ctrName,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Nom'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Donner le nom de la categorie à ajouter';
                      }
                      return null;
                    },
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addCategory(Category(name: ctrName.text));
                        Navigator.pop(context);
                        ctrName.text = '';
                      }
                    },
                    child: const Text('Valider'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ctrName.text = '';
                      Navigator.pop(context);
                    },
                    child: const Text('Annuler'),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
