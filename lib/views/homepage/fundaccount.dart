import 'package:blaze/views/homepage/creditcardform.dart';
import 'package:blaze/views/homepage/fundaccountstatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class FundAccountView extends ConsumerWidget {
  const FundAccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: Column(children: [
        ListTile(
          leading: IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          title: const Align(child: Text("Fund your eNaira Account")),
        ),
        const Gap(20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (number) => ref.watch(_amountProvider.notifier).state =
                double.parse(number),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: 'Enter Amount',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
        ),
        ref.watch(cardSelected) == null
            ? ButtonBar(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        var cards = ref.watch(_getAllCards);
                        await showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SingleChildScrollView(
                                child: Column(
                                    children: cards
                                        .map((e) => Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: ListTile(
                                                onTap: () {
                                                  //set selected card details
                                                  ref
                                                      .watch(
                                                          cardSelected.notifier)
                                                      .state = e;
                                                  Navigator.of(context).pop();
                                                },
                                                leading: const FlutterLogo(),
                                                title: Text(
                                                  '**** ${e.number.toString().substring(e.number.toString().length - 4, e.number.toString().length - 1)}',
                                                ),
                                                subtitle: Text(e.date),
                                              ),
                                            ))
                                        .toList()),
                              );
                            });
                      },
                      child: const Text("Select Card")),
                  ElevatedButton(
                      onPressed: () async {
                        // GoRouter.of(context).push('/creditcardform');
                        final debitcard = await Navigator.of(context)
                            .push<DebitCards>(MaterialPageRoute(
                                builder: (context) => CreditCardFormView()));
                        debitcard != null
                            ? {
                                ref.watch(cardSelected.notifier).state =
                                    debitcard,
                                ref
                                    .watch(_getAllCards.notifier)
                                    .state
                                    .add(debitcard)
                              }
                            : null;
                      },
                      child: const Text("Enter new Card"))
                ],
              )
            : ListTile(
                title: const Align(child: Text("Selected Card")),
                subtitle: Text(ref.watch(cardSelected)!.number),
                trailing: Text(ref.watch(cardSelected)!.date),
                leading: TextButton(
                    onPressed: () {
                      ref.watch(cardSelected.notifier).state = null;
                    },
                    child: const Text("Change")),
              ),
        ref.watch(_amountProvider) > 0.0 && ref.watch(cardSelected) != null
            ? ElevatedButton(
                onPressed: () {
                  //proceed
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const FundingStatus()));
                },
                child: const Text("Continue"))
            : Container()
      ]),
    );
  }
}

final cardSelected = StateProvider<DebitCards?>((ref) => null);
final _amountProvider = StateProvider<double>((ref) => 0.0);

final _getAllCards = StateProvider((ref) => List.generate(
    5,
    (index) => DebitCards(
        number: '123456789012',
        cvv: '321',
        date: '08/23',
        name: "Bamanga Tukur")));

class DebitCards {
  String number;
  String cvv;
  String date;
  String name;
  DebitCards({
    required this.number,
    required this.cvv,
    required this.date,
    required this.name,
  });
}
