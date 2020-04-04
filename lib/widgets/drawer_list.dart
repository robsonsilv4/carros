import 'package:flutter/material.dart';

import '../pages/login/login_page.dart';
import '../utils/nav.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Robson Silva"),
            accountEmail: Text("robsonsilv410@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://avatars0.githubusercontent.com/u/17673296?s=400&u=7ca64208ca0fd4658b62aa1808daeec688640f94&v=4",
              ),
            ),
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

  _onClickLogout(BuildContext context) {
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
