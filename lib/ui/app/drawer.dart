import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  navigateTo(BuildContext context, String route) {
    Navigator.pop(context); // Close the drawer...
    Navigator.pushNamed(context,route);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Text(
                'Slides...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),
            ),
          ),

          /*
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              navigateTo(context,"/");
            },
          ),

          ListTile(
            leading: const Icon(Icons.folder),
            title: const Text('Settings'),
            onTap: () {
              navigateTo(context,"/settings");
            },
          ),
          */

          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              navigateTo( context,"/about");
            },
          ),
        ],
      ),
    );
  }

}
