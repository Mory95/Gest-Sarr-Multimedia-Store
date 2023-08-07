// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sms_boutique/screens/article/detailsArticle.dart';
import 'package:sms_boutique/screens/article/editArticle.dart';
import 'package:sms_boutique/services/articleService.dart';

import '../../models/article.dart';

class AllArticles extends StatefulWidget {
  const AllArticles({super.key});

  @override
  State<AllArticles> createState() => _ArticlesState();
}

class _ArticlesState extends State<AllArticles> {
  @override
  Widget build(BuildContext context) {
    List<Article> allArticles = [];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nos articles'),
          actions: [
            IconButton(
                onPressed: () => print('seach'), icon: const Icon(Icons.search))
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('articles').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }
            if (snapshot.hasData) {
              // allArticles = snapshot.data!.docs.map((doc) => Article.fromJson(doc.data() as Map<String, dynamic>)).toList();
              allArticles = snapshot.data!.docs
                  .map((doc) => Article.fromJson(doc.data()))
                  .toList();
              return ListView.builder(
                  itemCount: allArticles.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, '/DetailsArticle');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsArticle(article: allArticles[index]),
                          ),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                              child: Text(
                            allArticles[index]
                                .name!
                                .substring(0, 2)
                                .toUpperCase(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )),
                          title: Text(allArticles[index].name.toString()),
                          subtitle: Text(allArticles[index].price.toString()),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => EditArticle(
                                            article: allArticles[index]),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                onPressed: () {
                                  // print(allArticles[index].id);
                                  deleteArticle(allArticles[index]);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/addArticle'),
          child: const Icon(Icons.add),
        ));
  }
}
