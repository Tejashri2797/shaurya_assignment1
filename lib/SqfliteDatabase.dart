import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfLiteDatabase {
  Database? db;
  String path = '';

  createDB() async {
    String getPath = await getDatabasesPath();
    path = join(getPath, 'demo.db');
    openDB();
  }

  openDB() async {
    db = await openDatabase(path, version: 4,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE StudentInfo(id INTEGER PRIMARY KEY,name TEXT,email TEXT,password Text, phoneNumber TEXT ,branch TEXT,subject TEXT,gender TEXT,dob TEXT,age TEXT)');
    });
  }

  insertData({
    String name = '',
    String email = '',
    String password = '',
    String phoneNumber = '',
    String branch = '',
    String subject = '',
    String gender = '',
    String dob = '',
    String age = '',
  }) async {
    await db!.insert('StudentInfo', {
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'branch': branch,
      'subject': subject,
      'gender': gender,
      'dob': dob,
      'age': age,
    });
  }

/*

  selectData() async {
    await db!
        .rawQuery('SELECT * FROM StudentInfo ')
        .then((value) => print('---- $value'));
  }
*/

  static List<Map> data = [];

  selectData() async {

     await db!.rawQuery('SELECT * FROM StudentInfo').then((value) {
       data.clear();
      value.forEach((element) {
        Map temp = element;
        data.add({
          'name': temp['name'],
          'email': temp['email'],
          'password': temp['password'],
          'phoneNumber': temp['phoneNumber'],
          'branch': temp['branch'],
          'subject': temp['subject'],
          'gender': temp['gender'],
          'dob': temp['dob'],
          'age': temp['age'],
        });
      });
    });
  }
}
