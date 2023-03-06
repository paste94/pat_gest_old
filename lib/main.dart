import 'package:flutter/material.dart';
import 'package:pat_gest/constants/routes.dart';
import 'package:pat_gest/services/crud_service.dart';
import 'package:pat_gest/utils/pat_gest_drawer.dart';
import 'package:pat_gest/views/foods/foods_list_view.dart';
import 'package:pat_gest/views/offices/offices_list_view.dart';
import 'package:pat_gest/views/options/options_view.dart';
import 'package:pat_gest/views/patients/add_patient_view.dart';
import 'package:pat_gest/views/patients/patient_list_view.dart';
import 'package:pat_gest/views/patients/patient_view.dart';
import 'package:pat_gest/views/splash_view.dart';

void main() {
  runApp(MaterialApp(
    title: 'Pat Gest',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      patientListRoute: (context) => const PatientListView(),
      addPatientRoute: (context) => const AddPatientView(),
      patientRoute: (context) => const PatientView(),
      foodListRoute: (context) => const FoodsListView(),
      officeListRoute: (context) => const OfficesListView(),
      optionsRoute: (context) => const OptionsView(),
    },
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CrudService().open(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            drawer: const PatGestDrawer(),
            appBar: AppBar(
              title: const Text('PatGest'),
            ),
            body: const Center(
              child: Text('HOME'),
            ),
          );
        } else {
          return const SplashView();
        }
      },
    );
  }
}
