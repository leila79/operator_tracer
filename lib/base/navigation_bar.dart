import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:human_resources/base/bloc/base_bloc.dart';
import 'package:human_resources/base/bloc/master_state.dart';
import 'package:human_resources/database/models/user_db.dart';
import 'package:human_resources/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late final String name;
  late final String email;
  late final String avatar;

  late User user;
  BaseBloc _bloc = BaseBloc();

  @override
  Widget build(BuildContext context) {
    _bloc.add(GetUserInfo());
    // getUserInfo();
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is NOData) {
            return Text('NoData');
          } else if (state is ShowLoading) {
            return CircularProgressIndicator();
          } else if (state is ShowUserInfo) {
            name = state.name;
            email = state.email;
            avatar = state.avatar;
            return buildDrawer();
          }
          return Container();
        },
      ),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              name,
              // 'Leila Shekofteh',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            accountEmail: Text(
              // 'Leila.shekofteh@gmail.com',
              email,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            currentAccountPicture: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profileScreen');
              },
              child: CircleAvatar(
                // backgroundImage: AssetImage('assets/images/unknown.png'),
                backgroundImage:
                    NetworkImage('https://movi.amwajco.net/$avatar'),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.check),
            title: Text('Checklist'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/check_list');
            },
          ),
          ListTile(
            leading: Icon(Icons.sync),
            title: Text('Update Data'),
            onTap: () {
              // Navigator.pushNamed(context, '/form_page');
            },
          ),
          ListTile(
            leading: Icon(Icons.perm_identity),
            title: Text('Profile Setting'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profileScreen');
            },
          ),
          ListTile(
            leading: Icon(Icons.support_agent),
            title: Text('Support'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.location_on_outlined),
            title: Text('Maps'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('About Us'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.delete_outline),
            title: Text('Delete'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.keyboard_arrow_left),
            title: Text('SignOut'),
            onTap: () async {
              var loginData = await SharedPreferences.getInstance();
              loginData.setBool('login', true);
              final Box<UserDB> userBox = Hive.box('user');
              userBox.deleteAt(0);
              Navigator.pushReplacementNamed(context, '/welcomePage');
            },
          ),
        ],
      ),
    );
  }
}
