import 'package:flutter/material.dart';
import 'package:pat_gest/db/drift_database.dart';
import 'package:pat_gest/services/crud_service.dart';

class PatientsList extends StatefulWidget {
  const PatientsList({super.key});

  @override
  State<PatientsList> createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: CrudService().getPatientsStream(),
      builder: (BuildContext context, AsyncSnapshot<List<Patient>> snapshot) {
        if (snapshot.hasData) {
          final patientsList = snapshot.data!;
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
                          debugPrint(patientsList[index].toString());
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
}
