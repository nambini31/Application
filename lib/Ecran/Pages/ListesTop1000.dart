// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, non_constant_identifier_names

import 'package:app/Ecran/Pages/AucuneDonnes.dart';
import 'package:app/Ecran/Pages/index.dart';
import 'package:app/Ecran/modele/dataTop1000.dart';
import 'package:app/Ecran/modele/preparation.dart';
import 'package:app/Ecran/modele/top1000.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ListesTop1000 extends StatefulWidget {
  int id = 0;
  ListesTop1000({required this.id});

  @override
  State<ListesTop1000> createState() => _ListesTop1000State();
}

class _ListesTop1000State extends State<ListesTop1000> {
  List<Top1000> listesToutes = [];
  List<Top1000> listesAttente = [];
  List<Top1000> listesValider = [];

  int i = 0;

  bool rel = false;

  Future recuperer() async {
    await DataTop1000().SelectAll(widget.id).then((value) {
      //print()
      setState(() {
        listesToutes = value;
      });
    });
    await DataTop1000().SelectAttente(widget.id).then((value) {
      //print()
      setState(() {
        listesAttente = value;
      });
    });
    await DataTop1000().SelectValider(widget.id).then((value) {
      //print()
      setState(() {
        listesValider = value;
      });
    });
    //return listesToutes;
  }

  Future search(String txt) async {
    if (i == 0) {
      await DataTop1000().SearchAll(widget.id, txt).then((value) {
        //print()
        setState(() {
          listesToutes = value;
        });
      });
    } else if (i == 1) {
      await DataTop1000().SearchAttente(widget.id, txt).then((value) {
        //print()
        setState(() {
          listesAttente = value;
        });
      });
    } else {
      await DataTop1000().SearchValider(widget.id, txt).then((value) {
        //print()
        setState(() {
          listesValider = value;
        });
      });
    }

    //return listesToutes;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recuperer();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => index.rel(widget.id),
                        ));
                  },
                  icon: Icon(Icons.takeout_dining))
            ],
            title: Text("TOP 1000"),
            leading: rel
                ? Icon(
                    Icons.arrow_back,
                    color: Colors.transparent,
                  )
                : IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => index(1),
                          ));
                    },
                    icon: Icon(Icons.arrow_back)),
          ),
          body: DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(110),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  titleSpacing: 15,
                  title: Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          search(value);
                        });
                      },
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(2),
                        prefixIcon: Icon(Icons.search),
                        prefixIconColor: Colors.grey,
                        hintText: "Rechercher",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
                      ),
                    ),
                  ),
                  bottom: TabBar(
                      onTap: (value) {
                        setState(() {
                          i = value;
                        });
                      },
                      tabs: [
                        Tab(
                          text: "Tous",
                        ),
                        Tab(
                          text: "En attente",
                        ),
                        Tab(
                          text: "Valider",
                        )
                      ]),
                ),
              ),
              body: TabBarView(children: [
                Toutes(),
                Attente(),
                Valide(),
              ]),
            ),
          ),
        ));
  }

  Container Toutes() {
    return Container(
      //color: Colors.white,
      child: SlidableAutoCloseBehavior(
        closeWhenOpened: true,
        closeWhenTapped: true,
        child: Center(
          child: (listesToutes.isEmpty)
              ? AucuneDonnes()
              : ListView.builder(
                  itemCount: listesToutes.length,
                  itemBuilder: (context, index) {
                    Top1000 top1000 = listesToutes[index];

                    return SingleChildScrollView(
                        child: Slidable(
                      // endActionPane: ActionPane(motion: ScrollMotion(), extentRatio: 0.5, children: [
                      //   SlidableAction(
                      //     onPressed: (context) {
                      //       // alerte1(prep);
                      //       // recuperer();
                      //     },
                      //     label: "relever",
                      //     backgroundColor: Colors.amberAccent,
                      //     icon: Icons.delete,
                      //   ),
                      // ]),
                      child: ListTile(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        title: Text(top1000.libelle_art),
                        subtitle: Center(child: Text("Prix : ${top1000.prix_art}")),
                        leading: Icon(Icons.article),
                        trailing: icone(top1000.etat_art, top1000.date_val_releve),
                      ),
                    ));
                  }),
        ),
      ),
    );
  }

  Icon icone(int etat, String date) {
    var iconValide = Icon(
      Icons.check_circle,
      color: Colors.green,
    );
    var iconAttente = Icon(
      Icons.check_circle,
      color: Colors.orange,
    );
    var iconNon = Icon(
      Icons.check_circle,
      color: Colors.grey,
    );

    if (etat == 1) {
      return iconValide;
    } else if (etat == 0 && date != "") {
      return iconAttente;
    } else {
      return iconNon;
    }
  }

  Container Attente() {
    return Container(
      child: SlidableAutoCloseBehavior(
        closeWhenOpened: true,
        closeWhenTapped: true,
        child: Center(
          child: (listesAttente.isEmpty)
              ? AucuneDonnes()
              : ListView.builder(
                  itemCount: listesAttente.length,
                  itemBuilder: (context, index) {
                    Top1000 top1000 = listesAttente[index];

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
                            // alerte1(prep);
                            // recuperer();
                          },
                          label: "relever",
                          backgroundColor: Colors.amberAccent,
                          icon: Icons.delete,
                        ),
                      ]),
                      child: ListTile(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        title: Center(child: Text(top1000.libelle_art)),
                        subtitle: Center(child: Text("Prix : ${top1000.prix_art}")),
                        leading: Icon(Icons.article),
                        trailing: icone(top1000.etat_art, top1000.date_val_releve),
                      ),
                    ));
                  }),
        ),
      ),
    );
  }

  Container Valide() {
    return Container(
      child: SlidableAutoCloseBehavior(
        closeWhenOpened: true,
        closeWhenTapped: true,
        child: Center(
          child: (listesValider.isEmpty)
              ? AucuneDonnes()
              : ListView.builder(
                  itemCount: listesValider.length,
                  itemBuilder: (context, index) {
                    Top1000 top1000 = listesValider[index];

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
                            // alerte1(prep);
                            // recuperer();
                          },
                          label: "relever",
                          backgroundColor: Colors.amberAccent,
                          icon: Icons.delete,
                        ),
                      ]),
                      child: ListTile(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        title: Center(child: Text(top1000.libelle_art)),
                        subtitle: Center(child: Text("Prix : ${top1000.prix_art}")),
                        leading: Icon(Icons.article),
                        trailing: icone(top1000.etat_art, top1000.date_val_releve),
                      ),
                    ));
                  }),
        ),
      ),
    );
  }
}
