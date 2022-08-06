import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class WithDrawFromAccount extends ConsumerWidget {
  const WithDrawFromAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ListTile(
          leading: IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          title: const Text('Withdraw eNaira'),
        ),
        const Gap(20),
        Align(
            alignment: Alignment.center,
            child: ElevatedButton(
                child: const Text('Select Account'),
                onPressed: () async {
                  await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ref.watch(_getAccounts).when(
                            data: (list) {
                              return SingleChildScrollView(
                                  child: Column(
                                      children: list
                                          .map((e) => Material(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ListTile(
                                                    onTap: () {
                                                      ref
                                                          .watch(
                                                              _selectedAccount
                                                                  .notifier)
                                                          .state = e;
                                                    },
                                                    title:
                                                        Text(e['account_name']),
                                                    subtitle: Text(e['bank']),
                                                    trailing: Text(
                                                        e['account_number']),
                                                  ),
                                                ),
                                              ))
                                          .toList()));
                            },
                            error: (err, st) {
                              return const Center(
                                  child: Text(
                                      "Failed to load accounts, try again "));
                            },
                            loading: () => const Center(
                                child: CircularProgressIndicator.adaptive()));
                      });
                })),
        const Gap(20),
      ],
    );
  }
}

final _getAccounts = FutureProvider((ref) async {
  return List<Map<String, dynamic>>.generate(
      4,
      (index) => {
            'account_name': "Abba BabaGana",
            'account_number': 12345678,
            'bank': "GtBank"
          });
});

final _selectedAccount = StateProvider<Map<String, dynamic>>((ref) => {'': ''});
