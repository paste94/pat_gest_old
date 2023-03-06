import 'package:flutter/material.dart';
import 'package:pat_gest/constants/routes.dart';
import 'package:pat_gest/db/drift_database.dart';
import 'package:pat_gest/services/crud_service.dart';
import 'package:pat_gest/utils/pat_gest_drawer.dart';

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
      drawer: const PatGestDrawer(),
      body: _listBuilder(context),
      floatingActionButton: FloatingActionButton(
        heroTag: 'uniqueTag',
        onPressed: () {
          Navigator.of(context).pushNamed(addPatientRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _listBuilder(BuildContext context) => StreamBuilder(
        stream: CrudService().getPatientsListStream(),
        builder: (BuildContext context, AsyncSnapshot<List<Patient>> snapshot) {
          if (snapshot.hasData) {
            final patientsList = snapshot.data ?? [];
            if (patientsList.isEmpty) {
              return const Center(
                child: Text(
                  'Nothing here, press "+" button to add your first patient!',
                ),
              );
            } else {
              return Center(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: patientsList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(
                              '${patientsList[index].name} ${patientsList[index].surname}'),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              patientRoute,
                              arguments: patientsList[index].id,
                            );
                          },
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
}
