import 'package:blaze/views/homepage/homepageview.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';

class SendFundsView extends ConsumerWidget {
  const SendFundsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
            child: Column(children: [
          const ListTile(leading: BackButton(), title: Text("Send Funds")),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                onChanged: (amount) => ref.watch(_amountToSend.notifier).state =
                    double.parse(amount),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Enter Amount',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)))),
          ),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                onChanged: (receiver) =>
                    ref.watch(_receiverAlias.notifier).state = receiver,
                decoration: InputDecoration(
                    hintText: 'Enter Receiver alias',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)))),
          ),
          ElevatedButton(
              onPressed: () {
                // ref
                //     .watch(apiHelper)
                //     .sendFunds(username, password, email, amount, receiver);
              },
              child: Text("Send")),
          const Gap(20),
          Text('or send to contact'),
          const Gap(20),
          ElevatedButton(
            onPressed: () async {
              if (!kIsWeb) {
                if ((await Permission.contacts.status).isDenied) {
                  await Permission.contacts.request();
                }
                if (await Permission.contacts.request().isGranted) {
                  List<Contact> contacts =
                      await ContactsService.getContacts(withThumbnails: false);
                  await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SingleChildScrollView(
                            child: Column(
                                children: contacts
                                    .map((e) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            onTap: () {
                                              ref
                                                  .watch(
                                                      _selectedContact.notifier)
                                                  .state = e;
                                              Navigator.of(context).pop();
                                            },
                                            title: Text(e.displayName ?? ''),
                                            subtitle: Text(e.phones![0].value!),
                                          ),
                                        ))
                                    .toList()));
                      });
                } else {
                  //show contacts from google
                }
              }
            },
            child: const Text(
              "select contact",
              style: TextStyle(fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.green, minimumSize: Size(250, 50)),
          )
        ])),
      ),
    );
  }
}

final _amountToSend = StateProvider((ref) => 0.0);
final _receiverAlias = StateProvider((ref) => '');
final _selectedContact = StateProvider<Contact?>((ref) => null);
