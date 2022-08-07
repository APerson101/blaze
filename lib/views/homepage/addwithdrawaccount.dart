import 'package:blaze/models/accountmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddAccountForWithdraw extends ConsumerWidget {
  const AddAccountForWithdraw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: Column(children: [
        const ListTile(
          leading: BackButton(),
          title: Align(child: Text("Add new Account")),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (accNumber) {
              ref.watch(_accNumber.notifier).state = int.parse(accNumber);
            },
            decoration: InputDecoration(
                hintText: "Enter account number",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (accNumber) {
              ref.watch(_bankName.notifier).state = (accNumber);
            },
            decoration: InputDecoration(
                hintText: "Enter bank name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
        ),
        Text(ref.watch(_accountName)),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(BankDetails(
                  accountName: ref.watch(_accountName),
                  bankCode: 'bankCode',
                  bankName: ref.watch(_bankName),
                  accountNumber: ref.watch(_accNumber),
                  accountBalance: 0));
            },
            child: const Text("continue"))
      ]),
    );
  }
}

final _accNumber = StateProvider((ref) => 0);
final _bankName = StateProvider((ref) => '');
final _accountName = StateProvider((ref) => '');
