import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> pushNamed(String route, {Object? args}) {
    return navigatorKey.currentState!.pushNamed(route, arguments: args);
  }

  static Future<dynamic> pushReplacementNamed(String route, {Object? args}) {
    return navigatorKey.currentState!.pushReplacementNamed(
      route,
      arguments: args,
    );
  }

  static void pop([Object? result]) {
    navigatorKey.currentState!.pop(result);
  }

  static void popUntilRoot() {
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  static BuildContext get context =>
      navigatorKey.currentState!.overlay!.context;
}
