import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

abstract class NavigationService {
  Future<T?> push<T extends Object?>(String routeName, {Object? extra});

  Future<T?> pushReplacement<T extends Object?>(String routeName,
      {Object? extra});

  void go(String routeName, {Object? extra});

  void pop<T extends Object?>([T? result]);

  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? extra,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  });

  Future<T?> pushReplacementNamed<T extends Object?>(
    String routeName, {
    Object? extra,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  });

  void goNamed(
    String routeName, {
    Object? extra,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  });
}

class GoRouterNavigatorImpl implements NavigationService {
  final GlobalKey<NavigatorState> navigatorKey;

  GoRouterNavigatorImpl(this.navigatorKey);

  @override
  void go(String routeName, {Object? extra}) {
    GoRouter.of(navigatorKey.currentContext!).go(routeName, extra: extra);
  }

  @override
  void goNamed(
    String routeName, {
    Object? extra,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) {
    GoRouter.of(navigatorKey.currentContext!).goNamed(
      routeName,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  @override
  Future<T?> push<T extends Object?>(String routeName, {Object? extra}) {
    return GoRouter.of(navigatorKey.currentContext!)
        .push<T>(routeName, extra: extra);
  }

  @override
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? extra,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) {
    return GoRouter.of(navigatorKey.currentContext!).pushNamed<T>(
      routeName,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  @override
  void pop<T extends Object?>([T? result]) {
    GoRouter.of(navigatorKey.currentContext!).pop(result);
  }

  @override
  Future<T?> pushReplacement<T extends Object?>(String routeName,
      {Object? extra}) {
    return GoRouter.of(navigatorKey.currentContext!).pushReplacement<T>(
      routeName,
      extra: extra,
    );
  }

  @override
  Future<T?> pushReplacementNamed<T extends Object?>(
    String routeName, {
    Object? extra,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) {
    return GoRouter.of(navigatorKey.currentContext!).pushReplacementNamed<T>(
      routeName,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }
}

extension NavigatorExtension on BuildContext {
  NavigationService get navigator => GetIt.instance<NavigationService>();
}
