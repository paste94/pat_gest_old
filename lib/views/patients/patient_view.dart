import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pat_gest/constants/routes.dart';
import 'package:pat_gest/constants/strings.dart';
import 'package:pat_gest/constants/theme.dart';
import 'package:pat_gest/db/drift_database.dart';
import 'package:pat_gest/services/crud_service.dart';
import 'package:pat_gest/utils/error_alert.dart';
import 'package:pat_gest/utils/pair.dart';
import 'package:pat_gest/utils/text_divider.dart';
import 'package:pat_gest/views/error/error_view.dart';

class PatientView extends StatefulWidget {
  const PatientView({super.key});

  @override
  State<PatientView> createState() => _PatientViewState();
}

class _PatientViewState extends State<PatientView> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _dateController = TextEditingController();
  final _notesController = TextEditingController();
  final _heightController = TextEditingController();
  bool _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    final int patientId = ModalRoute.of(context)!.settings.arguments as int;
    return StreamBuilder(
      stream: CrudService().getPatientStream(id: patientId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const ErrorView();
        }
        Patient? patient = snapshot.data;

        _nameController.text = patient?.name ?? '...';
        _surnameController.text = patient?.surname ?? '...';
        _emailController.text = patient?.email ?? '...';
        _phoneNumberController.text = patient?.phoneNumber ?? '...';
        _notesController.text = patient?.notes ?? '...';
        _heightController.text = '${patient?.height}';
        _dateController.text = DateFormat(dateFormatConst)
            .format(patient?.dateOfBirth ?? DateTime.now());

        return Scaffold(
          appBar: AppBar(
            title: Text('${patient?.name} ${patient?.surname}'),
            actions: [
              _isEnabled
                  ? IconButton(
                      onPressed: () => _handleEditPatient(
                        context: context,
                        patient: patient,
                      ),
                      icon: const Icon(Icons.save),
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          _isEnabled = true;
                        });
                      },
                      icon: const Icon(Icons.edit),
                    ),
              PopupMenuButton<int>(
                onSelected: (item) => _handleDeletion(
                  context: context,
                  patient: patient,
                ),
                itemBuilder: (context) => [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Text('Delete user'),
                  ),
                ],
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Wrap(
                runSpacing: spacingConst,
                children: [
                  const TextDivider(text: 'Personal data'),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          enabled: _isEnabled,
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                          ),
                          style: _textColorStyle(context),
                        ),
                      ),
                      SizedBox(width: spacingConst),
                      Expanded(
                        child: TextField(
                          enabled: _isEnabled,
                          controller: _surnameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Surname',
                          ),
                          style: _textColorStyle(context),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          enabled: _isEnabled,
                          controller: _emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                          style: _textColorStyle(context),
                        ),
                      ),
                      SizedBox(width: spacingConst),
                      Expanded(
                        child: TextField(
                          enabled: _isEnabled,
                          controller: _phoneNumberController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone number',
                          ),
                          style: _textColorStyle(context),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          enabled: _isEnabled,
                          controller: _heightController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Height',
                            suffix: Text('cm'),
                          ),
                          style: _textColorStyle(context),
                        ),
                      ),
                      SizedBox(width: spacingConst),
                      Expanded(
                        child: TextField(
                          enabled: _isEnabled,
                          controller: _dateController,
                          style: _textColorStyle(context),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Birth date',
                            suffixIcon: IconButton(
                              onPressed: () => _handleOpenDatePicker(
                                context: context,
                                initialDate: patient!.dateOfBirth!,
                              ),
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const TextDivider(text: 'Notes'),
                  TextField(
                    enabled: _isEnabled,
                    controller: _notesController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 3,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Notes',
                    ),
                    style: _textColorStyle(context),
                  ),
                  const TextDivider(text: 'Visits'),
                  // TODO: Aggiungere elenco degli ultimi N eventi
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'addVisitTag',
            onPressed: () {
              Navigator.of(context).pushNamed(
                addVisitRoute,
                arguments: Pair<Patient?, DateTime?>(patient, null),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  TextStyle? _textColorStyle(context) {
    return _isEnabled
        ? null
        : TextStyle(color: Theme.of(context).disabledColor);
  }

  Future _handleEditPatient({
    required BuildContext context,
    Patient? patient,
  }) async {
    if (patient != null) {
      setState(() {
        _isEnabled = false;
      });
      Patient newPatient = Patient(
        id: patient.id,
        name: _nameController.text,
        surname: _surnameController.text,
        email: _emailController.text,
        phoneNumber: _phoneNumberController.text,
        notes: _notesController.text,
        height: double.parse(_heightController.text),
        dateOfBirth: DateFormat(dateFormatConst).parse(_dateController.text),
      );
      if (patient != newPatient) {
        try {
          await CrudService().updatePatient(newPatient);
        } catch (e) {
          showErrorAlert(context, e.toString());
        }
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Patient updated succesfully'),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {},
            ),
          ),
        );
      }
    }
  }

  Future _handleDeletion({
    required BuildContext context,
    Patient? patient,
  }) async {
    if (patient != null) {
      showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: const Text('Warning!'),
              content: Text(
                'Are you really sure you want to delete ${patient.name} ${patient.surname}? \nThis operation cannot be undone!',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    CrudService().deletePatient(patient.id);
                  },
                  child: const Text('Delete'),
                )
              ],
            )),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  Future _handleOpenDatePicker({
    required BuildContext context,
    required DateTime initialDate,
  }) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      _dateController.text = DateFormat(dateFormatConst).format(pickedDate);
    }
  }
}
