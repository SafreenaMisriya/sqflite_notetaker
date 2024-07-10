import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_notetaker/custom_textfield.dart';
import 'package:sqflite_notetaker/database.dart';

class Adding extends StatefulWidget {
  final Database db;
  final int? id;
  final String? xtitle;
  final String? xsubtitle;
  const Adding({super.key, required this.db,this.xtitle,this.xsubtitle,this.id});

  @override
  State<Adding> createState() => _AddingState();
}

class _AddingState extends State<Adding> {

  TextEditingController titlecontroller= TextEditingController();
  TextEditingController subtitlecontroller= TextEditingController();
  @override
  void initState() {
    super.initState();
    if(widget.id !=null){
      titlecontroller.text=widget.xtitle ?? '';
      subtitlecontroller.text= widget.xsubtitle ??'';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(appBar: AppBar(title:  Text(widget.id ==null ?'ADD NOTE': 'EDIT NOTE'),centerTitle: true,),
    body: Column(children: [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           customtextfield(titlecontroller),
           customtextfield(subtitlecontroller),
           
          ],
        ),
      ),
      ElevatedButton(onPressed: () async{
      widget.id==null
        ? inserting(widget.db, titlecontroller.text, subtitlecontroller.text)
        : updatenote(widget.db, widget.id!, titlecontroller.text, subtitlecontroller.text);
        Navigator.pop(context, {'title': titlecontroller.text, 'subtitle': subtitlecontroller.text});
      }, child:const Text('Add')),

    ],),));
  }
}