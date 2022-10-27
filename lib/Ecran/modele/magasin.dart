class Item {
  int _id_enseigne = 0;
  String _design_enseigne = "";

  int get id_enseigne => this._id_enseigne;

  set id_enseigne(int value) => this._id_enseigne = value;

  get design_enseigne => this._design_enseigne;

  set design_enseigne(value) => this._design_enseigne = value;

  Item();

  fromMap(Map<String, dynamic> map) {
    if (map["id_enseigne"] != null) {
      id_enseigne = map["id_enseigne"];
    }
    design_enseigne = map["design_enseigne"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {"design_enseigne": design_enseigne};
    return map;
  }
}
