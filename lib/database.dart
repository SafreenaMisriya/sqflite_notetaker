import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openDatabases() async {
  final databasepath = await getDatabasesPath();
  final path = join(databasepath, 'database.db');
  return await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''
CREATE TABLE note(id INTEGER PRIMARY KEY, title TEXT ,subtitle TEXT )
 ''');
    },
  );
}
Future<void>inserting(Database db,String title,String subtitle)async{
 await db.insert( 'note',
    {'title': title, 'subtitle': subtitle},);
    
}

Future<void> updatenote(Database db, int id, String title, String subtitle) async {
  await db.update(
    'note',
    {'title': title, 'subtitle': subtitle},
    where: 'id = ?',
    whereArgs: [id],
  );
  
}
Future<void> deletenote(Database db, int id) async {
  await db.delete(
    'note',
    where: 'id = ?',
    whereArgs: [id],
  );
  
}