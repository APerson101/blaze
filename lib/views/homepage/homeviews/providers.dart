import 'package:blaze/models/user.dart';
import 'package:blaze/views/homepage/homepageview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/enairaacc.dart';

final laodUserDetails =
    FutureProvider.family<ENairaInfo, Map<String, String>>((ref, alias) async {
  var api = ref.watch(apiHelper);
  var account = await api.getUSerByAlias(alias['alias']!);
  var balance = await api.getAccountsBalance(
      alias['email']!, alias['username']!, alias['password']!);
  return ENairaInfo(user: User.fromMap(account), accs: balance);
});

final loadCard =
    FutureProvider.family<CardInfo, String>((ref, walletalias) async {
  return await ref.watch(apiHelper).getCard(alias: walletalias);
});
