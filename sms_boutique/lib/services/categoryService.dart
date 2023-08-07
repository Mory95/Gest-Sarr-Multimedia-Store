// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category.dart';

CollectionReference db = FirebaseFirestore.instance.collection('categories');

Future addCategory(Category category) async {
  final docRef = db
      .withConverter<Category>(
        fromFirestore: Category.fromFirestore,
        toFirestore: (Category cat, option) => cat.toFirestore(),
      )
      .doc();
  category.id = docRef.id;
  await docRef.set(category);
}

// Update category
Future updateCategory(Category category) {
  return db.doc(category.id).update(category.toJson()).then((value) {
    print('category updated');
  }).catchError((error) {
    print('Failed to update category: $error');
  });
}

// Delete category
Future<void> deleteCategory(Category category) {
  return db.doc(category.id).delete().then((value) {
    print('category deleted');
  }).catchError((error) {
    print('failed to delete category : $error');
  });
}
