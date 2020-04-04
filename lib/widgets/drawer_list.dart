import 'package:flutter/material.dart';

import '../pages/login/login_page.dart';
import '../pages/login/usuario.dart';
import '../utils/nav.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<Usuario> future = Usuario.get();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          FutureBuilder<Usuario>(
            future: future,
            builder: (context, snapshot) {
              Usuario user = snapshot.data;
              return user != null ? _header(user: user) : Container();
            },
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text("Favoritos"),
            subtitle: Text("Mais informações..."),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              print("Favoritos");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text("Ajuda"),
            subtitle: Text("Mais informações..."),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              print("Item 1");
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Sair"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => _onClickLogout(context),
          )
        ],
      ),
    );
  }

  Widget _header({@required Usuario user}) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.nome),
      accountEmail: Text(user.email),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(
          user.urlFoto,
        ),
      ),
    );
  }

  _onClickLogout(BuildContext context) {
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
