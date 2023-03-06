import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pat_gest/utils/pat_gest_drawer.dart';

class FoodsListView extends StatefulWidget {
  const FoodsListView({super.key});

  @override
  State<FoodsListView> createState() => _FoodsListViewState();
}

class _FoodsListViewState extends State<FoodsListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Food List')),
      drawer: const PatGestDrawer(),
      body: const Center(
        child: Text('FOOD LIST'),
      ),
    );
  }
}
