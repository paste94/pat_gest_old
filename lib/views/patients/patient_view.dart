import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pat_gest/services/crud_service.dart';
import 'package:pat_gest/utils/text_divider.dart';
import 'package:pat_gest/views/error/error_view.dart';

class PatientView extends StatefulWidget {
  const PatientView({super.key});

  @override
  State<PatientView> createState() => _PatientViewState();
}

class _PatientViewState extends State<PatientView> {
  final _spacing = 10.0;
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _dateController = TextEditingController();
  final _notesController = TextEditingController();

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
        if (snapshot.hasError) {
          return const ErrorView();
        }
        final patient = snapshot.data!;

        _nameController.text = patient.name ?? '';
        _surnameController.text = patient.surname ?? '';
        _emailController.text = patient.email ?? '';
        _phoneNumberController.text = patient.phoneNumber ?? '';
        _notesController.text = patient.notes ?? '';

        return Scaffold(
          appBar: AppBar(
            title:
                Text('${patient.name ?? 'NONE'} ${patient.surname ?? 'NONE'}'),
          ),
          body: SingleChildScrollView(
            child: Wrap(
              runSpacing: _spacing,
              children: [
                const TextDivider(text: 'Personal data'),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        enabled: false,
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                      ),
                    ),
                    SizedBox(width: _spacing),
                    Expanded(
                      child: TextField(
                        controller: _surnameController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Surname*',
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    SizedBox(width: _spacing),
                    Expanded(
                      child: TextField(
                        controller: _phoneNumberController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone number',
                        ),
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Birth date*',
                    suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null) {
                          _dateController.text =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                        }
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ),
                ),
                const TextDivider(text: 'Clinical data'),
                const TextDivider(text: 'Notes'),
                TextField(
                  controller: _notesController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Notes',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
