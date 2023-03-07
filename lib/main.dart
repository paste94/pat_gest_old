import 'package:flutter/material.dart';
import 'package:pat_gest/constants/routes.dart';
import 'package:pat_gest/services/crud_service.dart';
import 'package:pat_gest/utils/my_navigation_rail_destination.dart';
import 'package:pat_gest/views/foods/foods_list_view.dart';
import 'package:pat_gest/views/offices/offices_list_view.dart';
import 'package:pat_gest/views/options/options_view.dart';
import 'package:pat_gest/views/patients/add_patient_view.dart';
import 'package:pat_gest/views/patients/patient_list_view.dart';
import 'package:pat_gest/views/patients/patient_view.dart';
import 'package:pat_gest/views/splash_view.dart';

final _destinations = <MyNavigationRailDestination>[
  MyNavigationRailDestination(
    icon: const Icon(Icons.person),
    label: const Text('Patients'),
    pageToLoad: const PatientListView(),
  ),
  MyNavigationRailDestination(
    icon: const Icon(Icons.computer),
    label: const Text('Offices'),
    pageToLoad: const OfficesListView(),
  ),
  MyNavigationRailDestination(
    icon: const Icon(Icons.food_bank),
    label: const Text('Foods'),
    pageToLoad: const FoodsListView(),
  ),
  MyNavigationRailDestination(
    icon: const Icon(Icons.settings),
    label: const Text('Options'),
    pageToLoad: const OptionsView(),
  ),
];

void main() {
  runApp(MaterialApp(
    title: 'Pat Gest',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      addPatientRoute: (context) => const AddPatientView(),
      patientRoute: (context) => const PatientView(),
    },
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  Widget _selectedPage = _destinations[0].pageToLoad;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CrudService().open(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('PatGest'),
              ),
              body: Row(
                children: <Widget>[
                  NavigationRail(
                    groupAlignment: -1,
                    onDestinationSelected: (int index) {
                      setState(() {
                        _selectedIndex = index;
                        _selectedPage = _destinations[index].pageToLoad;
                      });
                    },
                    labelType: NavigationRailLabelType.all,
                    destinations: _destinations,
                    selectedIndex: _selectedIndex,
                  ),
                  Expanded(
                    child: _selectedPage,
                  )
                ],
              ));
        } else {
          return const SplashView();
        }
      },
    );
  }
}
