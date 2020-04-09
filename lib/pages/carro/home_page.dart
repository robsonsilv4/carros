import 'package:flutter/material.dart';

import '../../utils/alert.dart';
import '../../utils/nav.dart';
import '../../utils/prefs.dart';
import '../../widgets/drawer_list.dart';
import '../favoritos/favoritos_page.dart';
import 'carro.dart';
import 'carro_api.dart';
import 'carro_form_page.dart';
import 'carro_search.dart';
import 'carros_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  _initTabs() async {
    int tabIndex = await Prefs.getInt('tabIndex');

    _tabController = TabController(length: 4, vsync: this);

    setState(() {
      _tabController.index = tabIndex;
    });

    _tabController.addListener(() {
      Prefs.setInt('tabIndex', _tabController.index);
    });
  }

  @override
  void initState() {
    super.initState();

    _initTabs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            // onPressed: _onClickSearch,
            onPressed: () {},
          )
        ],
        bottom: _tabController == null
            ? null
            : TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: 'Clássicos',
                    icon: Icon(Icons.directions_car),
                  ),
                  Tab(
                    text: 'Esportivos',
                    icon: Icon(Icons.directions_car),
                  ),
                  Tab(
                    text: 'Luxo',
                    icon: Icon(Icons.directions_car),
                  ),
                  Tab(
                    text: 'Favoritos',
                    icon: Icon(Icons.favorite),
                  ),
                ],
              ),
      ),
      body: _tabController == null
          ? null
          : TabBarView(
              controller: _tabController,
              children: [
                CarrosPage(
                  tipo: TipoCarro.classicos,
                ),
                CarrosPage(
                  tipo: TipoCarro.esportivos,
                ),
                CarrosPage(
                  tipo: TipoCarro.luxo,
                ),
                FavoritosPage(),
              ],
            ),
      drawer: DrawerList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onClickAdicionarCarro,
      ),
    );
  }

  void _onClickAdicionarCarro() {
    push(context, CarroFormPage());
  }

  void _onClickSearch() async {
    final carro = await showSearch<Carro>(
      context: context,
      delegate: CarroSearch(),
    );

    if (carro != null) {
      alert(context, carro.nome);
    }
  }
}

class CarrosSearch {}
