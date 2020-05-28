class Recolection {
  String nameRecolector;
  String nameRecolection;
  double weight;
  int orderId;
  int id;
  int idSolid;

  Recolection(
      {this.nameRecolector = "",
      this.nameRecolection = "",
      this.idSolid = 0,
      this.orderId = 0,
      this.weight = 0.0,
      this.id = 0});

  factory Recolection.fromJson(Map<String, dynamic> json) {
    return Recolection(
        id: json['id'],
        nameRecolection: json['residuo'],
        weight: json['peso_kg']/1,
        orderId: json['order_id']);
  }

  Recolection.fromMap(Map map) {
    this.nameRecolector = map['nameRecolector'];
    this.orderId = map['orderId'];
    this.weight = map['weight'] / 1;
    this.id = map['id'];
    this.nameRecolection = map['nameRecolection'];
  }

  Map<String, dynamic> toJson() {
    return {
      "solid_id": this.idSolid,
      "recolection_weight": this.weight,
    };
  }

  static List encondeToJson(List<Recolection> list) {
    List jsonList = List();
    list.map((item) => jsonList.add(item.toJson())).toList();
    return jsonList;
  }

  void mostrar() {
    print(this.nameRecolection);
    print(this.id);
    print(this.weight);
    print(this.orderId);
    print(this.idSolid);
  }
}
