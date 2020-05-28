import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_collection_app/data/providers/controllers_provider.dart';
import 'package:waste_collection_app/data/providers/user_providers.dart';
import 'package:waste_collection_app/models/user.dart';
import 'package:waste_collection_app/ui/widgets/custom_buttons.dart';
import 'package:waste_collection_app/utils/firebase.dart' as firebase;

class ProfilePage extends StatelessWidget {
  Widget _profileImage(BuildContext context) {
    final userProviders = Provider.of<UserProviders>(context);
    return Center(
      child: SizedBox(
          height: 165.0,
          width: 150.0,
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(150.0),
                child: Container(
                  margin: EdgeInsets.only(bottom: 15.0),
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(150)),
                  child: userProviders.user.imageLink != ""
                      ? Image.network(userProviders.user.imageLink,
                          fit: BoxFit.cover)
                      : Icon(Icons.person,
                          size: 100.0, color: Colors.grey[600]),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () async {
                      String photo = await firebase.uploadPhoto(
                          'profiles', context, false);
                      userProviders.updatePhoto(photo);
                    },
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      child: Icon(Icons.add, color: Colors.white),
                      decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(50.0)),
                    ),
                  )),
            ],
          )),
    );
  }

  Widget _mainInformation(BuildContext context, User user) {
    return Column(
      children: <Widget>[
        Text('Cédula de Identidad',
            style: Theme.of(context).textTheme.subtitle1),
        Text(user.dni != "" ? user.dni : 'Sin información',
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(color: Colors.grey)),
        SizedBox(height: 16.0),
        Text(user.rate.toString(),
            style: Theme.of(context).textTheme.subtitle1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 0; i < user.rate ~/ 1; i++)
              Icon(Icons.star, color: Theme.of(context).primaryColor),
            (user.rate - user.rate ~/ 1) == 0
                ? Container()
                : Icon(Icons.star_half, color: Theme.of(context).primaryColor),
            if (user.rate != 5.0)
              for (int i = 1; i <= 5 - (user.rate % 5); i++)
                Icon(Icons.star_border, color: Theme.of(context).primaryColor)
          ],
        )
      ],
    );
  }

  Widget _profileInformation(BuildContext context, User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Información de perfil',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.w300)),
        SizedBox(height: 8.0),
        _text('Nombres', "${user.name} ${user.lastName}", context),
        _text('Fecha de nacimiento',
            "${user.date != "" ? user.date : "Sin información"}", context),
        _text('Genero', "${user.gender == 0 ? "Masculino" : "Femenino"}",
            context),
        SizedBox(height: 8.0),
        Text('Contacto',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.w300)),
        SizedBox(height: 8.0),
        _text('Correo electrónico',
            user.email != "" ? user.email : "Sin información", context),
        _text('Teléfono',
            "${user.phone != "" ? user.phone : "Sin información"}", context),
      ],
    );
  }

  Widget _text(String title, String subtitle, BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(text: "$title:", style: Theme.of(context).textTheme.subtitle1),
        TextSpan(
            text: " $subtitle",
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(color: Colors.grey))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProviders = Provider.of<UserProviders>(context);
    final controllers = Provider.of<ControllersProvider>(context);
    final user = userProviders.user;
    return Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: <Widget>[
            ListView(children: [
              _profileImage(context),
              SizedBox(height: 16.0),
              _mainInformation(context, user),
              SizedBox(height: 32.0),
              _profileInformation(context, user)
            ]),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SizedBox(
                  height: 50.0,
                  child: BoxButton(
                    title: userProviders.userType
                        ? 'PEDIDOS'
                        : "BUSCAR PEDIDOS",
                    function: () => controllers.pickerMenu = 1,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
