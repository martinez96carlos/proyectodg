import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:waste_collection_app/data/constant.dart' as constant;
import 'package:waste_collection_app/data/providers/orders_provider.dart';
import 'package:waste_collection_app/ui/widgets/alerts.dart' as alerts;
import 'package:waste_collection_app/ui/widgets/custom_buttons.dart' as buttons;
import 'package:latlong/latlong.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MapContainer extends StatefulWidget {
  final String position;
  MapContainer({this.position = "-16.489282,-68.140709"});
  @override
  _MapContainerState createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer> {
  double zoom;
  double latitude;
  double longitude;
  MapController _controller;
  bool city;

  void _zoomMore() {
    setState(() {
      if (zoom < 17.0) {
        zoom += 0.5;
        _controller.move(_controller.center, zoom);
        print(zoom);
      }
    });
  }

  void _zoomLess() {
    setState(() {
      if (zoom > 5.0) {
        zoom -= 0.5;
        _controller.move(_controller.center, zoom);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = MapController();
    zoom = 15;
    latitude = double.parse(widget.position.split(",")[0]);
    longitude = double.parse(widget.position.split(",")[1]);
    city = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      height: 200.0,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          children: <Widget>[
            FlutterMap(
                mapController: _controller,
                options: new MapOptions(
                  maxZoom: 17.0,
                  minZoom: 5.0,
                  center: LatLng(latitude, longitude),
                  zoom: this.zoom,
                ),
                layers: [
                  new TileLayerOptions(
                    urlTemplate: constant.mapStreet,
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayerOptions(markers: [
                    new Marker(
                      width: 50.0,
                      height: 80.0,
                      point: new LatLng(latitude, longitude),
                      builder: (ctx) => Column(children: [
                        Icon(MdiIcons.mapMarker, size: 40.0),
                        SizedBox(height: 40.0),
                      ]),
                    ),
                  ])
                ]),
            Positioned(
              top: 10.0,
              right: 10.0,
              child: buttons.GeneralButtonMap(
                  contain: Icon(Icons.add), function: _zoomMore, height: 40.0),
            ),
            Positioned(
              top: 60.0,
              right: 10.0,
              child: buttons.GeneralButtonMap(
                  contain: Icon(Icons.remove),
                  function: _zoomLess,
                  height: 40.0),
            ),
          ],
        ),
      ),
    );
  }
}

class MapFormSelected extends StatefulWidget {
  @override
  _MapFormSelectedState createState() => _MapFormSelectedState();
}

class _MapFormSelectedState extends State<MapFormSelected> {
  double zoom;
  MapController _controller;
  LatLng center;

  List<Marker> markers = [];

  void _zoomMore() {
    setState(() {
      if (zoom < 17.0) {
        zoom += 0.5;
        _controller.move(_controller.center, zoom);
      }
    });
  }

  void _zoomLess() {
    setState(() {
      if (zoom > 5.0) {
        zoom -= 0.5;
        _controller.move(_controller.center, zoom);
      }
    });
  }

  void _addMarker(LatLng value) {
    final order = Provider.of<OrdersProviders>(context, listen: false);
    final marker = Marker(
      width: 50.0,
      height: 80.0,
      point: new LatLng(value.latitude, value.longitude),
      builder: (ctx) => Column(children: [
        Icon(MdiIcons.mapMarker, size: 40.0),
        SizedBox(height: 40.0),
      ]),
    );
    alerts.generalAlert(
        description: "¿Esta seguro que desea agregar esta ubicación",
        context: context,
        function: () {
          setState(() {
            if (markers.length > 0) {
              markers.removeLast();
            }
            order.orderActive.latLng = "${value.latitude},${value.longitude}";
            markers.add(marker);
            center = value;
            _controller.move(center, zoom);
          });
        });
  }

  @override
  void initState() {
    super.initState();
    _controller = MapController();
    zoom = 13.5;
    //TODO: add center from city user
    center = LatLng(-16.489282, -68.140709);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      height: 200.0,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          children: <Widget>[
            FlutterMap(
                mapController: _controller,
                options: new MapOptions(
                  onTap: _addMarker,
                  maxZoom: 17.0,
                  minZoom: 5.0,
                  center: center,
                  zoom: this.zoom,
                ),
                layers: [
                  new TileLayerOptions(
                    urlTemplate: constant.mapStreet,
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayerOptions(
                      markers: markers.length != 0 ? [markers[0]] : [])
                ]),
            Positioned(
              top: 10.0,
              right: 10.0,
              child: buttons.GeneralButtonMap(
                  contain: Icon(Icons.add), function: _zoomMore, height: 40.0),
            ),
            Positioned(
              top: 60.0,
              right: 10.0,
              child: buttons.GeneralButtonMap(
                  contain: Icon(Icons.remove),
                  function: _zoomLess,
                  height: 40.0),
            ),
          ],
        ),
      ),
    );
  }
}
