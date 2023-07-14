// import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> menu = [
    'allArticles',
    'categories',
    'ventes',
    'ref'
    // 'notifications',
    // 'users'
  ];

  Widget item(name) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/$name'),
      child: Card(
        color: Colors.blueAccent,
        child: Center(
          child: Text(name),
        ),
      ),
    );
  }

/////// Function to detect a new date ///////
  // void startTimer() {
  //   DateTime now = DateTime.now();
  //   DateTime midnight =
  //       DateTime(now.year, now.month, now.day, 0, now.minute + 2, 0);
  //   Duration difference = midnight.difference(now);

  //   Timer(difference, () {
  //     // Fonction à exécuter à minuit chaque jour
  //     // Par exemple, créer un nouveau nœud pour la nouvelle journée de ventes
  //     print("youppppiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
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
            )));
  }
}
