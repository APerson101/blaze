// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blaze/models/accountingmodel.dart';
import 'package:blaze/models/user.dart';

class ENairaInfo {
  User user;
  List<AccountingModel> accs;
  ENairaInfo({
    required this.user,
    required this.accs,
  });
}
