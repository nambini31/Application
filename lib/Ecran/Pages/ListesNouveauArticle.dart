// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:app/Ecran/Modifier/ModifNouveauArticle.dart';
import 'package:app/Ecran/Pages/AucuneDonnes.dart';
import 'package:app/Ecran/Ajout/AjoutNouveauArticle.dart';
import 'package:app/Ecran/Pages/ListesMagasin.dart';
import 'package:app/Ecran/Pages/NouveauArticleDetails.dart';
import 'package:app/Ecran/Pages/index.dart';
import 'package:app/Ecran/modele/article.dart';
import 'package:app/Ecran/modele/dataArticle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'two_letter_icon.dart';

class ListesNouveauArticle extends StatefulWidget {
  const ListesNouveauArticle({super.key});

  @override
  State<ListesNouveauArticle> createState() => _PagesListeState();
}

enum Actions { Update, Delete }

class _PagesListeState extends State<ListesNouveauArticle> {
  TextEditingController nom = TextEditingController();
  TextEditingController nom1 = TextEditingController();
  List<Article> listes = [];

  String news = "";
  String news1 = "";

  void recuperer() async {
    try {
      await DataArticle().SelectAll().then((value) {
        //print(object)
        listes = value;
        setState(() => listes);
      });
    } catch (e) {
      //print("tsys data");
    }
  }

  //SlidableController final  =  SlidableController ();

  @override
  void initState() {
    // TODO: implement initStatess
    super.initState();
    recuperer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Listes des Articles"),
        automaticallyImplyLeading: false,
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AjoutNouveauArticle(),
                  ));
            },
            icon: Icon(Icons.add),
          ),
          // IconButton(
          //     onPressed: () {
          //       // Navigator.push(
          //       //     context,
          //       //     MaterialPageRoute(
          //       //       builder: (context) => PagesNouveauArticle(),
          //       //     ));
          //     },
          //     icon: Icon(Icons.more_vert))
        ],
      ),
      body: GestureDetector(
        onTap: () {
          //print("clicked");
          //Slidable.of(context)!.close(duration: Duration(seconds: 0));
        },
        child: SlidableAutoCloseBehavior(
          closeWhenOpened: true,
          closeWhenTapped: true,
          child: Center(
            child: (listes.isEmpty)
                ? AucuneDonnes()
                : ListView.builder(
                    itemCount: listes.length,
                    itemBuilder: (context, index) {
                      Article article = listes[index];
                      return SingleChildScrollView(
                        child: Slidable(
                          endActionPane: ActionPane(motion: ScrollMotion(), extentRatio: 0.5, children: [
                            SlidableAction(
                              onPressed: (context) {
                                alerte1(article);
                              },
                              label: "Delete",
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                            ),
                            Padding(padding: EdgeInsets.all(2)),
                            SlidableAction(
                              onPressed: (context) {
                                //nom1.text = Article.nom;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ModifNouveauArticle.modification(article),
                                    ));
                              },
                              label: "Update",
                              backgroundColor: Colors.blue,
                              icon: Icons.update,
                            )
                          ]),
                          child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NouveauArticleDetails(article),
                                    ));
                              },
                              title: Text(article.libele),
                              subtitle: Text("Prix : " + article.prix.toString()),
                              leading: TwoLetterIcon(
                                article.libele,
                              ),
                              trailing: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward))),
                        ),
                      );
                    }),
          ),
        ),
      ),
    );
  }

  Future alert() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Container(
          //width: 100,
          height: 140,
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 45,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      news = value;
                    });
                  },
                  controller: nom,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(2),
                      filled: true,
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    // Article Article = Article();
                    // Article.nom = news;
                    // dataArticle().AjoutArticle(Article);
                    // //print("ajout");
                    // recuperer();
                    // Navigator.pop(context);
                  },
                  child: Text("Ajouter"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future alertmodif(Article article) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SimpleDialog(
        title: Text("Voulez vous modifier"),
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: () {}, child: Text("")),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                            ))
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future alerte1(Article Article) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((BuildContext context) {
          return SimpleDialog(
            title: Text(
              "simple dialog",
              style: TextStyle(),
            ),
            contentPadding: EdgeInsets.all(10),
            children: [
              Text("Suppression definitive"),
              SizedBox(
                width: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        DataArticle().DeleteArticle(Article.id);
                        recuperer();
                      },
                      child: Text("OUI")),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Non",
                      ))
                ],
              )
            ],
          );
        }));
  }
}
