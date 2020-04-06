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

  @override
  void initState() {
    super.initState();
    _bloc.fetch(tipo: tipo);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
          return CarrosListView(carros: carros);
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
