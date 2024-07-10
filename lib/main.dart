import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_notetaker/database.dart';
import 'package:sqflite_notetaker/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 final db =  await openDatabases();
  runApp( MyApp(db: db,));
}

class MyApp extends StatelessWidget {
  final Database? db;
  const MyApp({super.key,  this.db});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note Taker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home:  Home(database: db,),
    );
  }
}


