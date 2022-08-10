import 'dart:io';
import 'dart:ui';

import 'package:blaze/helpers/apihelper.dart';
import 'package:blaze/models/accountmodel.dart';
import 'package:blaze/views/homepage/withdrawalstatus.dart';
import 'package:blaze/views/homepage/withdrawfromaccount.dart';
import 'package:blaze/views/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import 'views/homepage/homepageview.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
  // runApp(ProviderScope(child: BackDrop()));
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
          var map = state.extra! as Map<String, dynamic>;
          return HomePageView(
            username: map['username'],
            email: map['email'],
            password: map['password'],
          );
        },
      ),
      GoRoute(
        path: '/withdraw',
        builder: (BuildContext context, GoRouterState state) {
          return WithDrawFromAccount(account: state.extra as AccountModel);
        },
      ),
      GoRoute(
        path: '/withdrawconfirm',
        builder: (BuildContext context, GoRouterState state) {
          return WithdrawConfirmation(
            details: {
              'amount': (state.extra! as Map<String, dynamic>)['amount'],
              'acount_to_fund': ((state.extra!
                  as Map<String, dynamic>)['acount_to_fund'] as BankDetails)
            },
          );
        },
      ),
      GoRoute(
        path: '/withdrawstatus',
        builder: (BuildContext context, GoRouterState state) {
          return const WithDrawalStatus();
        },
      ),
      // GoRoute(
      //   path: '/fund',
      //   builder: (BuildContext context, GoRouterState state) {
      //     return FundAccountView();
      //   },
      // ),
      // GoRoute(
      //   path: '/creditcardform',
      //   builder: (BuildContext context, GoRouterState state) {
      //     FundAccountView.
      //     // return CreditCardFormView(card: FundAccountView. );
      //   },
      // ),
    ],
  );
}

class BackDrop extends StatelessWidget {
  BackDrop({Key? key}) : super(key: key);
  final APiHelper helper = APiHelper();
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
                child: Center(
                  child: ElevatedButton(
                    child: const Text("HELLO WORLD"),
                    onPressed: () async {
                      await helper.getUSerByAlias('@imbah.01g9vgj');
                      // await helper.createUserAcccount({
                      //   // "uidType": "99063757",
                      //   "reference": 'NXG3547585H5T9069HGO',
                      //   // "title": 'Mr',
                      //   // 'firstName': "Farouq musa",
                      //   // "lastName": "Froggie",
                      //   // "userName": "testusername@cbn.gov.ng",
                      //   // "phone": "91234587532",
                      //   // 'emailId': "testusername@cbn.gov.ng",
                      //   // 'postalCode': "900119",
                      //   // 'city': "Abj",
                      //   // 'address': "e get as e be",
                      //   // 'countryOfResidence': "NG",
                      //   'tier': "2",
                      //   'accountNumber': "0985675844",
                      //   'dateOfBirth': "31/12/1996",
                      //   'countryOfBirth': "NG",
                      //   'password': "1234567890877",
                      //   'remarks': "Passed",
                      //   // 'referralCode': "@imbah.01",
                      // });
                    },
                  ),
                )))
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
