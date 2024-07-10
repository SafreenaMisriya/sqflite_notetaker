import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_notetaker/custom_textfield.dart';
import 'package:sqflite_notetaker/database.dart';

class Adding extends StatefulWidget {
  final Database db;
  final int? id;
  final String? xtitle;
  final String? xsubtitle;
    final String? xname;
  const Adding({super.key, required this.db,this.xtitle,this.xsubtitle,this.id,this.xname});

  @override
  State<Adding> createState() => _AddingState();
}

class _AddingState extends State<Adding> {

  TextEditingController titlecontroller= TextEditingController();
  TextEditingController subtitlecontroller= TextEditingController();
  TextEditingController namecontroller= TextEditingController();
  @override
  void initState() {
    super.initState();
    if(widget.id !=null){
      titlecontroller.text=widget.xtitle ?? '';
      subtitlecontroller.text= widget.xsubtitle ??'';
      namecontroller.text=widget.xname??'';
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
           customtextfield(namecontroller),
           
          ],
        ),
      ),
      ElevatedButton(onPressed: () async{
      widget.id==null
        ? inserting(widget.db, titlecontroller.text, subtitlecontroller.text,namecontroller.text)
        : updatenote(widget.db, widget.id!, titlecontroller.text, subtitlecontroller.text,namecontroller.text);
        Navigator.pop(context, {'title': titlecontroller.text, 'subtitle': subtitlecontroller.text,'name':namecontroller.text});
      }, child:const Text('Add')),

    ],),));
  }
}