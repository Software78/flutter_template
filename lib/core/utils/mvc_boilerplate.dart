// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

///1. copy controller and view to a new view folder
///2. Find and replace Mvc with the name of the view
///3. Resolve all imports and you're good to go

abstract class StatelessView<T1, T2> extends StatelessWidget {
  final T2 controller;
  T1 get widget => (controller as State).widget as T1;
  const StatelessView(this.controller, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context);
}

class MvcScreen extends StatefulWidget {
  static const String route = 'mvc';
  const MvcScreen({Key? key}) : super(key: key);

  @override
  State<MvcScreen> createState() => MvcController();
}

class MvcController extends State<MvcScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MvcView(this);
  }
}

class MvcView extends StatelessView<MvcScreen, MvcController> {
  const MvcView(MvcController state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
