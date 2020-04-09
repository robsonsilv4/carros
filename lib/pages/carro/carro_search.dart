import 'package:flutter/material.dart';

import 'carro.dart';
import 'carro_api.dart';
import 'carros_listview.dart';

class CarroSearch extends SearchDelegate<Carro> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 2) {
      return FutureBuilder(
        future: CarroApi.search(query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Carro> carros = snapshot.data;
            return CarrosListView(
              carros: carros,
              search: true,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }

    return Container();
  }
}
