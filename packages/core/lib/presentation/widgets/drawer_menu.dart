import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final String currentRoute;
  const DrawerMenu({Key? key, required this.currentRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Movies'),
            onTap: () {
              if (currentRoute == 'movie') {
                Navigator.pop(context);
              } else {
                Navigator.pushNamed(context, homeMovieRoute);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.tv),
            title: const Text('Tv '),
            onTap: () {
              if (currentRoute == 'tv') {
                Navigator.pop(context);
              } else {
                Navigator.pushNamed(context, hometvRoute);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist'),
            onTap: () {
              if (currentRoute == 'watchlist') {
                Navigator.pop(context);
              } else {
                Navigator.pushNamed(context, watchlistRoute);
              }
            },
          ),
          ListTile(
            onTap: () {
              if (currentRoute == 'about') {
                Navigator.pop(context);
              } else {
                Navigator.pushNamed(context, aboutRoute);
              }
            },
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}
