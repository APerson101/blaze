import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

class FundingStatus extends ConsumerWidget {
  const FundingStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentView = ref.watch(_currentView);
    switch (currentView) {
      case 0:
        return const OtpForm();
      case 1:
        return ref.watch(_sendFunds).when(
              data: (status) {
                return status
                    ? Material(
                        child: Column(
                          children: [
                            const Text('success'),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                    ..pop()
                                    ..pop();
                                },
                                child: const Text("back"))
                          ],
                        ),
                      )
                    : Material(
                        child: Column(
                          children: [
                            const Text('failed'),
                            const Text("reason pasted here"),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                    ..pop()
                                    ..pop();
                                },
                                child: const Text("back"))
                          ],
                        ),
                      );
              },
              error: (err, st) => const Material(
                  child: Center(child: Text("Error with connection"))),
              loading: () => const Material(
                  child: Center(child: CircularProgressIndicator.adaptive())),
            );
      default:
        return Material(
            child: ListTile(
          onTap: () => ref.watch(_currentView.notifier).state = 1,
          title: const Text("2"),
        ));
    }
  }
}

final _currentView = StateProvider((ref) => 0);

class OtpForm extends ConsumerWidget {
  const OtpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: ListTile(
              leading: BackButton(),
              title: Align(child: Text("Enter OTP")),
            ),
          ),
          Pinput(
            validator: (pin) {
              if (pin == '2222') {
                ref.watch(_currentView.notifier).state = 1;
                return null;
              }
              return 'Incorrect pin';
            },
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          ),
        ],
      ),
    );
  }
}

final _sendFunds = FutureProvider(
    (ref) async => Future.delayed(const Duration(seconds: 1), () => true));
