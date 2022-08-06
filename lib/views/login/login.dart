import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginPageView extends ConsumerWidget {
  const LoginPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          const Text("Login to the Blaze App"),
          ToggleButtons(
            isSelected: ref.watch(_loginSelector),
            onPressed: (selectedNumber) {
              var newList = List<bool>.from([false, false]);
              newList[selectedNumber] = true;
              ref.watch(_loginSelector.notifier).state = newList;
            },
            selectedColor: Colors.purple[300],
            borderRadius: BorderRadius.circular(15),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 30,
                    width: 70,
                    child: Center(
                        child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: const Text("User"),
                    ))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 30,
                    width: 70,
                    child: Center(
                        child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: const Text("Business"),
                    ))),
              ),
            ],
          ),
          _LoginSelectorView(),
          ElevatedButton(
              onPressed: () {
                // move to dashboard
                GoRouter.of(context).go('/home');
              },
              child: const Text("Login"))
        ],
      ),
    );
  }
}

final _loginSelector = StateProvider((ref) => [true, false]);
final _userLoginSelector = StateProvider((ref) => 0);

class _LoginSelectorView extends ConsumerWidget {
  _LoginSelectorView({Key? key}) : super(key: key);
  String? label;
  String? hint;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(_userLoginSelector.notifier).state == 0
        ? {label = "Phone Number", hint = "Enter Phone Number"}
        : {label = "Username", hint = "Enter username"};
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.3,
        child: ref.watch(_loginSelector)[0] == true
            ? Column(
                children: [
                  Row(children: [
                    SizedBox(
                        width: 200,
                        height: 50,
                        child: RadioListTile<int>(
                            value: 0,
                            groupValue: ref.watch(_userLoginSelector),
                            onChanged: (selected) => ref
                                .watch(_userLoginSelector.notifier)
                                .state = selected!,
                            title: const Text("Phone Number"))),
                    SizedBox(
                        width: 250,
                        height: 50,
                        child: RadioListTile<int>(
                            value: 1,
                            groupValue: ref.watch(_userLoginSelector),
                            onChanged: (selected) => ref
                                .watch(_userLoginSelector.notifier)
                                .state = selected!,
                            title: const Text("e-Wallet Username"))),
                  ]),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: label,
                            hintText: hint),
                      )),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelText: "Whatever this is supposed to be",
                        hintText: "random stuff")),
              ));
  }
}



// Key: ad1e0f4acd0eff062d8e7d523338f631
// Secret: f01537098b7421a2cec68e16bde6f37f