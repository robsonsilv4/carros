import 'package:flutter/material.dart';

import '../../widgets/text_error.dart';
import 'carro.dart';
import 'carros_bloc.dart';
import 'carros_listview.dart';

class CarrosPage extends StatefulWidget {
  final String tipo;

  const CarrosPage({@required this.tipo});

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
  List<Carro> carros;

  String get tipo => widget.tipo;

  final _bloc = CarrosBloc();

  @override
  bool get wantKeepAlive => true;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _bloc.fetch(tipo: tipo);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('Fim');
        _bloc.fetchMore(tipo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final List<Carro> list = [];

    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError(
            message: 'Não foi possível buscar os carros.',
          );
        }

        if (snapshot.hasData) {
          List<Carro> carros = snapshot.data;
          list.addAll(carros);

          bool showProgress = carros.length > 0 && carros.length % 10 == 0;

          return RefreshIndicator(
            child: CarrosListView(
              carros: list,
              scrollController: _scrollController,
              showProgress: showProgress,
            ),
            onRefresh: _onRefresh,
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<void> _onRefresh() {
    return _bloc.fetch(tipo: tipo);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
