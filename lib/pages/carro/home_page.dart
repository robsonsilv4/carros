import 'package:flutter/material.dart';

import '../../utils/prefs.dart';
import '../../widgets/drawer_list.dart';
import 'carro_api.dart';
import 'carros_listview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  _initTabs() async {
    int tabIndex = await Prefs.getInt('tabIndex');

    _tabController = TabController(length: 3, vsync: this);

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
        bottom: _tabController == null
            ? null
            : TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: 'Clássicos',
                  ),
                  Tab(
                    text: 'Esportivos',
                  ),
                  Tab(
                    text: 'Luxo',
                  ),
                ],
              ),
      ),
      body: _tabController == null
          ? null
          : TabBarView(
              controller: _tabController,
              children: [
                CarrosListView(
                  tipo: TipoCarro.classicos,
                ),
                CarrosListView(
                  tipo: TipoCarro.esportivos,
                ),
                CarrosListView(
                  tipo: TipoCarro.luxo,
                ),
              ],
            ),
      drawer: DrawerList(),
    );
  }
}
