// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sms_boutique/models/article.dart';

// ignore: must_be_immutable
class DetailsArticle extends StatefulWidget {
  Article article;
  DetailsArticle({
    super.key,
    required this.article,
  });

  @override
  State<DetailsArticle> createState() => _DetailsArticleState();
}

class _DetailsArticleState extends State<DetailsArticle> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.article;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail article'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10.0)),
                margin: const EdgeInsets.only(bottom: 10.0),
                height: 300.0,
                width: 450.0,
                child: const Text('Image article'),
              ),
              Text(
                'Name: ${data.name}\nDescription: ${data.description}\nPrix: ${data.price} FCFA\nQuantité en stock: ${data.quantity}\nCategorie: ${data.categorie_id}\nAutheur: ${data.author_id}',
                style: const TextStyle(fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
