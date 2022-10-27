// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:app/Ecran/Pages/AucuneDonnes.dart';
import 'package:app/Ecran/Pages/ListesTop1000.dart';
import 'package:app/Ecran/Pages/Relever.dart';
import 'package:app/Ecran/Pages/two_letter_icon.dart';
import 'package:app/Ecran/modele/dataPreparation.dart';
import 'package:app/Ecran/modele/database_Helper.dart';
import 'package:app/Ecran/modele/preparation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sqflite/sqflite.dart';

class ListesPreparation extends StatefulWidget {
  @override
  State<ListesPreparation> createState() => _ListesPreparationState();
}

class _ListesPreparationState extends State<ListesPreparation> {
  List<Preparation> listes = [];
  Preparation prepTop = Preparation();
  String news = "";
  String news1 = "";
  int id = 0;
  bool top = false;

  Future recuperer() async {
    await DataPreparation().SelectAll().then((value) {
      //print()
      setState(() {
        listes = value;
      });
    });
    return listes;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recuperer();
  }

  Widget acc() {
    if (top == false) {
      return preparation();
    } else {
      return top1000();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: acc(),
    );
  }

  Scaffold preparation() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preparation"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                DataPreparation().Charger();

                recuperer();
              },
              icon: Icon(Icons.get_app_sharp))
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
                        Preparation prep = listes[index];

                        return SingleChildScrollView(
                          child: Slidable(
                            endActionPane: ActionPane(motion: ScrollMotion(), extentRatio: 0.5, children: [
                              SlidableAction(
                                onPressed: (context) {},
                                label: "Valider",
                                backgroundColor: Colors.green,
                                icon: Icons.add_home,
                              ),
                              Padding(padding: EdgeInsets.all(2)),
                              SlidableAction(
                                onPressed: (context) {
                                  alerte1(prep);
                                  recuperer();
                                },
                                label: "Delete",
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                              ),
                            ]),
                            child: ListTile(
                                onTap: () {
                                  setState(() {
                                    top = true;
                                    id = prep.id_prep;
                                  });
                                },
                                title: Center(child: Text(prep.libelle_prep)),
                                subtitle: Center(child: Text(prep.design_magasin)),
                                leading: TwoLetterIcon(prep.libelle_prep),
                                trailing: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward))),
                          ),
                        );
                      }),
            ),
          )),
    );
  }

  ListesTop1000 top1000() {
    return ListesTop1000(
      id: id,
    );
  }

  Future alerte1(Preparation prep) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((BuildContext context) {
          return SimpleDialog(
            // ignore: prefer_const_constructors
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
                        DataPreparation().DeletePreparation(prep.id_prep);
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
