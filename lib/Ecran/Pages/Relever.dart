// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:app/Ecran/Pages/index.dart';
import 'package:app/Ecran/modele/dataTop1000.dart';
import 'package:app/Ecran/modele/magasin.dart';
import 'package:app/Ecran/modele/top1000.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class Relever extends StatefulWidget {
  int id_prep;
  Relever(this.id_prep);

  @override
  State<Relever> createState() => _ReleverState();
}

class _ReleverState extends State<Relever> {
  List<DropdownMenuItem<String?>> listesvrai = [];
  String valueChange = "";

  String selectgencode = "";
  String selectlibelle = "";
  int id_choix = 1;

  TextEditingController searchController = TextEditingController();
  TextEditingController prixController = TextEditingController();
  TextEditingController scanController = TextEditingController();

  Future recuperer() async {
    ["Rechercher article", "Scanner le code barre"].forEach((element) {
      listesvrai.add(DropdownMenuItem(
        value: id_choix.toString(),
        child: Text(element),
      ));
      setState(() {
        id_choix = id_choix + 1;
      });
    });
    setState(() => listesvrai);
  }

  Future<List<Item>> onTapSearch(String query) async {
    List<Top1000> listesToutes = [];
    await DataTop1000().SelectAll(widget.id_prep).then((value) {
      listesToutes = value;
    });
    List<Item> search = [];
    listesToutes.forEach((element) {
      Item item = Item();
      item.id_enseigne = int.parse(element.gencode_art_conc);
      item.design_enseigne = element.libelle_art_conc;
      search.add(item);
    });
    search.retainWhere((element) => element.design_enseigne.toString().toLowerCase().contains(query.toLowerCase()));

    return search;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recuperer();
    scanController.text = "Cristalline";
    id_choix = 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Relever de prix")),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => index.top(widget.id_prep),
                  ));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(5)),
            Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: DropdownButtonFormField2(
                value: id_choix.toString(),
                items: listesvrai,
                hint: Text("Choix Relever"),
                onChanged: (value) {
                  id_choix = int.parse(value.toString());
                  setState(() => id_choix);

                  print(id_choix);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  filled: true,
                  //hintText: "Magasin",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
                  //contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                  prefixIcon: Icon(
                    Icons.select_all,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: (id_choix == 1)
                  ? TypeAheadFormField(
                      validator: (value) => (value!.isEmpty || valueChange != selectgencode) ? "Aucun article correspondant" : null,
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: searchController,

                        autocorrect: false,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
                          //contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                          //labelText: "Nom",
                          hintText: "Rechercher article",
                          prefixIcon: Container(
                            width: 50,
                            child: Icon(
                              Icons.search,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            valueChange = value;
                          });
                        },
                        onTap: () {
                          //print(valeur);
                        },

                        // validator: (value) => value!.isEmpty ? "Veuillez entrer la designation" : null,
                        // onSaved: (newValue) {
                        //   //nom = newValue!;
                        // },
                      ),
                      noItemsFoundBuilder: (context) => SizedBox(
                        height: 40,
                        child: Center(
                          child: Text("Article introuvable"),
                        ),
                      ),
                      suggestionsBoxDecoration: SuggestionsBoxDecoration(
                          constraints: BoxConstraints(maxHeight: 200),
                          elevation: 4.0,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),
                      itemBuilder: (context, itemData) {
                        return Row(
                          children: [
                            SizedBox(width: 3),
                            Icon(Icons.refresh),
                            SizedBox(width: 3),
                            Container(padding: EdgeInsets.all(5), height: 30, child: Text(itemData.design_enseigne))
                          ],
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        searchController.text = suggestion.design_enseigne;

                        setState(() {
                          selectgencode = suggestion.id_enseigne.toString();
                          selectlibelle = suggestion.design_enseigne;
                        });
                      },
                      suggestionsCallback: (pattern) {
                        print(pattern);
                        return onTapSearch(pattern);
                      },
                    )
                  : TextFormField(
                      controller: scanController,

                      // textAlign: TextAlign.center,
                      enabled: false,
                      autocorrect: false,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 0),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
                        //contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                        //labelText: "Nom",
                        hintText: "Scan Code barre",
                        prefixIcon: Container(
                          margin: EdgeInsets.only(right: 20),
                          width: 55,
                          child: TextButton.icon(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.only(left: 7),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                )),
                            label: Text(""),
                            onPressed: () {},
                            icon: Icon(Icons.camera_alt),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        //libele = value;
                      },
                      onTap: () {
                        //print(valeur);
                      },
                      validator: (value) => value!.isEmpty ? "Aucun article correspondant" : null,
                      onSaved: (newValue) {
                        //nom = newValue!;
                      },
                      //onSubmitted: submit,
                    ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextFormField(
                controller: prixController,

                autocorrect: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(1)),
                  //contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                  //labelText: "Nom",
                  hintText: "Entrer le Prix",
                  prefixIcon: Container(
                    width: 50,
                    child: Icon(
                      Icons.price_change_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ),
                onChanged: (value) {
                  //libele = value;
                },
                onTap: () {
                  //print(valeur);
                },
                validator: (value) => value!.isEmpty ? "Veuillez entrer la designation" : null,
                onSaved: (newValue) {
                  //nom = newValue!;
                },
                //onSubmitted: submit,
              ),
            )
          ],
        ),
      ),
    );
  }
}
