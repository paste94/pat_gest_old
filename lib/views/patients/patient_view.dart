import 'package:flutter/material.dart';
import 'package:pat_gest/db/drift_database.dart';
import 'package:pat_gest/services/crud_service.dart';

class PatientView extends StatefulWidget {
  const PatientView({super.key});

  @override
  State<PatientView> createState() => _PatientViewState();
}

class _PatientViewState extends State<PatientView> {
  @override
  Widget build(BuildContext context) {
    final int? patientId = ModalRoute.of(context)?.settings.arguments as int?;
    if (patientId == null) {
      Scaffold(
        appBar: AppBar(title: const Text('ERROR')),
      );
    }
    return StreamBuilder(
      stream: CrudService().getPatientStream(id: patientId!),
      builder: (context, snapshot) {
        final patient = snapshot.data;
        return Scaffold(
          appBar: AppBar(
              title: Text(
                  '${patient?.name ?? 'NONE'} ${patient?.surname ?? 'NONE'}')),
        );
      },
    );

    /*
    if (patientId == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ERROR'),
          backgroundColor: Colors.red,
        ),
        body: const Center(
          child: Text('NONE'),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(title: const Text('Patient')),
        body: StreamBuilder(
          stream: CrudService().getPatientStream(id: patientId),
          builder: (context, snapshot) {
            return const Center(
                child: Column(
              children: [
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
              ],
            ));
          },
        ));
        */
  }
}
