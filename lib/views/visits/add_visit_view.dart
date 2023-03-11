import 'package:flutter/material.dart';
import 'package:pat_gest/db/drift_database.dart';
import 'package:pat_gest/services/crud_service.dart';

class AddVisitView extends StatefulWidget {
  const AddVisitView({super.key});

  @override
  State<AddVisitView> createState() => _AddVisitViewState();
}

class _AddVisitViewState extends State<AddVisitView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add')),
      body: StreamBuilder(
          stream: CrudService().getPatientsListStream(),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<Patient>> snapshot,
          ) {
            final patientsList = snapshot.data ?? [];
            if (patientsList.isEmpty) {
              return const Center(
                child: Text(
                  'Nothing here, press "+" button to add your first patient!',
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Wrap(
                  children: [
                    DropdownButton(
                      items: patientsList
                          .map((Patient patient) => DropdownMenuItem(
                                value: patient,
                                child:
                                    Text('${patient.name} ${patient.surname}'),
                              ))
                          .toList(),
                      onChanged: (item) {},
                    )
                  ],
                ),
              );
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {},
        heroTag: 'addVisitTag',
        label: const Row(
          children: [
            Icon(Icons.add),
            Text('Add'),
          ],
        ),
      ),
    );
  }
}
