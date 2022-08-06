import 'package:blaze/views/homepage/homeviews/cardsview.dart';
import 'package:blaze/views/homepage/homeviews/dashboardview.dart';
import 'package:blaze/views/homepage/homeviews/notificationsview.dart';
import 'package:blaze/views/homepage/homeviews/profileview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MediaQuery.of(context).size.width > 500
          ? null
          : const _BottomNavBar(),
      body: const _HomeBody(),
    );
  }
}

class _HomeBody extends ConsumerWidget {
  const _HomeBody({Key? key}) : super(key: key);

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
          children: const [
            DashboardView(),
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
