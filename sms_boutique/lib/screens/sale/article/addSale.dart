import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:sms_boutique/models/article.dart';

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
  String suggestionQuantity = '';
  String suggestionPrice = '';
  int nb = 0;
  int totalJournee = 0;
  String dateDay = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String time = DateFormat.Hms().format(DateTime.now());

  String price = '';

  Future<List<Article>> getSuggestions(String query) async {
    // récupérer les données de Firebase
    QuerySnapshot snapshot = await db.get();
    List<Article> artSug = [];
    // ajouter les articles dans une liste(artSug)
    for (var element in snapshot.docs) {
      artSug.add(Article(
        name: element.get('name'),
        description: element.get('description'),
        price: element.get('price'),
        image: element.get('image'),
        quantity: element.get('quantity'),
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
    await ventes.get().then((value) {
      int price = int.parse(priceController.text);
      int qty = int.parse(qtyController.text);
      int total = price * qty;
      var test = value.docs.where((element) => element.id == dateDay);
      if (test.isEmpty) {
        ventes.doc(dateDay).set({'id': dateDay, 'nbSales': 0, 'total': 0});
        // print('Creationnnnnnn réussiiiiiiiiiiiiiiii');
      } else {
        // print('on doit récupérer le nbSales===');
        // print(test.first.get('nbSales'));
        setState(() {
          nb = test.first.get('nbSales') + 1;
          totalJournee = test.first.get('total') + total;
        });
        // print(nb);
        // Ajouter la vente à la sous-collection de ventes pour le jour actuel
        ventes.doc(dateDay).update({
          'vente$nb': {'nom': 'set', 'prix': price, 'qty': qty, 'total': total},
          'nbSales': nb,
          'total':
              totalJournee, // on doit afficher le totalité des ventes journalier
          // 'timestamp': DateTime.now(),
        });
        // ventes.doc(dateDay).set({
        //   time: {'nom': 'set', 'prix': 500, 'qty': 5, 'total': 25000},
        //   // 'number': 5,
        //   'timestamp': DateTime.now(),
        // }, SetOptions(merge: true));
        // ventes.doc(dateDay).update({'nbSales': nb, 'total': 1500});
      }
    });
  }

  // // Create ventes(collection) => yyyy-MM-dd(document)
  // final dailyNodeRef = FirebaseFirestore.instance
  //     .collection('ventes')
  //     .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  // // Dès qu'on entre dans la page ventes on crée une
  // void sale() async {
  //   // For get last day saved using timestamp in ventes=>yyyy-MM-dd=>hh:mm:ss=>generate_id=>timestamps(champs)
  //   final lastSaleQuery = dailyNodeRef
  //       .collection('ventes')
  //       .orderBy('timestamp', descending: true)
  //       .limit(1);

  //   final lastSaleSnapshot = await lastSaleQuery.get();
  //   if (lastSaleSnapshot.docs.isEmpty
  //       // DateFormat('yyyy-MM-dd')
  //       //         .format(lastSaleSnapshot.docs.first['timestamp']) !=
  //       //     DateFormat('yyyy-MM-dd').format(DateTime.now())
  //       ) {
  //     print('++++++++++++++++++++++++++++++++++++++++++++++++');
  //     // Créer un nœud pour le jour actuel
  //     await dailyNodeRef.set({'nbSales': 0, 'total': 0});
  //   }
  // }

  // void addSale(String qty, String salePrice) async {
  //   await FirebaseFirestore.instance
  //       .collection('ventes')
  //       .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()))
  //       .get()
  //       .then((value) {
  //     // nb = value.get('nbSales');
  //     print(value.get('nbSales'));
  //   });
  //   // Ajouter la vente à la sous-collection de ventes pour le jour actuel
  //   // await dailyNodeRef.collection(DateFormat.Hms().format(DateTime.now())).add({
  //   //   'salePrice': int.parse(salePrice),
  //   //   'number': int.parse(qty),
  //   //   'timestamp': DateTime.now(),
  //   // });
  //   setState(() {
  //     nb++;
  //   });
  //   dailyNodeRef.update({'nbSales': nb, 'total': 1500});
  // }

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
                      // if (suggestion == null) {
                      //   print('object');
                      // }
                      suggestionQuantity = suggestion.quantity.toString();
                      suggestionPrice = suggestion.price.toString();
                    });
                    // Cette fonction est appelée lorsque l'utilisateur sélectionne une suggestion
                    _suggestionController.text = suggestion.name.toString();
                    // print('Suggestion sélectionnée: $suggestion');
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
                      // addSale(qtyController.text, priceController.text);
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
