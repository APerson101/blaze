class AccountingModel {
  String? customerNumber;
  String? accountNumber;
  String? accountType;
  String? currency;
  String? currencyCode;
  String? availableBalance;
  String? localEquivalentAvailableBalance;
  String? accountBranch;

  AccountingModel(
      {this.accountBranch,
      this.accountNumber,
      this.accountType,
      this.availableBalance,
      this.currency,
      this.currencyCode,
      this.customerNumber,
      this.localEquivalentAvailableBalance});

  factory AccountingModel.fromJson(Map<String, dynamic> data) {
    return AccountingModel(
      accountBranch: data['accountBranch'],
      accountNumber: data['accountNumber'],
      accountType: data['accountType'],
      availableBalance: data['availableBalance'],
      currency: data['currency'],
      currencyCode: data['currencyCode'],
      customerNumber: data['customerNumber'],
      localEquivalentAvailableBalance: data['localEquivalentAvailableBalance'],
    );
  }
}
