import 'dart:convert';

class AccountModel {
  double balance;
  List<BankDetails>? associatedBanks;

  AccountModel({required this.balance, this.associatedBanks});
}

class BankDetails {
  String accountName;
  String bankCode;
  String bankName;
  int accountNumber;
  double accountBalance;
  BankDetails({
    required this.accountName,
    required this.bankCode,
    required this.bankName,
    required this.accountNumber,
    required this.accountBalance,
  });

  Map<String, dynamic> toMap() {
    return {
      'accountName': accountName,
      'bankCode': bankCode,
      'bankName': bankName,
      'accountNumber': accountNumber,
      'accountBalance': accountBalance,
    };
  }

  factory BankDetails.fromMap(Map<String, dynamic> map) {
    return BankDetails(
      accountName: map['accountName'] ?? '',
      bankCode: map['bankCode'] ?? '',
      bankName: map['bankName'] ?? '',
      accountNumber: map['accountNumber']?.toInt() ?? 0,
      accountBalance: map['accountBalance']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BankDetails.fromJson(String source) =>
      BankDetails.fromMap(json.decode(source));
}
