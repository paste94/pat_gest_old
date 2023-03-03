import 'package:flutter/material.dart';
import 'package:pat_gest/constants/routes.dart';
import 'package:pat_gest/db/drift_database.dart';
import 'package:pat_gest/models/office_model.dart';
import 'package:pat_gest/services/crud_service.dart';

class AddPatientView extends StatefulWidget {
  const AddPatientView({super.key});

  @override
  State<AddPatientView> createState() => _AddPatientViewState();
}

class _AddPatientViewState extends State<AddPatientView> {
  var nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final notesController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Wrap(
            runSpacing: 10,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: surnameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Surname',
                ),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone number',
                ),
              ),
              TextField(
                controller: notesController,
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'uniqueTag',
        onPressed: () async {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) {
                return const Dialog(
                  // The background color
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // The loading indicator
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 15,
                        ),
                        // Some text
                        Text('Loading...')
                      ],
                    ),
                  ),
                );
              });
          await CrudService().createPatient(
            name: nameController.text,
            surname: surnameController.text,
            email: emailController.text,
            phoneNumber: phoneNumberController.text,
            note: notesController.text,
          );

          // close the dialog automatically
          if (mounted) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }
        },
        label: const Row(
          children: [Icon(Icons.add), Text('Add')],
        ),
      ),
    );
  }
}
