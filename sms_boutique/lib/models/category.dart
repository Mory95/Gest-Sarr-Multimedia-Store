import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String id;
  final String? name;
  Category({
    this.id = '',
    this.name,
  });

  factory Category.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Category(
      id: data?['id'],
      name: data?['name'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      if (name != null) "name": name,
    };
  }

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
