// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sms_boutique/screens/sale/article/allSales.dart';
import 'package:sms_boutique/screens/sale/phone/phoneSale.dart';
import 'package:sms_boutique/screens/sale/repair/repair.dart';

class LesVentes extends StatefulWidget {
  const LesVentes({super.key});

  @override
  State<LesVentes> createState() => _HomePageState();
}

class _HomePageState extends State<LesVentes> {
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

  @override
  void initState() {
    super.initState();
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
            bottom: const TabBar(tabs: <Widget>[
              Tab(
                icon: Icon(Icons.shop_outlined),
                text: 'Produits',
              ),
              Tab(
                icon: Icon(Icons.phone_iphone_outlined),
                text: 'Phone',
              ),
              Tab(icon: Icon(Icons.brightness_5_sharp), text: 'Réparation'),
            ]),
            actions: [
              IconButton(
                  onPressed: () => print('Mory is connected'),
                  icon: const Icon(
                    Icons.person,
                    size: 30,
                  ))
            ],
          ),
          body: GestureDetector(
            child: const TabBarView(children: [
              AllSales(),
              Phone(),
              Repair(),
            ]),
          )),
    );
  }
}
