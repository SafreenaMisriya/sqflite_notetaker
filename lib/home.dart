import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_notetaker/adding.dart';
import 'package:sqflite_notetaker/database.dart';

class Home extends StatefulWidget {
  final Database? database;
  const Home({super.key,  this.database});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> notes = [];
  @override
  void initState() {
    super.initState();
    fetchnotes();
  }

  fetchnotes() async {
    final data = await widget.database!.query('note');
    setState(() {
      notes = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Note Taker'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                  child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: const Color.fromARGB(255, 187, 246, 189),
                      height: 80,
                      width: 80,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Text((index + 1).toString()),
                        ),
                        title: Text(note['title']),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(note['subtitle']),
                            Text(note['name']),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () async{
                              final result= await   Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Adding(
                                                db: widget.database!,
                                                id: note['id'],
                                                xtitle: note['title'],
                                                xsubtitle: note['subtitle'],
                                                xname: note['name'],
                                              )));
                                              if(result !=null){
                                                fetchnotes();
                                              }
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  size: 30,
                                )),
                            IconButton(
                                onPressed: () async {
                                  setState(() {
                                    deletenote(widget.database!, note['id']);
                                    fetchnotes();
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  size: 30,
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () async {
            final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Adding(
                          db: widget.database!,
                        )));
            if (result != null) {
              fetchnotes();
            }
          },
          backgroundColor: Colors.deepOrange,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
