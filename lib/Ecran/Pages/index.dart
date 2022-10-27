// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors

import 'package:app/Ecran/Pages/Acceuil.dart';
import 'package:app/Ecran/Pages/ListesMagasin.dart';
import 'package:app/Ecran/Pages/ListesNouveauArticle.dart';
import 'package:app/Ecran/Pages/ListesPreparation.dart';
import 'package:app/Ecran/Pages/ListesTop1000.dart';
import 'package:app/Ecran/Pages/Relever.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class index extends StatefulWidget {
  int i = 0;
  int i1 = 0;
  int i2 = 0;
  index(this.i);
  index.rel(this.i1);
  index.top(this.i2);

  @override
  State<index> createState() => _indexState();
}

class _indexState extends State<index> {
  int i = 0;
  int i1 = 0;
  int i2 = 0;

  @override
  void initState() {
    super.initState();
    i = widget.i;
    i1 = widget.i1;
    i2 = widget.i2;
  }

  List<Widget> pages = [Acceuil(), ListesPreparation(), ListesNouveauArticle(), ListesMagasin()];

  void onItemTap(int index) {
    setState(() {
      i = index;
      i1 = 0;
      i2 = 0;
    });
    print(i);
  }

  // Widget retour() {
  //   if (i1 != 0) {
  //     setState(() {
  //       i = 1;
  //     });
  //     return Relever(i1);
  //   } else if (i2 != 0) {
  //     setState(() {
  //       i = 1;
  //     });
  //     return ListesTop1000(id: i2);
  //   } else {
  //     print("avy");
  //     return pages[i];
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: pages[i],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Acceuil"),
          BottomNavigationBarItem(icon: Icon(Icons.compare), label: "Relever"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "Article"),
          BottomNavigationBarItem(icon: Icon(Icons.shop_rounded), label: "Magasin"),
        ],
        currentIndex: i,
        onTap: onItemTap,
      ),
    );
  }
}
