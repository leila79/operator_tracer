import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'Leila Shekofteh',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            accountEmail: Text(
              'Leila.shekofteh@gmail.com',
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
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/unknown.png'),
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
            onTap: () {},
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
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
