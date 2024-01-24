//import 'dart:js_util';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:sqf
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Database? _database;


class localDatabase{
  // localDatabase._privateConstructor();
  // static final localDatabase instance = localDatabase._privateConstructor();
  
  List wholedata=[];
  // static final localDatabase _instance=localDatabase

  //static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  // String note="""
  //     CREATE TABLE IF NOT EXISTS localDac(
  //       id INTEGER PRIMARY KEY AUTOINCREMENT,
  //       prodCode INTEGER  UNIQUE,
  //       prodName TEXT ,
  //       purPrice REAL ,
  //       sellPrice REAL,
  //       username TEXT ,
  //       password TEXT 
  //     )"""
  //     ;
  Future<Database> get database async{
    if(_database != null){
      return _database!;
    }
    _database= await _initializeDB("Locall.db");
    return _database!;
  }

  Future<Database> _initializeDB(String filepath) async{
    final dbpath= await getDatabasesPath();
    final path = join(dbpath,filepath);
    return await openDatabase(path,version: 3,onCreate: _createDB);
  }

  Future _createDB(Database db,int version)async{
    try{await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS Localdac(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        prodCode INTEGER  UNIQUE,
        prodName TEXT ,
        purPrice REAL ,
        sellPrice REAL,
        image TEXT
      )
'''

    );
    await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS Login(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT
      )
'''

    );
    }
    catch (e) {
  print("Error: $e");
}
  } 

  Future addDataLocally({pid,pName,pprice,sprice,imag})async{
     try{final db=await database;
     await db.insert('Localdac', {"prodCode":pid,"prodName":pName,"purPrice":pprice,"sellPrice":sprice,"image":imag});
     //await db.close();
     print(pid+pName+pprice+sprice+imag);
     print("data entered");}
     catch(e){ 
       print("Error reading data: $e");
    return "error";
     }
  }
  
  Future readAllData()async{
    try{final db=await database;
    final alldata=await db.query('Localdac');
    wholedata=alldata;
    print(wholedata);
    //return wholedata;
    }
    catch(e){
      print("Error reading data: $e");
    return "error";
    }
  }

  Future updateData({Name,id,pprice,sprice,image}) async{
    try{
      final db=await database;
      int dbupdate=await db.update('Localdac',
      {
        'prodName': Name,
        'purPrice': pprice,
        'sellPrice': sprice,
        'image':image
      },
      where: 'prodCode = ?',
      whereArgs: [id],);
      return dbupdate;
    }
    catch(e){
      print("Error updating data: $e");
    return "error";
    }
  }

  Future deletedata({ id})async{
    try{
      final db=await database;
     db!.delete('Localdac',where: 'prodCode=?',whereArgs: [id]);
    }
    catch(e){
      print("Error deleting data: $e");
    return "error";
    }
  }
  Future<bool> isIdAlreadyExists(String enteredId) async {
  final db = await database; // Assuming you have a function that gets the database
  final result = await db.query(
    'Localdac',
    where: 'prodCode = ?',
    whereArgs: [enteredId],
  );

  return result.isNotEmpty; // Returns true if the ID already exists, false otherwise
}
Future<bool> login(String enteredId,String pass) async {
  final db = await database; // Assuming you have a function that gets the database
  final result = await db.query(
    'Login',
    where: 'username = ? AND password = ?',
    whereArgs: [enteredId,pass],
  );

  return result.isNotEmpty; // Returns true if the ID already exists, false otherwise
}
Future save({pid,pName})async{
     try{final db=await database;
     await db.insert('Login', {"username":pName,"password":pid,});
     //await db.close();
     print(pid+pName);
     print("data entered");}
     catch(e){ 
       print("Error reading data: $e");
    return "error";
     }
  }

  getData() {}
}