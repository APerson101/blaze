import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:blaze/models/accountmodel.dart';
import 'package:blaze/models/activitymodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../fundaccount.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: _Card(),
      ),
      const Positioned(
        top: 5,
        left: 0,
        right: 0,
        child: _TopBar(),
      ),
      Positioned(
          top: MediaQuery.of(context).size.height * 0.34,
          left: 0,
          right: 0,
          child: const _BottomSheet()),
    ]);
  }
}

class _TopBar extends ConsumerWidget {
  const _TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: ListTile(
        leading: const Icon(Icons.person),
        title: const Align(
            alignment: Alignment.centerLeft, child: Text("Hi, Alex")),
        trailing: Badge(
          badgeContent: const Text(
            "2",
            style: TextStyle(color: Colors.white),
          ),
          child: const Icon(Icons.notifications),
        ),
      ),
    );
  }
}

class _Card extends ConsumerWidget {
  _Card({Key? key}) : super(key: key);
  AccountModel? accountModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.37,
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                // image: DecorationImage(
                //     fit: BoxFit.fill, image: AssetImage('assets/images/i.png')),
                gradient: LinearGradient(
                    colors: [Colors.pink.shade100, Colors.purple.shade100]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 50.0, bottom: 85),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withOpacity(0.26),
                            Colors.white.withOpacity(0.15),
                          ],
                        )),
                        alignment: Alignment.center,
                        child: ref.watch(getAccount).when(
                            data: (account) {
                              accountModel = account;
                              return Column(
                                children: const [
                                  Expanded(
                                    child: ListTile(
                                      leading: FlutterLogo(),
                                      trailing: Text("VISA"),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      leading: Text("N 54, 5454"),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        "1234 1234 1234 1234",
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      leading: Text("EXP 12/25"),
                                      trailing: Text("CVV 442"),
                                    ),
                                  ),
                                ],
                              );
                            },
                            error: (err, stc) {
                              return const Center(
                                  child: Text("Failed to load"));
                            },
                            loading: () =>
                                const CircularProgressIndicator.adaptive()))),
              ),
            ),
            Positioned(
                bottom: 25,
                left: 0,
                right: 0,
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          // GoRouter.of(context).push('/fund');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const FundAccountView()));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          minimumSize: const Size(150, 50),
                        ),
                        child: Row(children: const [
                          Icon(Icons.upgrade_outlined),
                          Text("Fund")
                        ])),
                    ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context)
                              .push('/withdraw', extra: accountModel);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          minimumSize: const Size(150, 50),
                        ),
                        child: Row(children: const [
                          Icon(Icons.download),
                          Text("Withdraw")
                        ]))
                  ],
                ))
          ],
        ));
  }
}

class _BottomSheet extends ConsumerWidget {
  const _BottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      child: SizedBox(
          child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.white),
        child:
            // _ButtonBar()
            Column(
          children: const [_ButtonBar(), Text("Activity"), _Activity()],
        ),
      )),
    );
  }
}

final _toggleState = StateProvider((ref) => 0);

class _ToggleButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final children = <int, Widget>{
      0: const Text('Activity'),
      1: const Text('Explore'),
    };

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: CupertinoSlidingSegmentedControl<int>(
          children: children,
          onValueChanged: (selected) =>
              ref.watch(_toggleState.notifier).state = selected!,
          groupValue: ref.watch(_toggleState),
        ),
      ),
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
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => QrCodeView()));
            },
            text: 'pay',
            color: Colors.green.shade400,
            icon: Icons.wallet),
      ],
    );
  }
}

class RoundedButton extends ConsumerWidget {
  const RoundedButton(
      {Key? key,
      required this.text,
      required this.color,
      required this.icon,
      required this.onPressed})
      : super(key: key);
  final String text;
  final Color color;
  final IconData icon;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 75,
      height: 50,
      child: ListTile(
        title: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromRadius(20),
                primary: color,
                shape: const CircleBorder()),
            child: Icon(icon, size: 12)),
        subtitle: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                text,
                style: const TextStyle(fontSize: 13),
              ),
            )),
      ),
    );
  }
}

class _Activity extends ConsumerWidget {
  const _Activity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(activityProvider).when(data: (list) {
      return SingleChildScrollView(
          child: Column(
              children: list
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          color: Colors.blueAccent.shade100,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: ListTile(
                            leading: e.type == 'Debit'
                                ? const Icon(Icons.upload)
                                : const Icon(Icons.download),
                            trailing: Text(e.amount.toString()),
                            title: Text(e.name),
                            subtitle: Text(e.date.toLocal().toString()),
                          ),
                        ),
                      ))
                  .toList()));
    }, error: (Object error, StackTrace? stackTrace) {
      return const Center(
        child: Text("ERROR"),
      );
    }, loading: () {
      return const CircularProgressIndicator.adaptive();
    });
  }
}

final activityProvider = FutureProvider((ref) async {
  return List.generate(
      5,
      (index) => RecentActivityModel(
          type: 'Debit',
          amount: 5000,
          name: "Muhammad Sani",
          date: DateTime.now()));
});

final getAccount = FutureProvider((ref) async {
  return AccountModel(balance: 500000.0);
});

class QrCodeView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const ListTile(
              leading: BackButton(),
              title: Align(child: Text("Qr Code payment")),
            ),
            DefaultTabController(
                length: 2,
                child: Expanded(
                  child: Column(children: [
                    const TabBar(
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.black,
                        tabs: [
                          Tab(
                            text: 'QrCode Image',
                          ),
                          Tab(
                            text: 'Scan Qrcode',
                          )
                        ]),
                    Expanded(
                        child: TabBarView(
                            children: [const _QrCodeWidget(), _CameraWidget()]))
                  ]),
                ))
          ],
        ),
      ),
    );
  }
}

class _QrCodeWidget extends StatelessWidget {
  const _QrCodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: QrImage(
              data: "the user details go here",
              version: QrVersions.auto,
              size: 350),
        ),
      ),
    );
  }
}

class _CameraWidget extends ConsumerWidget {
  _CameraWidget({Key? key}) : super(key: key);
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 350.0
        : 500.0;
    return QRView(
      key: qrKey,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.blue,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onQRViewCreated: (controller) {
        ref.watch(_qrcontroller.notifier).state = controller;
        controller.scannedDataStream.listen((event) {
          ref.watch(_resultQrScan.notifier).state = event;
        });
      },
      onPermissionSet: (ctrl, p) => (context, ctrl, p) {
        debugPrint('${DateTime.now().toIso8601String()}_onPermissionSet $p');
        if (!p) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('no Permission')),
          );
        }
      },
    );
  }
}

final _resultQrScan = StateProvider<Barcode?>((ref) => null);
final _qrcontroller = StateProvider<QRViewController?>((ref) => null);
