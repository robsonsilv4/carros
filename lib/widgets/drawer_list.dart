import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firebase/firebase_service.dart';
import '../pages/login/login_page.dart';
import '../pages/login/usuario.dart';
import '../pages/site_page.dart';
import '../utils/nav.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<FirebaseUser> future = FirebaseAuth.instance.currentUser();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          FutureBuilder<FirebaseUser>(
            future: future,
            builder: (context, snapshot) {
              FirebaseUser user = snapshot.data;
              return user != null ? _header(user: user) : Container();
            },
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Favoritos'),
            subtitle: Text('Mais informações...'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              print('Favoritos');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Visitar o site'),
            leading: Icon(Icons.web),
            onTap: () => _onClickSite(context),
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Ajuda'),
            subtitle: Text('Mais informações...'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              print('Item 1');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => _onClickLogout(context),
          )
        ],
      ),
    );
  }

  Widget _header({@required FirebaseUser user}) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.displayName ?? ''),
      accountEmail: Text(user.email ?? ''),
      currentAccountPicture: user.photoUrl != null
          ? CircleAvatar(
              backgroundImage: NetworkImage(user.photoUrl),
            )
          : FlutterLogo(),
    );
  }

  _onClickLogout(BuildContext context) {
    Usuario.clear();
    FirebaseService().logout();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }

  _onClickSite(context) {
    pop(context);
    push(context, SitePage());
  }
}
