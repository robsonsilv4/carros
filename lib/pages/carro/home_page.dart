import 'package:flutter/material.dart';

import '../../widgets/drawer_list.dart';
import 'carro_api.dart';
import 'carros_listview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Carros'),
          bottom: TabBar(tabs: [
            Tab(
              text: 'Clássicos',
            ),
            Tab(
              text: 'Esportivos',
            ),
            Tab(
              text: 'Luxo',
            ),
          ]),
        ),
        body: TabBarView(children: [
          CarrosListView(
            tipo: TipoCarro.classicos,
          ),
          CarrosListView(
            tipo: TipoCarro.esportivos,
          ),
          CarrosListView(
            tipo: TipoCarro.luxo,
          ),
        ]),
        drawer: DrawerList(),
      ),
    );
  }
}
