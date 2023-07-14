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
    print(widget.article.name);
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.article;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article'),
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
                'Name: ${data.name}\nDescription: ${data.description}\nPrix: ${data.price}\nQuantité en stock: ${data.quantity}\nCategorie: ${data.categorie_id}\nAutheur: ${data.author_id}',
                style: const TextStyle(fontSize: 25.0),
              ),

              // Text('Name: ${data.name}'),
              // Text('Description: ${data.description}'),
              // Text('Prix: ${data.price}'),
              // Text('Quantité en stock: ${data.quantity}'),
              // Text('Categorie: ${data.categorie_id}'),
              // Text('Autheur: ${data.author_id}'),
            ],
          ),
        ),
      ),
    );
  }
}
