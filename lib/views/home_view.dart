import 'package:flutter/material.dart';
import 'package:pat_gest/constants/routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
