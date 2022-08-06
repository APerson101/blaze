import 'dart:ui';

import 'package:blaze/views/homepage/withdrawfromaccount.dart';
import 'package:blaze/views/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'views/homepage/homepageview.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
  // runApp(const ProviderScope(child: BackDrop()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: "Blaze",
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPageView();
        },
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePageView();
        },
      ),
      GoRoute(
        path: '/withdraw',
        builder: (BuildContext context, GoRouterState state) {
          return const WithDrawFromAccount();
        },
      ),
    ],
  );
}

class BackDrop extends StatelessWidget {
  const BackDrop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: test2()),
    );
  }

  Widget test2() {
    return Stack(
      children: [
        const Positioned.fill(child: FlutterLogo()),
        Positioned(
            top: 10,
            height: 40,
            left: 10,
            width: 100,
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 6),
                child: const Text("HELLO WORLD")))
      ],
    );
  }

  Widget test() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        const FlutterLogo(),
        Center(
          child: ClipRect(
            // <-- clips to the 200x200 [Container] below
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: Container(
                alignment: Alignment.center,
                width: 200.0,
                height: 200.0,
                child: const Text('Hello World'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
