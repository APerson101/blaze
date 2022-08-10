import 'package:blaze/models/accountmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'addwithdrawaccount.dart';

class WithDrawFromAccount extends ConsumerWidget {
  WithDrawFromAccount({Key? key, required this.account}) : super(key: key);
  final AccountModel account;
  BankDetails? selectedAccount;
  final TextEditingController balanceController =
      TextEditingController(text: '0.0');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: Column(
        children: [
          ListTile(
            leading: IconButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            title: const Align(
                alignment: Alignment.center, child: Text('Withdraw eNaira')),
          ),
          const Gap(20),
          Align(
              alignment: Alignment.center,
              child: Text(
                "Balance: ${account.balance.toString()}",
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              )),
          TextField(
            controller: balanceController,
            decoration: InputDecoration(
                hintText: 'Enter Amount to withdraw',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                suffix: TextButton(
                    onPressed: () {
                      balanceController.text = account.balance.toString();
                    },
                    child: const Text("Max"))),
          ),
          const Gap(20),
          ElevatedButton(
              onPressed: () async {
                await showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      var data = ref.watch(accountsState);
                      Widget validData;
                      if (data != null && data.isNotEmpty) {
                        validData = SingleChildScrollView(
                          child: Column(children: [
                            ListTile(
                                onTap: () async {
                                  final newaccount = await Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) =>
                                              const AddAccountForWithdraw()));
                                  newaccount != null
                                      ? ref
                                          .watch(accountsState.notifier)
                                          .state!
                                          .add(newaccount)
                                      : null;
                                },
                                title: const Align(
                                    child: Text("Enter new bank account"))),
                            ...data
                                .map((e) => ListTile(
                                      onTap: () {
                                        selectedAccount = e;
                                        Navigator.of(context).pop();
                                      },
                                      title: Text(e.accountName),
                                      subtitle: Text(e.bankName),
                                      trailing:
                                          Text(e.accountNumber.toString()),
                                    ))
                                .toList()
                          ]),
                        );
                      } else if (data == null) {
                        validData = const Center(child: Text("ERROR"));
                      } else {
                        validData = const CircularProgressIndicator.adaptive();
                      }

                      return validData;
                    });
              },
              child: const Text("Select Bank Account")),
          ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push('/withdrawconfirm', extra: {
                  'amount': balanceController.text,
                  'acount_to_fund': selectedAccount!
                });
              },
              child: const Text("Withdraw"))
        ],
      ),
    );
  }
}

// class _ToggleButton extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final children = <int, Widget>{
//       0: const Text('Select Account'),
//       1: const Text('New Account'),
//     };

//     return SizedBox(
//       width: MediaQuery.of(context).size.width * 0.5,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: CupertinoSlidingSegmentedControl<int>(
//           children: children,
//           onValueChanged: (selected) =>
//               ref.watch(_toggleState.notifier).state = selected!,
//           groupValue: ref.watch(_toggleState),
//         ),
//       ),
//     );
//   }
// }

class WithdrawConfirmation extends StatelessWidget {
  const WithdrawConfirmation({Key? key, required this.details})
      : super(key: key);
  final Map<String, dynamic> details;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(children: [
        ListTile(
          leading: IconButton(
              onPressed: () => GoRouter.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_new)),
          title: const Align(
              alignment: Alignment.center, child: Text("Confirm Withdrawal")),
        ),
        const Gap(20),
        const Text('Withdraw'),
        const Gap(20),
        Text(details['amount'].toString()),
        const Gap(20),
        const Text('to'),
        const Gap(20),
        ListTile(
          subtitle: Text((details['acount_to_fund'] as BankDetails)
              .accountNumber
              .toString()),
          title: Text((details['acount_to_fund'] as BankDetails).accountName),
          trailing: Text((details['acount_to_fund'] as BankDetails).bankName),
        ),
        const Gap(20),
        ElevatedButton(
            onPressed: () {
              GoRouter.of(context).push('/withdrawstatus');
            },
            child: const Text("Confirm"))
      ]),
    );
  }
}

final accountsState = StateProvider<List<BankDetails>?>((ref) {
  return ref
      .watch(_getAllAccounts)
      .when(data: (data) => data, error: (er, st) => null, loading: () => []);
});
final _getAllAccounts = FutureProvider<List<BankDetails>>((ref) async {
  return List.generate(
      7,
      (index) => BankDetails(
          accountName: 'accountName',
          bankCode: 'bankCode',
          bankName: 'bankName',
          accountNumber: 123456,
          accountBalance: 0.0));
});
