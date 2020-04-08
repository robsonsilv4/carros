import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'carro.dart';

class MapaPage extends StatelessWidget {
  final Carro carro;

  MapaPage({this.carro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: latLong(),
        ),
        markers: Set.of(_getMarkers()),
      ),
    );
  }

  latLong() {
    // return LatLng(3.7190502, -38.5170153);
    return carro.latLong();
  }

  List<Marker> _getMarkers() {
    return [
      Marker(
        markerId: MarkerId('1'),
        position: carro.latLong(),
        infoWindow: InfoWindow(
          title: carro.nome,
          snippet: 'Fábrica da ${carro.nome}',
          onTap: () {
            print('Clicou na janela');
          },
        ),
        onTap: () {
          print('Clicou no marcador');
        },
      )
    ];
  }
}
