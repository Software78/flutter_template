import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/config/di/app_initializer.dart';
import 'package:go_router/go_router.dart';

import '../../main.dart';

GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  observers: [],
  routes: [
    GoRoute(
      path: MyHomePage.routeName,
      pageBuilder: (context, state) => buildPage(
        const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    ),
  ],
);

Page buildPage(Widget child) {
  return Platform.isIOS
      ? CupertinoPage(child: child)
      : MaterialPage(child: child);
}
