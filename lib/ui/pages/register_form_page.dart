import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_collection_app/data/constant.dart' as constant;
import 'package:waste_collection_app/data/providers/controllers_provider.dart';
import 'package:waste_collection_app/data/providers/user_providers.dart';
import 'package:waste_collection_app/logic/login_logic.dart' as login;
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:waste_collection_app/ui/widgets/configure_widgets.dart'
    as configure;
import 'package:waste_collection_app/ui/widgets/custom_buttons.dart' as buttons;
import 'package:waste_collection_app/utils/request.dart' as request;

final GlobalKey<ScaffoldState> scaffoldRegisterKey =
    new GlobalKey<ScaffoldState>();
final GlobalKey<FormState> formRegisterKey = GlobalKey<FormState>();

class RegisterFormArguments {
  final bool generator;
  final bool edit;
  RegisterFormArguments({this.generator = false, this.edit = false});
}

class RegisterFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RegisterFormArguments args =
        ModalRoute.of(context).settings.arguments;
    final controllers = Provider.of<ControllersProvider>(context);
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Scaffold(
            key: scaffoldRegisterKey,
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              brightness: Brightness.light,
              elevation: 0.0,
              title: Text(
                  args.edit
                      ? 'Editar perfíl'
                      : 'Registro ${args.generator ? 'Generador' : 'Recolector'}',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w300)),
              backgroundColor: Colors.white,
            ),
            body: _Body(generator: args.generator, edit: args.edit),
          ),
        ),
        controllers.isLoading ? configure.LoadingWidget() : Container()
      ],
    );
  }
}

class _Body extends StatefulWidget {
  final bool generator;
  final bool edit;
  _Body({this.generator, this.edit});

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  List<FocusNode> _focus = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  final _format = DateFormat("yyyy-MM-dd");

  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController secondNameController = TextEditingController(text: "");
  TextEditingController lastNameController = TextEditingController(text: "");
  TextEditingController secondLastNameController =
      TextEditingController(text: "");
  TextEditingController dniController = TextEditingController(text: "");
  TextEditingController phoneController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController password1Controller = TextEditingController(text: "");

  int groupValue;

  void initControllers() {
    final user = Provider.of<UserProviders>(context, listen: false);
    nameController.text = user.user.name;
    secondLastNameController.text = user.user.secondName;
    lastNameController.text = user.user.lastName;
    secondLastNameController.text = user.user.secondLastName;
    dniController.text = user.user.dni;
    phoneController.text = user.user.phone;
    emailController.text = user.user.email;

    groupValue = user.user.gender;
  }

  Future<void> _register() async {
    final userProvider = Provider.of<UserProviders>(context);
    final userGenerator = userProvider.generatorUser;
    final userRecolector = userProvider.recolectorUser;
    final controllers = Provider.of<ControllersProvider>(context);
    if (widget.generator &&
        userGenerator.password == userGenerator.passwordConfirm) {
      if (await request.registerGenerator(
          user: userGenerator, context: context)) {
        controllers.isLoading = false;
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Se registro correctamente'),
          action: SnackBarAction(
              label: 'Ok',
              onPressed: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst)),
        ));
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('No se pudo registrar')));
      }
    } else if (!widget.generator &&
        userRecolector.password == userRecolector.passwordConfirm) {
      if (await request.registerRecolector(
          user: userRecolector, context: context)) {
        controllers.isLoading = false;
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Se registro correctamente'),
          action: SnackBarAction(
              label: 'Ok',
              onPressed: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst)),
        ));
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('No se pudo registrar')));
      }
    } else {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Las contraseñas no coinciden')));
    }
  }

  Future<void> _edit() async {
    final userProvider = Provider.of<UserProviders>(context);
    final userGenerator = userProvider.generatorUser;
    final userRecolector = userProvider.recolectorUser;
    final controllers = Provider.of<ControllersProvider>(context);
    if (widget.generator &&
        userGenerator.password == userGenerator.passwordConfirm) {
      if (await request.editGenerator(user: userGenerator, context: context)) {
        controllers.isLoading = false;
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Datos actualizados correctamente'),
          action: SnackBarAction(
              label: 'Ok', onPressed: () => Navigator.of(context).pop()),
        ));
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('No se pudo actualizar')));
      }
    } else if (!widget.generator &&
        userRecolector.password == userRecolector.passwordConfirm) {
      if (await request.editRecolector(
          user: userRecolector, context: context)) {
        controllers.isLoading = false;
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Datos actualizados correctamente'),
          action: SnackBarAction(
              label: 'Ok', onPressed: () => Navigator.of(context).pop()),
        ));
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('No se pudo actualizar')));
      }
    } else {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Las contraseñas no coinciden')));
    }
  }

  @override
  void initState() {
    groupValue = 0;
    if (widget.edit) {
      initControllers();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProviders>(context);
    final userGenerator = userProvider.generatorUser;
    final userRecolector = userProvider.recolectorUser;
    final controllers = Provider.of<ControllersProvider>(context);
    return Form(
      key: formRegisterKey,
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text("* Campos requeridos",
                style: TextStyle(color: Colors.red)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextFormField(
              initialValue: nameController.text,
              onFieldSubmitted: (value) =>
                  login.fieldFocusChange(_focus[0], _focus[1], context),
              focusNode: _focus[0],
              textInputAction: TextInputAction.next,
              validator: (value) => login.validate(value, "nombre"),
              onChanged: (value) {
                setState(() {
                  nameController.text = value;
                  widget.generator
                      ? userGenerator.name = nameController.text
                      : userRecolector.name = nameController.text;
                });
              },
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: "Nombre *",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextFormField(
              initialValue: secondNameController.text,
              textInputAction: TextInputAction.next,
              validator: (value) => login.validate(value, "segundo nombre"),
              onChanged: (value) {
                setState(() {
                  secondNameController.text = value;
                  widget.generator
                      ? userGenerator.secondName = secondNameController.text
                      : userRecolector.secondName = secondNameController.text;
                });
              },
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: "Segundo nombre",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextFormField(
              initialValue: lastNameController.text,
              onFieldSubmitted: (value) =>
                  login.fieldFocusChange(_focus[1], _focus[2], context),
              focusNode: _focus[1],
              textInputAction: TextInputAction.next,
              validator: (value) => login.validate(value, "apellido"),
              onChanged: (value) {
                setState(() {
                  lastNameController.text = value;
                  widget.generator
                      ? userGenerator.lastName = lastNameController.text
                      : userRecolector.lastName = lastNameController.text;
                });
              },
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: "Apellido *",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextFormField(
              initialValue: secondLastNameController.text,
              textInputAction: TextInputAction.next,
              validator: (value) => login.validate(value, "segundo apellido"),
              onChanged: (value) {
                setState(() {
                  secondLastNameController.text = value;
                  widget.generator
                      ? userGenerator.secondLastName =
                          secondLastNameController.text
                      : userRecolector.secondLastName =
                          secondLastNameController.text;
                });
              },
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: "Segundo apellido",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: DateTimeField(
                validator: (value) =>
                    login.validate(value.toString(), "fecha nacimiento"),
                format: _format,
                onChanged: (value) => widget.generator
                    ? userGenerator.date =
                        "${value.year}-${value.month}-${value.day}"
                    : userRecolector.date =
                        "${value.year}-${value.month}-${value.day}",
                focusNode: _focus[2],
                onShowPicker: (context, currentValue) async {
                  return await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
                onFieldSubmitted: (value) =>
                    login.fieldFocusChange(_focus[2], _focus[3], context),
                decoration: InputDecoration(
                  icon: Icon(Icons.date_range),
                  labelText: "Fecha Nacimiento",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(8.0),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextFormField(
              validator: (value) => login.validate(value, "cedula identidad"),
              initialValue: dniController.text,
              keyboardType: TextInputType.number,
              onFieldSubmitted: (value) =>
                  login.fieldFocusChange(_focus[3], _focus[4], context),
              focusNode: _focus[3],
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                setState(() {
                  dniController.text = value;
                  widget.generator
                      ? userGenerator.dni = dniController.text
                      : userRecolector.dni = dniController.text;
                });
              },
              decoration: InputDecoration(
                icon: Icon(Icons.perm_identity),
                labelText: "Cedula identidad",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
              ),
            ),
          ),
          widget.generator
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: DropdownButtonFormField(
                    value: constant.residences[userGenerator.residence],
                    validator: (value) => login.validate(value, "residencia"),
                    items: constant.residences
                        .map((value) =>
                            DropdownMenuItem(child: Text(value), value: value))
                        .toList(),
                    onChanged: (value) => userGenerator.residence =
                        constant.residences.indexOf(value),
                    decoration: InputDecoration(
                      icon: Icon(Icons.location_city),
                      labelText: "Tipo Residencia",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                    ),
                  ))
              : Container(),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextFormField(
              validator: (value) => login.validate(value, "numero celular"),
              initialValue: phoneController.text,
              keyboardType: TextInputType.number,
              onFieldSubmitted: (value) =>
                  login.fieldFocusChange(_focus[4], _focus[5], context),
              focusNode: _focus[4],
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                setState(() {
                  phoneController.text = value;
                  widget.generator
                      ? userGenerator.phone = phoneController.text
                      : userRecolector.phone = phoneController.text;
                });
              },
              decoration: InputDecoration(
                icon: Icon(Icons.call),
                labelText: "Número celular",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
              ),
            ),
          ),
          !widget.generator
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: DropdownButtonFormField(
                    value: constant.cities[userRecolector.city],
                    validator: (value) => login.validate(value, "ciudad"),
                    items: constant.cities
                        .map((value) =>
                            DropdownMenuItem(child: Text(value), value: value))
                        .toList(),
                    onChanged: (value) =>
                        userRecolector.city = constant.cities.indexOf(value),
                    decoration: InputDecoration(
                      icon: Icon(Icons.location_city),
                      labelText: "Ciudad",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                    ),
                  ))
              : Container(),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 40.0),
                  child: Text(
                    'Género',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16.0),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Radio(
                        value: 0,
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = value;
                            widget.generator
                                ? userGenerator.gender = groupValue
                                : userRecolector.gender = groupValue;
                          });
                        }),
                    Text('Masculino',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.black)),
                    SizedBox(width: 16.0),
                    Radio(
                        value: 1,
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = value;
                            widget.generator
                                ? userGenerator.gender = groupValue
                                : userRecolector.gender = groupValue;
                          });
                        }),
                    Text('Femenino',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.black)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextFormField(
              initialValue: emailController.text,
              onFieldSubmitted: (value) =>
                  login.fieldFocusChange(_focus[6], _focus[7], context),
              focusNode: _focus[6],
              textInputAction: TextInputAction.next,
              validator: (value) => login.validate(value, "correo"),
              onChanged: (value) {
                setState(() {
                  emailController.text = value;
                  widget.generator
                      ? userGenerator.email = emailController.text
                      : userRecolector.email = emailController.text;
                });
              },
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                labelText: "Correo Electrónico *",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextFormField(
              obscureText: true,
              initialValue: passwordController.text,
              onFieldSubmitted: (value) =>
                  login.fieldFocusChange(_focus[7], _focus[8], context),
              focusNode: _focus[7],
              textInputAction: TextInputAction.next,
              validator: (value) => login.validate(value, "contraseña"),
              onChanged: (value) {
                setState(() {
                  passwordController.text = value;
                  widget.generator
                      ? userGenerator.password = passwordController.text
                      : userRecolector.password = passwordController.text;
                });
              },
              decoration: InputDecoration(
                icon: Icon(Icons.vpn_key),
                labelText: "Contraseña *",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextFormField(
              initialValue: password1Controller.text,
              onFieldSubmitted: (value) {
                _focus[8].unfocus();
                //logi.validateAll();
              },
              obscureText: true,
              focusNode: _focus[8],
              textInputAction: TextInputAction.done,
              validator: (value) => login.validate(value, "contraseña"),
              onChanged: (value) {
                setState(() {
                  password1Controller.text = value;
                  widget.generator
                      ? userGenerator.passwordConfirm = password1Controller.text
                      : userRecolector.passwordConfirm =
                          password1Controller.text;
                });
              },
              decoration: InputDecoration(
                icon: Icon(Icons.vpn_key),
                labelText: "Confirmar contraseña *",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
              ),
            ),
          ),
          SizedBox(height: 12.0),
          buttons.BoxButton(
              title: widget.edit ? "EDITAR" : "REGISTRARSE",
              function: () async {
                controllers.isLoading = true;
                if (widget.edit) {
                  await _edit();
                } else {
                  await _register();
                }
                controllers.isLoading = false;
              },
              color: Theme.of(context).primaryColor),
          SizedBox(height: 12.0),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    secondNameController.dispose();
    lastNameController.dispose();
    secondLastNameController.dispose();
    dniController.dispose();
    phoneController.dispose();
    emailController.dispose();
    password1Controller.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
