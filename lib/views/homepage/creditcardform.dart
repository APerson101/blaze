import 'package:blaze/views/homepage/fundaccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

final cardNumberProvider = StateProvider((ref) => '');
final date = StateProvider((ref) => '00/00');
final name = StateProvider((ref) => '');
final cvv = StateProvider((ref) => '');
final showBackView = StateProvider((ref) => false);

class CreditCardFormView extends ConsumerWidget {
  CreditCardFormView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final OutlineInputBorder? border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: Column(
        children: [
          const ListTile(
              leading: BackButton(),
              title: Align(child: Text("Add card information"))),
          const Gap(20),
          CreditCardWidget(
              // glassmorphismConfig: Glassmorphism.defaultConfig(),
              cardNumber: ref.watch(cardNumberProvider),
              expiryDate: ref.watch(date),
              cardHolderName: ref.watch(name),
              cvvCode: ref.watch(cvv),
              showBackView: ref.watch(showBackView),
              obscureCardNumber: true,
              obscureCardCvv: true,
              isHolderNameVisible: true,
              cardBgColor: Colors.red,
              isSwipeGestureEnabled: true,
              onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
              customCardTypeIcons: <CustomCardTypeIcon>[
                CustomCardTypeIcon(
                  cardType: CardType.mastercard,
                  cardImage: Image.asset(
                    'assets/images/mastercard.png',
                    height: 48,
                    width: 48,
                  ),
                ),
              ]),
          Expanded(
              child: SingleChildScrollView(
            child: CreditCardForm(
              formKey: formKey,
              obscureCvv: true,
              obscureNumber: true,
              cardNumber: ref.read(cardNumberProvider),
              cvvCode: ref.read(cvv),
              isHolderNameVisible: true,
              isCardNumberVisible: true,
              isExpiryDateVisible: true,
              cardHolderName: ref.read(name),
              expiryDate: ref.read(date),
              themeColor: Colors.blue,
              textColor: Colors.black,
              cardNumberDecoration: InputDecoration(
                labelText: 'Number',
                hintText: 'XXXX XXXX XXXX XXXX',
                hintStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.black),
                focusedBorder: border,
                enabledBorder: border,
              ),
              expiryDateDecoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.black),
                focusedBorder: border,
                enabledBorder: border,
                labelText: 'Expired Date',
                hintText: 'XX/XX',
              ),
              cvvCodeDecoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.black),
                focusedBorder: border,
                enabledBorder: border,
                labelText: 'CVV',
                hintText: 'XXX',
              ),
              cardHolderDecoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.black),
                focusedBorder: border,
                enabledBorder: border,
                labelText: 'Card Holder',
              ),
              onCreditCardModelChange: (creditCardModel) =>
                  onCreditCardModelChange(creditCardModel, ref),
            ),
          )),
          ElevatedButton(
              onPressed: () {
                formKey.currentState!.validate()
                    ? Navigator.of(context).pop(DebitCards(
                        number: ref.watch(cardNumberProvider),
                        cvv: ref.watch(cvv),
                        date: ref.watch(date),
                        name: ref.watch(name)))
                    : null;
              },
              child: const Text("Continue")),
          const Gap(50)
        ],
      ),
    );
  }

  void onCreditCardModelChange(
      CreditCardModel? creditCardModel, WidgetRef ref) {
    print(creditCardModel!.cardNumber);
    ref.watch(cardNumberProvider.notifier).state = creditCardModel.cardNumber;
    ref.watch(date.notifier).state = creditCardModel.expiryDate;
    ref.watch(name.notifier).state = creditCardModel.cardHolderName;
    ref.watch(cvv.notifier).state = creditCardModel.cvvCode;
    ref.watch(showBackView.notifier).state = creditCardModel.isCvvFocused;
  }
}
