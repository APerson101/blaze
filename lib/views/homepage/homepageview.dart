// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:blaze/helpers/apihelper.dart';
import 'package:blaze/models/enairaacc.dart';
import 'package:blaze/views/homepage/homeviews/cardsview.dart';
import 'package:blaze/views/homepage/homeviews/dashboardview.dart';
import 'package:blaze/views/homepage/homeviews/notificationsview.dart';
import 'package:blaze/views/homepage/homeviews/profileview.dart';

import '../../models/user.dart';

class HomePageView extends StatelessWidget {
  const HomePageView(
      {Key? key,
      required this.email,
      required this.username,
      required this.password})
      : super(key: key);
  final String email;
  final String username;
  final String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MediaQuery.of(context).size.width > 500
          ? null
          : const _BottomNavBar(),
      body: _HomeBody(
          alias: {'username': username, 'password': password, 'email': email}),
    );
  }
}

class _HomeBody extends ConsumerWidget {
  _HomeBody({Key? key, required this.alias}) : super(key: key);
  Map<String, String> alias;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        MediaQuery.of(context).size.width > 500
            ? const Positioned(left: 10, top: 10, bottom: 10, child: SideBar())
            : const SizedBox(),
        IndexedStack(
          index:
              BottomBarItems.values.indexOf(ref.watch(selectedIndexProvider)),
          children: [
            DashboardView(
              walletAlias: alias,
            ),
            CardsView(),
            NotificationsView(),
            ProfileView()
          ],
        ),
      ],
    );
  }
}

class _BottomNavBar extends ConsumerWidget {
  const _BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
        onTap: (selected) => ref.watch(selectedIndexProvider.notifier).state =
            BottomBarItems.values[selected],
        currentIndex:
            BottomBarItems.values.indexOf(ref.watch(selectedIndexProvider)),
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        items: BottomBarItems.values.map((e) {
          Widget icon;
          String label = '';
          switch (e) {
            case BottomBarItems.home:
              icon = const Icon(Icons.home);
              label = "Home";
              break;
            case BottomBarItems.card:
              icon = const Icon(Icons.card_giftcard_rounded);
              label = "Cards";

              break;
            case BottomBarItems.notifications:
              icon = const Icon(Icons.notifications);
              label = "Notifications";

              break;
            case BottomBarItems.profile:
              icon = const Icon(Icons.person);
              label = "Profile";

              break;
            default:
              icon = const Icon(Icons.abc);
          }
          return BottomNavigationBarItem(icon: icon, label: label);
        }).toList());
  }
}

class SideBar extends ConsumerWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationRail(
        extended: MediaQuery.of(context).size.width > 800,
        labelType: MediaQuery.of(context).size.width < 800
            ? NavigationRailLabelType.selected
            : null,
        onDestinationSelected: (selected) => ref
            .watch(selectedIndexProvider.notifier)
            .state = BottomBarItems.values[selected],
        selectedIndex:
            BottomBarItems.values.indexOf(ref.watch(selectedIndexProvider)),
        destinations: BottomBarItems.values.map((e) {
          Widget icon;
          String label = 'fdfs';
          switch (e) {
            case BottomBarItems.home:
              icon = const Icon(Icons.home);
              label = "Home";
              break;
            case BottomBarItems.card:
              icon = const Icon(Icons.card_giftcard_rounded);
              label = "Cards";

              break;
            case BottomBarItems.notifications:
              icon = const Icon(Icons.notifications);
              label = "Notifications";

              break;
            case BottomBarItems.profile:
              icon = const Icon(Icons.person);
              label = "Profile";
              break;
            default:
              icon = const Icon(Icons.abc);
          }
          return NavigationRailDestination(icon: icon, label: Text(label));
        }).toList());
  }
}

enum BottomBarItems { home, card, notifications, profile }

final selectedIndexProvider = StateProvider((ref) => BottomBarItems.home);

final apiHelper = StateProvider((ref) => APiHelper());

class CardInfo {
  String cardNumber;
  String expiriyDate;
  String cvv;
  String cardName;
  String balance;
  CardInfo(
      {required this.cardNumber,
      required this.expiriyDate,
      required this.cvv,
      required this.cardName,
      required this.balance});

  CardInfo copyWith(
      {String? cardNumber,
      String? expiriyDate,
      String? cvv,
      String? cardName,
      String? balance}) {
    return CardInfo(
        cardNumber: cardNumber ?? this.cardNumber,
        expiriyDate: expiriyDate ?? this.expiriyDate,
        cvv: cvv ?? this.cvv,
        cardName: cardName ?? this.cardName,
        balance: balance ?? this.balance);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cardNumber': cardNumber,
      'expiriyDate': expiriyDate,
      'cvv': cvv,
      'cardName': cardName,
      'balance': balance
    };
  }

  factory CardInfo.fromMap(Map<String, dynamic> map) {
    return CardInfo(
        cardNumber: map['cardNumber'] as String,
        expiriyDate: map['expiriyDate'] as String,
        cvv: map['cvv'] as String,
        cardName: map['cardName'] as String,
        balance: map['balance'] as String);
  }

  String toJson() => json.encode(toMap());

  factory CardInfo.fromJson(String source) =>
      CardInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CardInfo(cardNumber: $cardNumber, expiriyDate: $expiriyDate, cvv: $cvv, cardName: $cardName)';
  }

  @override
  bool operator ==(covariant CardInfo other) {
    if (identical(this, other)) return true;

    return other.cardNumber == cardNumber &&
        other.expiriyDate == expiriyDate &&
        other.cvv == cvv &&
        other.cardName == cardName;
  }

  @override
  int get hashCode {
    return cardNumber.hashCode ^
        expiriyDate.hashCode ^
        cvv.hashCode ^
        cardName.hashCode;
  }
}
