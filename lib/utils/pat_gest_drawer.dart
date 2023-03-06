import 'package:flutter/material.dart';
import 'package:pat_gest/constants/routes.dart';

class PatGestDrawer extends StatelessWidget {
  const PatGestDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          _buildHeader(context),
          _buildMenuItems(context),
        ],
      ),
    ));
  }

  Widget _buildHeader(BuildContext context) => Container();
  Widget _buildMenuItems(BuildContext context) => Column(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Patients'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed(patientListRoute);
            },
          ),
          ListTile(
            leading: const Icon(Icons.computer),
            title: const Text('Offices'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed(officeListRoute);
            },
          ),
          ListTile(
            leading: const Icon(Icons.food_bank),
            title: const Text('Foods'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed(foodListRoute);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Options'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed(optionsRoute);
            },
          ),
        ],
      );
}
