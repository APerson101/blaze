import 'package:blaze/helpers/apihelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginPageView extends ConsumerWidget {
  const LoginPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          const Gap(40),
          const Text("Login to the Blaze App"),
          const Gap(20),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (username) =>
                    ref.watch(_usernamefield.notifier).state = username,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'Username',
                    hintText: 'Enter username'),
              )),
          const Gap(40),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (password) =>
                    ref.watch(_passwordfield.notifier).state = password,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'Password',
                    hintText: 'Enter password'),
              )),
          const Gap(40),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (email) =>
                    ref.watch(_emailfield.notifier).state = email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'Email',
                    hintText: 'Enter valid Email'),
              )),
          // ToggleButtons(
          //   isSelected: ref.watch(_loginSelector),
          //   onPressed: (selectedNumber) {
          //     var newList = List<bool>.from([false, false]);
          //     newList[selectedNumber] = true;
          //     ref.watch(_loginSelector.notifier).state = newList;
          //   },
          //   selectedColor: Colors.purple[300],
          //   borderRadius: BorderRadius.circular(15),
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: SizedBox(
          //           height: 30,
          //           width: 70,
          //           child: Center(
          //               child: DecoratedBox(
          //             decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(15)),
          //             child: const Text("User"),
          //           ))),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: SizedBox(
          //           height: 30,
          //           width: 70,
          //           child: Center(
          //               child: DecoratedBox(
          //             decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(15)),
          //             child: const Text("Business"),
          //           ))),
          //     ),
          //   ],
          // ),
          // Align(alignment: Alignment.center, child: _LoginSelectorView()),
          ElevatedButton(
              onPressed: () async {
                // move to dashboard
                //var status =
                await APiHelper().userLogin(
                    ref.read(_usernamefield), ref.read(_passwordfield));
                // status == -1
                // ?
                // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //     content: ListTile(
                //     title: Text('invalid login details provided'),
                //   )))
                // :
                GoRouter.of(context).go('/home', extra: {
                  'username': ref.read(_usernamefield),
                  'password': ref.read(_passwordfield),
                  'email': ref.read(_emailfield)
                });
              },
              child: const Text("Login"))
        ],
      ),
    );
  }
}

final _usernamefield = StateProvider((ref) => '');
final _passwordfield = StateProvider((ref) => '');
final _emailfield = StateProvider((ref) => '');

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
        : {label = "Username", hint = "Enter alias"};
    return Expanded(
      child: ref.watch(_loginSelector)[0] == true
          ? Column(
              children: [
                Row(children: [
                  Expanded(
                    child: RadioListTile<int>(
                        value: 0,
                        groupValue: ref.watch(_userLoginSelector),
                        onChanged: (selected) => ref
                            .watch(_userLoginSelector.notifier)
                            .state = selected!,
                        title: const Text("Phone Number")),
                  ),
                  Expanded(
                    child: RadioListTile<int>(
                        value: 1,
                        groupValue: ref.watch(_userLoginSelector),
                        onChanged: (selected) => ref
                            .watch(_userLoginSelector.notifier)
                            .state = selected!,
                        title: const Text("e-Wallet Alias")),
                  ),
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
            ),
    );
  }
}

// Key: ad1e0f4acd0eff062d8e7d523338f631
// Secret: f01537098b7421a2cec68e16bde6f37f
