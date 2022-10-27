// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:app/Ecran/Nouvelle%20Article/AjoutArticle.dart';
import 'package:app/Ecran/modele/database_Helper.dart';
import 'package:app/Ecran/modele/article.dart';
import 'package:app/Ecran/modele/preparation.dart';
import 'package:app/Ecran/modele/top1000.dart';
import 'package:sqflite/sqflite.dart';

class DataTop1000 {
  // Future DeletePreparation(int id) async {
  //   Database db = await DatabaseHelper().database;
  //   await db.delete("preparation", where: "id_prep = ?", whereArgs: [id]);
  //   //await db.rawDelete("DELETE FROM Article WHERE id = $id ");
  // }

  Future<List<Top1000>> SelectAll(int id) async {
    List<Top1000> listes = [];
    Database db = await DatabaseHelper().database;

    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM releve WHERE id_prep = ${id} ");
    //List<Map<String, dynamic>> resulti = await db.query("Article", where: "", orderBy: "is ASC");
    result.forEach((MapElement) {
      Top1000 article = Top1000();
      article.fromMap(MapElement);
      listes.add(article);
    });

    return listes;
  }

  Future<List<Top1000>> SelectAttente(int id) async {
    List<Top1000> listes = [];
    Database db = await DatabaseHelper().database;

    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM releve WHERE id_prep = ${id} AND etat_art = 0 AND date_val_releve != '' ");
    //List<Map<String, dynamic>> resulti = await db.query("Article", where: "", orderBy: "is ASC");
    result.forEach((MapElement) {
      Top1000 article = Top1000();
      article.fromMap(MapElement);
      listes.add(article);
    });

    return listes;
  }

  Future<List<Top1000>> SelectValider(int id) async {
    List<Top1000> listes = [];
    Database db = await DatabaseHelper().database;

    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM releve WHERE id_prep = ${id} AND etat_art = 1 ");
    //List<Map<String, dynamic>> resulti = await db.query("Article", where: "", orderBy: "is ASC");
    result.forEach((MapElement) {
      Top1000 article = Top1000();
      article.fromMap(MapElement);
      listes.add(article);
    });

    return listes;
  }

  Future<List<Top1000>> SearchAll(int id, String txt) async {
    List<Top1000> listes = [];
    Database db = await DatabaseHelper().database;

    List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT * FROM releve WHERE id_prep = ${id} AND (ref_art LIKE '%$txt%' OR libelle_art LIKE '%$txt%' OR gencode_art LIKE '%$txt%' OR prix_art LIKE '%$txt%' OR ref_art_conc LIKE '%$txt%' OR libelle_art_conc LIKE '%$txt%' OR gencode_art_conc LIKE '%$txt%' OR prix_art_conc LIKE '%$txt%' OR date_val_releve LIKE '%$txt%' ) ");
    //List<Map<String, dynamic>> resulti = await db.query("Article", where: "", orderBy: "is ASC");
    result.forEach((MapElement) {
      Top1000 article = Top1000();
      article.fromMap(MapElement);
      listes.add(article);
    });

    return listes;
  }

  Future<List<Top1000>> SearchAttente(int id, String txt) async {
    List<Top1000> listes = [];
    Database db = await DatabaseHelper().database;

    List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT * FROM releve WHERE id_prep = ${id} AND etat_art = 0 AND date_val_releve != '' AND (ref_art LIKE '%$txt%' OR libelle_art LIKE '%$txt%' OR gencode_art LIKE '%$txt%' OR prix_art LIKE '%$txt%' OR ref_art_conc LIKE '%$txt%' OR libelle_art_conc LIKE '%$txt%' OR gencode_art_conc LIKE '%$txt%' OR prix_art_conc LIKE '%$txt%' OR date_val_releve LIKE '%$txt%' )  ");
    //List<Map<String, dynamic>> resulti = await db.query("Article", where: "", orderBy: "is ASC");
    result.forEach((MapElement) {
      Top1000 article = Top1000();
      article.fromMap(MapElement);
      listes.add(article);
    });

    return listes;
  }

  Future<List<Top1000>> SearchValider(int id, String txt) async {
    List<Top1000> listes = [];
    Database db = await DatabaseHelper().database;

    List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT * FROM releve WHERE id_prep = ${id} AND etat_art = 1 AND (ref_art LIKE '%$txt%' OR libelle_art LIKE '%$txt%' OR gencode_art LIKE '%$txt%' OR prix_art LIKE '%$txt%' OR ref_art_conc LIKE '%$txt%' OR libelle_art_conc LIKE '%$txt%' OR gencode_art_conc LIKE '%$txt%' OR prix_art_conc LIKE '%$txt%' OR date_val_releve LIKE '%$txt%' ) ");
    //List<Map<String, dynamic>> resulti = await db.query("Article", where: "", orderBy: "is ASC");
    result.forEach((MapElement) {
      Top1000 article = Top1000();
      article.fromMap(MapElement);
      listes.add(article);
    });

    return listes;
  }
}
