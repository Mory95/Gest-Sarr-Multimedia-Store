// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:sms_boutique/models/article.dart';
import 'package:sms_boutique/services/articleService.dart';

class AddSale extends StatefulWidget {
  const AddSale({super.key});

  @override
  State<AddSale> createState() => _AddSaleState();
}

class _AddSaleState extends State<AddSale> {
  final _formKey = GlobalKey<FormState>();
  final qtyController = TextEditingController();
  final priceController = TextEditingController();

  final db = FirebaseFirestore.instance.collection('articles');
  final ventes = FirebaseFirestore.instance.collection('ventes');
  final TextEditingController _suggestionController = TextEditingController();
  Article art = Article();
  String suggestionQuantity = '';
  String suggestionPrice = '';
  int nb = 1;
  int totalJournee = 0;
  String dateDay = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String time = DateFormat.Hms().format(DateTime.now());

  Future<List<Article>> getSuggestions(String query) async {
    // récupérer les données de Firebase
    QuerySnapshot snapshot = await db.get();
    List<Article> artSug = [];
    // ajouter les articles dans une liste(artSug)
    for (var element in snapshot.docs) {
      artSug.add(Article(
        id: element.get('id'),
        name: element.get('name'),
        description: element.get('description'),
        price: element.get('price'),
        image: element.get('image'),
        quantity: element.get('quantity'),
        categorie_id: element.get('categorie_id'),
        // author_id: element.get('author_id'),
      ));
      // print(artSug);
    }
    // filtré la liste en fonction de la saisi de l'utilisateur
    if (query.isEmpty) {
      return [];
    } else {
      List<Article> filteredArticles = artSug
          .where((article) =>
              article.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return filteredArticles;
    }
  }

  createSale() async {
    String name = _suggestionController.text;
    int price = int.parse(priceController.text);
    int qty = int.parse(qtyController.text);
    int total = price * qty;
    String newArticleQty = (int.parse(suggestionQuantity) - qty).toString();
    await ventes.get().then((value) {
      var test = value.docs.where((element) => element.id == dateDay);
      if (test.isEmpty) {
        ventes.doc(dateDay).set({
          'id': dateDay,
          'nbSales': nb,
          'total': total,
          'vente$nb': {'nom': name, 'prix': price, 'qty': qty, 'total': total},
        });
      } else {
        setState(() {
          nb = test.first.get('nbSales') + 1;
          totalJournee = test.first.get('total') + total;
        });
        // Ajouter la vente à la sous-collection de ventes pour le jour actuel
        ventes.doc(dateDay).update({
          'vente$nb': {'nom': name, 'prix': price, 'qty': qty, 'total': total},
          'nbSales': nb,
          'total':
              totalJournee, // on doit afficher le totalité des ventes journalier
          // 'timestamp': DateTime.now(),
        });
      }
    }).whenComplete(() {
      setState(() {
        art.quantity = newArticleQty;
      });
      updateArticle(art);
    });

    // setState(() {
    //   _suggestionController.text = '';
    //   qtyController.text = '';
    //   priceController.text = '';
    //   suggestionPrice = '';
    //   suggestionQuantity = '';
    //   art = Article();
    // });
  }

  @override
  void initState() {
    super.initState();
    // sale();
    // createSale();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add sale'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _suggestionController,
                    decoration: const InputDecoration(
                      labelText: 'Code produit',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  suggestionsCallback: (pattern) => getSuggestions(pattern),
                  itemBuilder: (context, suggestion) {
                    // Cette fonction est appelée pour chaque suggestion
                    // Elle retourne un widget qui affiche la suggestion
                    return ListTile(
                      title: Text(suggestion.name.toString()),
                      subtitle: Text(suggestion.price.toString()),
                      leading: Text(suggestion.quantity.toString()),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      art = suggestion;
                      suggestionQuantity = suggestion.quantity.toString();
                      suggestionPrice = suggestion.price.toString();
                    });
                    // Cette fonction est appelée lorsque l'utilisateur sélectionne une suggestion
                    _suggestionController.text = suggestion.name.toString();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veillez donner le code du produit';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: qtyController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nombre d'unité",
                  ),
                  validator: (qty) {
                    if (qty == null || qty.isEmpty) {
                      return "Veillez saisir le nombre d'article";
                    }
                    if (int.tryParse(qty) == null &&
                        int.parse(qty) > int.parse(suggestionQuantity)) {
                      return 'La saisie doit etre un entier';
                    }
                    if (int.parse(qty) > int.parse(suggestionQuantity)) {
                      return 'Stock insuffisant';
                    }
                    return null;
                  },
                ),
                suggestionQuantity != ''
                    ? Text(
                        'La quantité disponible en stock est de: $suggestionQuantity')
                    : const SizedBox(),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: priceController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Prix de vente',
                  ),
                  validator: (price) {
                    if (price == null || price.isEmpty) {
                      return 'Veillez saisir le prix de vente';
                    }
                    if (int.tryParse(price) == null) {
                      return 'Valeur incorrecte';
                    }
                    return null;
                  },
                ),
                suggestionPrice != ''
                    ? Text(
                        "Le prix de vente min est de: $suggestionPrice franc")
                    : const SizedBox(),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // _formKey.currentState!.save();
                      createSale();
                    }
                  },
                  child: const Text('Ajouter une vente'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
