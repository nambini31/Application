import 'dart:io';

import 'package:app/Ecran/modele/magasin.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _database;

  Future get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await create();

      return _database;
    }
  }

  Future create() async {
    Directory directory = await getApplicationSupportDirectory();
    String dataDirectory = join(directory.path, "dat9.db");
    var bdd = await openDatabase(
      dataDirectory,
      version: 1,
      onCreate: oncreate,
    );
    return bdd;
  }

  Future oncreate(Database db, int version) async {
    await db.execute("""
          CREATE TABLE enseigne( 
          id_enseigne	INTEGER PRIMARY KEY, 
          design_enseigne	TEXT NOT NULL)
    """);
    await db.execute("""

          CREATE TABLE art_nouv( 
          id	INTEGER PRIMARY KEY, 
          libele	TEXT NOT NULL,
          prix	INTEGER NOT NULL,
          gencode	INTEGER NOT NULL,
          id_enseigne	INTEGER NOT NULL,
          image TEXT NULL
          
          )
    """);
    await db.execute(""" 
    
         CREATE TABLE preparation (
         id_prep INTEGER PRIMARY KEY,
         id_enseigne INTEGER NULL,
         libelle_prep TEXT NULL,
         description TEXT NULL,
         date_prep TEXT NULL
      )
    """);

    await db.execute("""

         CREATE TABLE  releve (
         id_releve INTEGER PRIMARY KEY,
         ref_art TEXT NULL,
         libelle_art TEXT NULL,
         gencode_art TEXT NULL,
         prix_art INTEGER NULL,
        
         ref_art_conc TEXT NULL,
         libelle_art_conc TEXT NULL,
         gencode_art_conc TEXT NULL,
         prix_art_conc INTEGER NULL,

         etat_art INTEGER  NULL,
         date_val_releve TEXT NULL,
         id_prep INTEGER NULL
         
      )
    
    """);
  }
}
