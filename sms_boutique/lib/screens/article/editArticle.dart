import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sms_boutique/services/articleService.dart';

import '../../models/article.dart';

class EditArticle extends StatefulWidget {
  final Article article;
  const EditArticle({
    super.key,
    required this.article,
  });

  @override
  State<EditArticle> createState() => _EditArticleState();
}

class _EditArticleState extends State<EditArticle> {
  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final description = TextEditingController();
  final price = TextEditingController();
  final quantity = TextEditingController();
  final img = TextEditingController();
  // final category = TextEditingController();
  // final List<String> _items = [];
  // String? _selectedCategory;
  CollectionReference db = FirebaseFirestore.instance.collection('category');

  // getCategory() async {
  //   await FirebaseFirestore.instance
  //       .collection('categories')
  //       .get()
  //       .then((value) {
  //     for (var element in value.docs) {
  //       setState(() {
  //         _items.add(element.get('name'));
  //       });
  //       // print(element.get('name'));
  //       // print(_items);
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    setState(() {
      name.text = widget.article.name!;
      description.text = widget.article.description!;
      price.text = widget.article.price!;
      quantity.text = widget.article.quantity!;
      img.text = widget.article.image!;
      // _selectedCategory = widget.article.categorie_id!;
    });
    // getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit article')),
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
                    onChanged: (value) {
                      setState(() {
                        widget.article.name = value;
                      });
                    },
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
                    onChanged: (value) {
                      setState(() {
                        widget.article.description = value;
                      });
                    },
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
                    onChanged: (value) {
                      setState(() {
                        widget.article.price = value;
                      });
                    },
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
                    onChanged: (value) {
                      setState(() {
                        widget.article.quantity = value;
                      });
                    },
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
                    onChanged: (value) {
                      setState(() {
                        widget.article.image = value;
                      });
                    },
                    validator: (img) {
                      if (img == null || img.isEmpty) {
                        return 'Veillez saisir une image';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    enabled: false,
                    initialValue: widget.article.categorie_id,
                    decoration: const InputDecoration(labelText: 'Catégorie'),
                  ),
                  // DropdownButtonFormField<String>(
                  //   value: _selectedCategory,
                  //   items: _items.map<DropdownMenuItem<String>>((String value) {
                  //     return DropdownMenuItem<String>(
                  //       // onTap: () => print(value),
                  //       value: value,
                  //       child: Text(value),
                  //     );
                  //   }).toList(),
                  //   onChanged: (value) {
                  //     setState(() {
                  //       _selectedCategory = value;
                  //     });
                  //   },
                  //   decoration: const InputDecoration(
                  //     labelText: 'Categorie',
                  //   ),
                  //   validator: (value) {
                  //     if (value == null) {
                  //       return 'Veuillez choisir une categorie';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  SizedBox(
                    height: 15.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Center(
                                  child: Text(
                            'Ajout en cour...',
                            style: TextStyle(fontSize: 30.0),
                          ))),
                        );
                        updateArticle(widget.article);
                        // Apres l'ajout on retourne à la page AllArticle
                        Navigator.pop(context);
                        setState(() {
                          name.text = '';
                          description.text = '';
                          quantity.text = '';
                          price.text = '';
                          img.text = '';
                        });
                      }
                    },
                    child: const Text('Modifier'),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
