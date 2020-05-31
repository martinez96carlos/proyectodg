class Order {
  String dateTime;
  String latLng;
  String imageLink;
  String details;
  String nameGenerator;
  String phoneGenerator;
  int id;
  int state;
  int rate;
  int generatorId;
  int recolectorId;
  int recolectionRate;

  Order({
    this.dateTime = "",
    this.details = "",
    this.imageLink = "",
    this.latLng = "",
    this.nameGenerator = "",
    this.phoneGenerator = "",
    this.id = 0,
    this.state = 0,
    this.rate = 0,
    this.generatorId = 0,
    this.recolectorId = 0,
    this.recolectionRate = 0,
  });

  Order.fromMap(Map map) {
    this.dateTime = map['dateTime'];
    this.details = map['details'];
    this.id = map['id'];
    this.imageLink = map['imageLink'];
    this.latLng = map['latLng'];
    this.nameGenerator = map['nameGenerator'];
    this.phoneGenerator = map['phoneGenerator'];
    this.state = map['state'];
    this.rate = map['rate'];
    this.recolectorId = map['recolectorId'];
    this.generatorId = map['generatorId'];
    this.recolectionRate = map['recolectionRate'];
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        dateTime: json['order_date'] ?? "",
        details: json['order_detail'] ?? "",
        id: json['id'] ?? 0,
        imageLink: json['order_image_url'] ?? "",
        latLng: "${json['order_latitude']},${json['order_longitude']}",
        state: json['order_state'] ?? 0,
        rate: json['order_rate'] ?? 0,
        nameGenerator:
            "${json['generator_first_name']} ${json['generator_first_lastname']}",
        generatorId: json['generator_id'] ?? 0,
        recolectorId: json['recolector_id'] ?? 0,
        phoneGenerator: json['generator_phone'] ?? "",
        recolectionRate: json['order_recolection_rate'] ?? 0);
  }

  void mostrar() {
    print("details: " + this.details);
    print("id: " + this.id.toString());
    print("image: " + this.imageLink);
    print("lat: " + this.latLng);
    print("generator: " + this.nameGenerator);
    print("phone: " + this.phoneGenerator);
    print("rate: " + this.rate.toString());
    print("state: " + this.state.toString());
    print("date: " + this.dateTime);
    print("generator id: " + this.generatorId.toString());
    print("recolector id: " + this.recolectorId.toString());
    print("recolection rate:" + this.recolectionRate.toString());
  }
}

class Solids {
  int id;
  String name;

  Solids({this.name, this.id});

  factory Solids.fromJson(Map<String, dynamic> json) {
    return Solids(id: json['solid_id'], name: json['solid_name']);
  }
}
