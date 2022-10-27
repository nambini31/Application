// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:app/Ecran/Nouvelle%20Article/AjoutArticle.dart';
import 'package:app/Ecran/modele/database_Helper.dart';
import 'package:app/Ecran/modele/article.dart';
import 'package:app/Ecran/modele/preparation.dart';
import 'package:app/Ecran/modele/top1000.dart';
import 'package:sqflite/sqflite.dart';

class DataPreparation {
  Future<Top1000> chargeArticle() async {
    Database db = await DatabaseHelper().database;
    //await db.rawQuery("DELETE FROM releve");
    Top1000 prep1 = Top1000.id(1, "P01", "Volnics", "102546895125", 5000, "C01", "Cristaline", "9501046018901", 0, 0, "", 1);
    Top1000 prep10 = Top1000.id(10, "P10", "John P", "78785545454", 15000, "C10", "Eau Vive", "9501046019205", 0, 0, "", 1);
    Top1000 prep2 = Top1000.id(2, "P02", "Coca Cola", "8768951245", 4000, "C02", "test1", "950104601547", 0, 0, "", 1);
    Top1000 prep3 = Top1000.id(3, "P03", "Big Cola", "87546851245", 3000, "C03", "test2", "950104601545", 0, 0, "", 1);
    Top1000 prep4 = Top1000.id(4, "P04", "THB", "8768951245", 7000, "C04", "test3", "950104601854", 0, 0, "", 1);
    Top1000 prep5 = Top1000.id(5, "P05", "Queens", "87468951245", 8000, "C05", "test4", "9501046018954", 0, 0, "", 1);
    Top1000 prep6 = Top1000.id(6, "P06", "Appolo", "65468951245", 9000, "C06", "tes5", "95010460182535", 0, 0, "", 1);
    Top1000 prep7 = Top1000.id(7, "P07", "Citron Barr1", "54468951245", 2000, "C07", "test6", "950146014577", 0, 0, "", 1);
    Top1000 prep8 = Top1000.id(8, "P08", "Nougat1", "54446895125", 18230, "C08", "tes7", "95010462536", 0, 0, "", 1);
    Top1000 prep9 = Top1000.id(9, "P09", "Vodka1", "66566356568", 12000, "C09", "test58", "950104601898", 0, 0, "", 1);
    Top1000 prep11 = Top1000.id(71, "P07", "Citron Barre1", "54468951245", 2000, "C075", "test65", "950146014577", 0, 0, "", 1);
    Top1000 prep12 = Top1000.id(84, "P08", "Nougat1", "54446895125", 18230, "C08", "tes75", "95010462536", 0, 0, "", 1);
    Top1000 prep13 = Top1000.id(95, "P09", "Vodka1", "66566356568", 12000, "C09", "test85", "950104601898", 0, 0, "", 1);

    List data = [prep1, prep2, prep3, prep4, prep5, prep6, prep7, prep8, prep9, prep10, prep11, prep12, prep13];

    data.forEach((element) async {
      try {
        await db.insert("releve", element.toMap());
      } catch (e) {}
    });

    //await db.rawQuery("DELETE FROM preparation");
    //int id = await db.rawInsert("INSERT INTO preparation(libele,prix,gencode,image,magasin) VALUES('coca',2225,656565665,'jhuik','oilkhgt')");
    //"INSERT INTO preparation(id,libele,prix,gencode,image,magasin) VALUES('${article.getLibele}','${article.getPrix}','${article.getGencode}','${article.getImage}','${article.getMagasin}')");

    return prep1;
  }

  Future<Preparation> Charger() async {
    chargeArticle();
    Database db = await DatabaseHelper().database;
    Preparation prep3 = Preparation.id(3, "Pa curiosité prep2", "blablabla bla jhihihi", "2022-09-11 09:53:10", 3);
    Preparation prep2 = Preparation.id(2, "Va prep", "blablabla bla jhihihi", "2022-11-11 20:53:10", 2);

    Preparation prep1 = Preparation.id(1, "Notre prep", "blablabla bla jhihihi", "2022-03-11 12:53:10", 1);
    try {
      await db.insert("preparation", prep1.toMap());
    } catch (e) {}

    try {
      await db.insert("preparation", prep2.toMap());
    } catch (e) {}
    try {
      await db.insert("preparation", prep3.toMap());
    } catch (e) {}
    //await db.rawQuery("DELETE FROM preparation");
    //int id = await db.rawInsert("INSERT INTO preparation(libele,prix,gencode,image,magasin) VALUES('coca',2225,656565665,'jhuik','oilkhgt')");
    //"INSERT INTO preparation(id,libele,prix,gencode,image,magasin) VALUES('${article.getLibele}','${article.getPrix}','${article.getGencode}','${article.getImage}','${article.getMagasin}')");

    return prep1;
  }

  Future DeletePreparation(int id) async {
    Database db = await DatabaseHelper().database;
    await db.delete("preparation", where: "id_prep = ?", whereArgs: [id]);
    //await db.rawDelete("DELETE FROM Article WHERE id = $id ");
  }

  Future<List<Preparation>> SelectAll() async {
    List<Preparation> listes = [];
    Database db = await DatabaseHelper().database;

    List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT preparation.*,enseigne.design_enseigne FROM preparation INNER JOIN enseigne ON preparation.id_enseigne = enseigne.id_enseigne");
    //List<Map<String, dynamic>> resulti = await db.query("Article", where: "", orderBy: "is ASC");
    result.forEach((MapElement) {
      Preparation article = Preparation();
      article.fromMap(MapElement);
      listes.add(article);
    });

    return listes;
  }
}
