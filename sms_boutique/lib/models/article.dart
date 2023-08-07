// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  String id;
  String? name;
  String? description;
  String? price;
  String? image;
  String? quantity;
  String? author_id;
  String? categorie_id;

  Article({
    this.id = '',
    this.name,
    this.description,
    this.price,
    this.image,
    this.quantity,
    this.author_id,
    this.categorie_id,
  });

  factory Article.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Article(
      id: data?['id'],
      name: data?['name'],
      description: data?['description'],
      price: data?['price'],
      image: data?['image'],
      quantity: data?['quantity'],
      author_id: data?['author_id'],
      categorie_id: data?['categorie_id'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      if (name != null) "name": name,
      if (description != null) "description": description,
      if (price != null) "price": price,
      if (image != null) "image": image,
      if (quantity != null) "quantity": quantity,
      if (author_id != null) "author_id": author_id,
      if (categorie_id != null) "categorie_id": categorie_id,
    };
  }

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        image: json['image'],
        quantity: json['quantity'],
        author_id: json['author_id'],
        categorie_id: json['categorie_id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'image': image,
        'quantity': quantity,
        'author_id': author_id,
        'categorie_id': categorie_id,
      };
}
