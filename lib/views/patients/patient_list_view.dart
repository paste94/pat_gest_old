import 'package:flutter/material.dart';
import 'package:pat_gest/constants/routes.dart';
import 'package:pat_gest/db/drift_database.dart';
import 'package:pat_gest/services/crud_service.dart';
import 'package:pat_gest/utils/patients_list.dart';

class PatientListView extends StatefulWidget {
  const PatientListView({super.key});

  @override
  State<PatientListView> createState() => _PatientListViewState();
}

class _PatientListViewState extends State<PatientListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Patient List')),
      body: const PatientsList(),
      floatingActionButton: FloatingActionButton(
        heroTag: 'uniqueTag',
        onPressed: () {
          Navigator.of(context).pushNamed(addPatientRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
