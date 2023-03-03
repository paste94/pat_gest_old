import 'package:flutter/material.dart';
import 'package:pat_gest/constants/routes.dart';
import 'package:pat_gest/services/crud_service.dart';
import 'package:pat_gest/views/patients/add_patient_view.dart';
import 'package:pat_gest/views/home_view.dart';
import 'package:pat_gest/views/patients/patient_list_view.dart';
import 'package:pat_gest/views/splash_view.dart';

void main() {
  runApp(MaterialApp(
    title: 'Pat Gest',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      homeRoute: (context) => const HomeView(),
      patientListRoute: (context) => const PatientListView(),
      addPatientRoute: (context) => const AddPatientView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CrudService().open(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const HomeView();
        } else {
          return const SplashView();
        }
      },
    );
  }
}
