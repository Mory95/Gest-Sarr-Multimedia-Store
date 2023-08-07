// import 'package:cloud_firestore/cloud_firestore.dart';
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:sms_boutique/models/article.dart';
// import 'package:sms_boutique/services/articleService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> menu = [
    'Articles',
    // 'Catégries',
    // 'Ventes',
    // 'Notifications',
    // 'Users'
  ];
  List<Article> articles = [];

  // CollectionReference articles =
  //     FirebaseFirestore.instance.collection('articles');

  Article article = Article();

  Widget item(name) {
    return InkWell(
      onTap: () {
        //////////////////add data /////////////////////////////
        // addArticle(Article(
        //     name: 'name',
        //     description: 'desc',
        //     price: '987',
        //     image: 'img',
        //     author_id: 'Los',
        //     categorie_id: 'iPhone'));

        /////////////////// update data////////////////////////////
        // updateArticle(Article(
        //     id: '7VmmqwezZAGobjMnKDMU',
        //     name: 'name updated',
        //     description: 'desc updated',
        //     price: '123 updated',
        //     image: 'img updated',
        //     author_id: 'Los updated',
        //     categorie_id: 'iPhone updated'));

        //////////////////deleted data /////////////////////////
        // deleteArticle(Article(
        //     id: 'yabO9C6ZiI8Db0VS4wV2',
        //     name: 'name updated',
        //     description: 'desc updated',
        //     price: '123 updated',
        //     image: 'img updated',
        //     author_id: 'Los updated',
        //     categorie_id: 'iPhone updated'));

        ////////////////// test get data ///////////////////////
        // FirebaseFirestore.instance
        //     .collection('Articles')
        //     .get()
        //     .then((QuerySnapshot querySnapshot) {
        //   querySnapshot.docs.forEach((doc) {
        //     print('*****************************************************');
        //     // print(doc["name"]);
        //     articles.add(Article(name: doc['name']));
        //   });
        //   for (var element in articles) {
        //     print(element.name);
        //   }
        // });
        // Navigator.pushNamed(context, '/$name');
      },
      child: Card(
        color: Colors.blueAccent,
        child: Center(
          child: Text(name),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Column(
            children: [
              Text('SMS'),
              Text(
                'Sarr Multimédia Store',
                style: TextStyle(fontSize: 15),
              ),
            ],
          )),
          actions: [
            IconButton(
                onPressed: () => print('Mory is connected'),
                icon: const Icon(
                  Icons.person,
                  size: 30,
                ))
          ],
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: menu.length,
          itemBuilder: (context, index) {
            return item(menu[index]);
          },
        ));
  }
}
