class User {
  String name;
  String secondName;
  String lastName;
  String secondLastName;
  String email;
  String password;
  int gender;
  String date;
  String dni;
  String phone;
  String imageLink;
  String passwordConfirm;
  double rate;
  int id;

  User(
      {this.name = "",
      this.email = "",
      this.gender = 0,
      this.lastName = "",
      this.password = "",
      this.date = "",
      this.dni = "",
      this.phone = "",
      this.imageLink = "",
      this.rate = 0.0,
      this.passwordConfirm = "",
      this.secondLastName,
      this.secondName,
      this.id = 0});

  void mostrar() {
    print(this.date);
    print(this.dni);
    print(this.email);
    print(this.gender);
    print(this.id);
    print(this.imageLink);
    print(this.lastName);
    print(this.name);
    print(this.password);
    print(this.passwordConfirm);
    print(this.phone);
    print(this.rate);
    print(this.secondLastName);
    print(this.secondName);
  }
}

class GeneratorUser extends User {
  int residence;

  GeneratorUser(
      {this.residence = 0,
      name = "",
      email = "",
      gender = 0,
      lastName = "",
      password = "",
      date = "",
      dni = "",
      phone = "",
      imageLink = "",
      rate = 0.0,
      passwordConfirm = "",
      secondName = "",
      secondLastName = "",
      id = 0})
      : super(
            imageLink: imageLink,
            name: name,
            email: email,
            gender: gender,
            lastName: lastName,
            password: password,
            date: date,
            dni: dni,
            phone: phone,
            rate: rate,
            passwordConfirm: passwordConfirm,
            secondName: secondName,
            secondLastName: secondLastName,
            id: id);

  factory GeneratorUser.fromJson(Map<String, dynamic> json) {
    return GeneratorUser(
        date: json['generator_born_date'],
        dni: json['generator_ci'] ?? "",
        email: json['generator_email'],
        gender: json['generator_gender'],
        imageLink: json['generator_picture_url'],
        name: json['generator_first_name'],
        lastName: json['generator_first_lastname'],
        phone: json['generator_phone'],
        residence: json['generator_place'],
        secondLastName: json['generator_second_lastname'],
        secondName: json['generator_second_name'],
        id: json['generator_id'],
        rate: json['generator_rate'] / 1);
  }
}

class RecolectorUser extends User {
  int city;

  RecolectorUser(
      {this.city = 0,
      name = "",
      email = "",
      gender = 0,
      lastName = "",
      password = "",
      date = "",
      dni = "",
      phone = "",
      imageLink = "",
      rate = 0.0,
      passwordConfirm = "",
      secondName = "",
      secondLastName = "",
      id = 0})
      : super(
            name: name,
            email: email,
            gender: gender,
            imageLink: imageLink,
            lastName: lastName,
            password: password,
            date: date,
            dni: dni,
            phone: phone,
            rate: rate,
            passwordConfirm: passwordConfirm,
            secondName: secondName,
            secondLastName: secondLastName,
            id: id);

  factory RecolectorUser.fromJson(Map<String, dynamic> json) {
    return RecolectorUser(
      date: json['recolector_born_date'],
      dni: json['recolector_ci'],
      email: json['recolector_email'],
      gender: json['recolector_gender'],
      imageLink: json['recolector_picture_url'],
      name: json['recolector_first_name'],
      lastName: json['recolector_first_lastname'],
      phone: json['recolector_phone'],
      city: json['recolector_city'],
      secondLastName: json['generator_second_lastname'],
      secondName: json['generator_second_name'],
      id: json['recolector_id'],
    );
  }
}

GeneratorUser generatorExample = GeneratorUser(
    name: "Alvaro", lastName: "Martinez", email: "alvaro@mail.com");
RecolectorUser recolectorExample = RecolectorUser(
    name: "Ariel", lastName: "Mancilla", email: "ariel@mail.com");
