// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sms_boutique/models/article.dart';
import 'package:sms_boutique/services/articleService.dart';

// const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class AddArticle extends StatefulWidget {
  const AddArticle({super.key});

  @override
  State<AddArticle> createState() => _AddArticleState();
}

class _AddArticleState extends State<AddArticle> {
  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final description = TextEditingController();
  final price = TextEditingController();
  final quantity = TextEditingController();
  final img = TextEditingController();
  final category = TextEditingController();

  // String dropdownValue = list.first;
  final List<String> _items = [];
  String? _selectedCategory;
  CollectionReference db = FirebaseFirestore.instance.collection('category');

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  getCategory() async {
    await FirebaseFirestore.instance
        .collection('categories')
        .get()
        .then((value) {
      for (var element in value.docs) {
        setState(() {
          _items.add(element.get('name'));
        });
        // print(element.get('name'));
        // print(_items);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add article'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: name,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (name) {
                    if (name == null || name.isEmpty) {
                      return 'Veillez saisir un nom pour cet article';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: description,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (desc) {
                    if (desc == null || desc.isEmpty) {
                      return 'Veillez saisir une description pour cet article';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: price,
                  decoration: const InputDecoration(labelText: 'Prix'),
                  validator: (price) {
                    if (price == null || price.isEmpty) {
                      return 'Veillez saisir un prix pour cet article';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: quantity,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  validator: (quantity) {
                    if (quantity == null || quantity.isEmpty) {
                      return "Veillez saisir le nombre d'article";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: img,
                  decoration: const InputDecoration(labelText: 'Image'),
                  validator: (img) {
                    if (img == null || img.isEmpty) {
                      return 'Veillez saisir une image';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items: _items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      // onTap: () => print(value),
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Categorie',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Veuillez choisir une categorie';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      addArticle(Article(
                        name: name.text,
                        description: description.text,
                        price: price.text,
                        quantity: quantity.text,
                        image: img.text,
                        categorie_id: _selectedCategory,
                        // author_id: currentUser.id,
                      ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Center(
                                child: Text(
                          'Ajout en cour...',
                          style: TextStyle(fontSize: 30.0),
                        ))),
                      );
                      // Apres l'ajout on retourne à la page AllArticle
                      Navigator.pop(context);
                      setState(() {
                        name.text = '';
                        description.text = '';
                        quantity.text = '';
                        price.text = '';
                        img.text = '';
                        // _selectedCategory = '';
                      });
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
