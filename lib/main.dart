import 'dart:ui';

import 'package:blaze/views/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'views/homepage/homepageview.dart';
import 'views/homepage/homeviews/dashboardview.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
  // runApp(const ProviderScope(child: BackDrop()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
    ],
  );
}

class BackDrop extends StatelessWidget {
  const BackDrop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: _ButtonBar()),
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

class _ButtonBar extends StatelessWidget {
  const _ButtonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: [
        RoundedButton(
            text: 'receive',
            color: Colors.brown.shade400,
            onPressed: () {},
            icon: Icons.call_received),
        RoundedButton(
            onPressed: () {},
            text: 'send',
            color: Colors.blue.shade400,
            icon: Icons.upload),
        RoundedButton(
            onPressed: () {},
            text: 'bills',
            color: Colors.orange.shade400,
            icon: Icons.blinds),
        RoundedButton(
            onPressed: () {},
            text: 'pay',
            color: Colors.green.shade400,
            icon: Icons.wallet),
      ],
    );
  }
}
