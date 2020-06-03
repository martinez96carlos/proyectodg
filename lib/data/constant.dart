import 'package:flutter/material.dart';
import 'package:waste_collection_app/models/orders.dart';

const Map<String, String> registerTexts = {
  'Recolector.':
      ' Es aquel que registra y pasa a recolectar los residuos a sólidos inorganicos.',
  'Generador.':
      ' Es el vecino que genera los residuos sólidos y realiza pedidos de recolección.'
};

const List<String> svgPageRegister = [
  'assets/profession.svg',
  'assets/bag.svg',
];

const List<String> cities = [
  'La Paz',
  'Santa Cruz',
  'Cochabamba',
  'Chuquisaca',
  'Oruro',
  'Potosi',
  'Tarija',
  'Beni',
  'Pando'
];

const List<String> residences = ['Edificio', 'Casa particular', 'Condominio'];

const Map<String, IconData> menuItemsGenerator = {
  'Perfil': Icons.person,
  'Pedidos': Icons.description,
  'Guía de separación': Icons.warning,
};

const Map<String, IconData> menuItemsRecolector = {
  'Perfil': Icons.person,
  'Buscar pedidos': Icons.search,
  'Pedidos atendidos': Icons.description,
  'Estadísticas': Icons.insert_chart,
};

Map<String, String> assetsCards = {
  'vidrio': 'assets/vidrio.jpg',
  'papel': 'assets/papel.jpg',
  'metal': 'assets/carton.jpg',
  'pet': 'assets/pet.jpg'
};

const String mapStreet = 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
const String mapSatellital =
    "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}.jpg";

const List<String> textsGuide = [
  "Recuerda que primero debes separar lo orgánico (restos de comida, fruta, todos los restos naturales) de los inorgánico (residuos reciclables).",
  "Ahora te toca saber cuáles residuos inorgánicos son reciclables y cuáles no.",
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras magna nisl, consectetur nec rutrum et, lacinia a tellus. Maecenas iaculis bibendum pellentesque. In molestie gravida ante, vel bibendum purus. Nullam id nunc leo. Sed congue, tellus vitae porttitor ultricies, velit elit laoreet arcu, in ullamcorper lorem nisl vel urna. Maecenas pretium feugiat risus, eu rhoncus libero lobortis id. Nunc sit amet ante ac velit tincidunt pretium ut vel elit. Nulla facilisis mi elit, quis consectetur tellus bibendum sit amet. Nullam sit amet molestie justo, sed ornare sapien. Nulla eget consequat neque, non gravida est. Nunc accumsan posuere velit et luctus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
];

//const String urlBase = "https://proyectodgucbtest.herokuapp.com";
//const String urlBase = "http://172.26.1.98:3000";
const String urlBase = "https://pruebaproyectodg1.herokuapp.com";

//Samples
List<Order> ordersSamples = [
  Order(
      details:
          'Tengo papel periodico mas o menos dos cajas llenas, la puerta de mi domicilio es 998',
      latLng: '-16.489282,-68.140709',
      dateTime: "14/05/2020 20:00",
      nameGenerator: 'Alvaro Martinez',
      phoneGenerator: '88057293'),
];

Map<String, List<String>> paper = {
  'si': [
    'Papel periodico',
    'Papel blanco',
    'Papel mixto',
    'Cartón',
    'Cartulina'
  ],
  'no': [
    'Papel de fax',
    'Papel encerado',
    'Papel higienico (usado)',
    'Pañuelos descartables',
    'Pañales descartables',
    'Papel aluminio',
    'Papel carbónico',
    'Envases laminados en nylon'
  ]
};

Map<String,List<String>> plastic = {
  'si':['PET (Botella de refresco)','Plástico duro (baldes, bañadores, etc)','Plástico blanco (bidones, etc)','Bolsas termoresistentes (embalaje)','Bolsas'],
  'no':['Envases térmicos']
};

Map<String,List<String>> vidrios = {
  'si':['Vidrio blanco','Vidrio de color'],
  'no':['No triturar el vidrio en piezas muy pequeñas por la seguridad del recolector']
};

Map<String,List<String>> metales = {
  'si':['Latas de aluminio','Ollas de aluminio','Chatarra u hojalata'],
  'no':[]
};

Map<String,List<String>> otros = {
  'si':['Ropa','Telas','Aceite de cocina','Corchos','Aparatos eléctricos y electrónicos'],
  'no':[]
};