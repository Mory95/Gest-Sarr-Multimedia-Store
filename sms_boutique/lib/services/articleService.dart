// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sms_boutique/models/article.dart';

///////1:41:00
CollectionReference db = FirebaseFirestore.instance.collection('articles');

// function to get all articles
// pas obligatoire
List<Article> getAllArticle() {
  List<Article> articles = [];
  // print('--------------------------------------');
  db.get().then((QuerySnapshot value) {
    for (var element in value.docs) {
      articles.add(Article(
        name: element['name'],
        description: element['description'],
        price: element['price'],
        image: element['image'],
        author_id: element['author_id'],
        categorie_id: element['categorie_id'],
      ));
    }
    print(articles.length);
  });
  return articles;
}

// function to get specific article showArticle(Article art){}
// Pas obligatoire
// Article showArticle(String articleId) {
//   Article article = Article();
//   final art = db.where('id', isEqualTo: articleId).get();
//   article = art as Article;
//   // db.doc(articleId).get().then((value) {
//   //   if (value.exists) {
//   //     print(value.data());
//   //     // article.name= value.get('name');
//   //   }
//   // });
//   return article;
// }

// function to add article
Future addArticle(Article article) async {
  final docRef = db
      .withConverter<Article>(
        fromFirestore: Article.fromFirestore,
        toFirestore: (Article art, options) => art.toFirestore(),
      )
      .doc();
  article.id = docRef.id;
  await docRef.set(article);
}

// function to edite(update) article
Future<void> updateArticle(Article article) {
  return db.doc(article.id).update(article.toJson()).then((value) {
    print('Article updated');
  }).catchError((error) {
    print("Failed to update user: $error");
  });
}

// function to delete article
Future<void> deleteArticle(Article article) {
  return db.doc(article.id).delete().then((value) {
    print('article deleted');
  }).catchError((error) {
    print('failed to delete article : $error');
  });
}
