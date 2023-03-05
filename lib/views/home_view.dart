import 'package:flutter/material.dart';
import 'package:pat_gest/constants/routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('HEADER'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.of(context).pushNamed(patientListRoute);
              },
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Pat Gest'),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: IconButton(
                icon: const Icon(Icons.person),
                iconSize: iconSize,
                onPressed: () {
                  Navigator.of(context).pushNamed(patientListRoute);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: IconButton(
                icon: const Icon(Icons.computer),
                iconSize: iconSize,
                onPressed: () {
                  debugPrint('PC');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const double iconSize = 100;
