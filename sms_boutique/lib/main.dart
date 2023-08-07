import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sms_boutique/screens/accounting/accounting.dart';
import 'package:sms_boutique/screens/article/addArticle.dart';
import 'package:sms_boutique/screens/article/allArticles.dart';
import 'package:sms_boutique/screens/category/category.dart';
import 'package:sms_boutique/screens/sale/article/allSales.dart';
import 'package:sms_boutique/screens/sale/article/addSale.dart';
import 'package:sms_boutique/screens/sale/repair/addRepair.dart';
import 'package:sms_boutique/screens/sale/sales.dart';
import 'package:sms_boutique/screens/spending/AddSpending.dart';
import 'package:sms_boutique/screens/spending/spending.dart';
import 'firebase_options.dart';
import 'screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Vérifie si un nœud journalier existe pour le jour actuel
  // await checkDailyNodeExists();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/allArticles': (context) => const AllArticles(),
        '/ventes': (context) => const LesVentes(),
        '/categories': (context) => const CategoryArticle(),
        '/spending': (context) => const Spend(),
        '/accounting': (context) => const Accounting(),
        '/addArticle': (context) => const AddArticle(),
        '/addSale': (context) => const AddSale(),
        '/addSpend': (context) => const AddSpending(),
        '/addRepair': (context) => const AddRepair(),
        '/ref': (context) => const AllSales(),
      },
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ThemeData.dark().colorScheme.copyWith(
              primary: Colors.blueGrey,
              onPrimary: Colors.white,
              secondary: Colors.blueGrey,
              onSecondary: Colors.white,
            ),
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}

Future<void> checkDailyNodeExists() async {
  final dailyNodeRef = FirebaseFirestore.instance
      .collection('ventes')
      .doc(DateFormat('yyyy-MM-dd').format(DateTime.now()));

  final lastSaleQuery = dailyNodeRef
      .collection(DateFormat.Hms().format(DateTime.now()))
      .orderBy('timestamp', descending: true)
      .limit(1);

  final lastSaleSnapshot = await lastSaleQuery.get();

  if (lastSaleSnapshot.docs.isEmpty ||
      DateFormat('yyyy-MM-dd')
              .format(lastSaleSnapshot.docs.first['timestamp']) !=
          DateFormat('yyyy-MM-dd').format(DateTime.now())) {
    // Créer un nœud pour le jour actuel
    await dailyNodeRef.set({'nbSales': 0, 'total': 0});
  }
}
