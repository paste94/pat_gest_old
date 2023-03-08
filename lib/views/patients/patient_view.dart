import 'package:flutter/material.dart';
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
                '${patient?.name ?? 'NONE'} ${patient?.surname ?? 'NONE'}'),
          ),
          body: Center(),
        );
      },
    );
  }
}
