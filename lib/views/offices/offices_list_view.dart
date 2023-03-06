import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pat_gest/utils/pat_gest_drawer.dart';

class OfficesListView extends StatefulWidget {
  const OfficesListView({super.key});

  @override
  State<OfficesListView> createState() => _OfficesListViewState();
}

class _OfficesListViewState extends State<OfficesListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offices List')),
      drawer: const PatGestDrawer(),
      body: const Center(
        child: Text('OFFICES LIST'),
      ),
    );
  }
}
