import 'dart:convert';

class User {
  //
  String uid;
  String uid_type;
  String phone;
  String email_id;
  String first_name;
  String last_name;
  String middle_name;
  String title;
  String town;
  String state_of_residence;
  String lga;
  String address;
  String country_of_origin;
  String tier;
  String country_of_birth;
  String state_of_origin;
  String inst_code;
  String enaira_bank_code;
  WalletInfo wallet_info;
  User({
    required this.uid,
    required this.uid_type,
    required this.phone,
    required this.email_id,
    required this.first_name,
    required this.last_name,
    required this.middle_name,
    required this.title,
    required this.town,
    required this.state_of_residence,
    required this.lga,
    required this.address,
    required this.country_of_origin,
    required this.tier,
    required this.country_of_birth,
    required this.state_of_origin,
    required this.inst_code,
    required this.enaira_bank_code,
    required this.wallet_info,
  });

  User copyWith({
    String? uid,
    String? uid_type,
    String? phone,
    String? email_id,
    String? first_name,
    String? last_name,
    String? middle_name,
    String? title,
    String? town,
    String? state_of_residence,
    String? lga,
    String? address,
    String? country_of_origin,
    String? tier,
    String? country_of_birth,
    String? state_of_origin,
    String? inst_code,
    String? enaira_bank_code,
    WalletInfo? wallet_info,
  }) {
    return User(
      uid: uid ?? this.uid,
      uid_type: uid_type ?? this.uid_type,
      phone: phone ?? this.phone,
      email_id: email_id ?? this.email_id,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      middle_name: middle_name ?? this.middle_name,
      title: title ?? this.title,
      town: town ?? this.town,
      state_of_residence: state_of_residence ?? this.state_of_residence,
      lga: lga ?? this.lga,
      address: address ?? this.address,
      country_of_origin: country_of_origin ?? this.country_of_origin,
      tier: tier ?? this.tier,
      country_of_birth: country_of_birth ?? this.country_of_birth,
      state_of_origin: state_of_origin ?? this.state_of_origin,
      inst_code: inst_code ?? this.inst_code,
      enaira_bank_code: enaira_bank_code ?? this.enaira_bank_code,
      wallet_info: wallet_info ?? this.wallet_info,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'uid_type': uid_type,
      'phone': phone,
      'email_id': email_id,
      'first_name': first_name,
      'last_name': last_name,
      'middle_name': middle_name,
      'title': title,
      'town': town,
      'state_of_residence': state_of_residence,
      'lga': lga,
      'address': address,
      'country_of_origin': country_of_origin,
      'tier': tier,
      'country_of_birth': country_of_birth,
      'state_of_origin': state_of_origin,
      'inst_code': inst_code,
      'enaira_bank_code': enaira_bank_code,
      'wallet_info': wallet_info.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] as String,
      uid_type: map['uid_type'] as String,
      phone: map['phone'] as String,
      email_id: map['email_id'] as String,
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
      middle_name: map['middle_name'] as String,
      title: map['title'] as String,
      town: map['town'] as String,
      state_of_residence: map['state_of_residence'] as String,
      lga: map['lga'] as String,
      address: map['address'] as String,
      country_of_origin: map['country_of_origin'] as String,
      tier: map['tier'] as String,
      country_of_birth: map['country_of_birth'] as String,
      state_of_origin: map['state_of_origin'] as String,
      inst_code: map['inst_code'] as String,
      enaira_bank_code: map['enaira_bank_code'] as String,
      wallet_info:
          WalletInfo.fromMap(map['wallet_info'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(uid: $uid, uid_type: $uid_type, phone: $phone, email_id: $email_id, first_name: $first_name, last_name: $last_name, middle_name: $middle_name, title: $title, town: $town, state_of_residence: $state_of_residence, lga: $lga, address: $address, country_of_origin: $country_of_origin, tier: $tier, country_of_birth: $country_of_birth, state_of_origin: $state_of_origin, inst_code: $inst_code, enaira_bank_code: $enaira_bank_code, wallet_info: $wallet_info)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.uid_type == uid_type &&
        other.phone == phone &&
        other.email_id == email_id &&
        other.first_name == first_name &&
        other.last_name == last_name &&
        other.middle_name == middle_name &&
        other.title == title &&
        other.town == town &&
        other.state_of_residence == state_of_residence &&
        other.lga == lga &&
        other.address == address &&
        other.country_of_origin == country_of_origin &&
        other.tier == tier &&
        other.country_of_birth == country_of_birth &&
        other.state_of_origin == state_of_origin &&
        other.inst_code == inst_code &&
        other.enaira_bank_code == enaira_bank_code &&
        other.wallet_info == wallet_info;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        uid_type.hashCode ^
        phone.hashCode ^
        email_id.hashCode ^
        first_name.hashCode ^
        last_name.hashCode ^
        middle_name.hashCode ^
        title.hashCode ^
        town.hashCode ^
        state_of_residence.hashCode ^
        lga.hashCode ^
        address.hashCode ^
        country_of_origin.hashCode ^
        tier.hashCode ^
        country_of_birth.hashCode ^
        state_of_origin.hashCode ^
        inst_code.hashCode ^
        enaira_bank_code.hashCode ^
        wallet_info.hashCode;
  }
}

class WalletInfo {
  String tier;
  String nuban;
  String message;
  String wallet_alias;
  String wallet_address;
  WalletInfo({
    required this.tier,
    required this.nuban,
    required this.message,
    required this.wallet_alias,
    required this.wallet_address,
  });

  WalletInfo copyWith({
    String? tier,
    String? nuban,
    String? message,
    String? wallet_alias,
    String? wallet_address,
  }) {
    return WalletInfo(
      tier: tier ?? this.tier,
      nuban: nuban ?? this.nuban,
      message: message ?? this.message,
      wallet_alias: wallet_alias ?? this.wallet_alias,
      wallet_address: wallet_address ?? this.wallet_address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tier': tier,
      'nuban': nuban,
      'message': message,
      'wallet_alias': wallet_alias,
      'wallet_address': wallet_address,
    };
  }

  factory WalletInfo.fromMap(Map<String, dynamic> map) {
    return WalletInfo(
      tier: map['tier'] as String,
      nuban: map['nuban'] as String,
      message: map['message'] as String,
      wallet_alias: map['wallet_alias'] as String,
      wallet_address: map['wallet_address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletInfo.fromJson(String source) =>
      WalletInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WalletInfo(tier: $tier, nuban: $nuban, message: $message, wallet_alias: $wallet_alias, wallet_address: $wallet_address)';
  }

  @override
  bool operator ==(covariant WalletInfo other) {
    if (identical(this, other)) return true;

    return other.tier == tier &&
        other.nuban == nuban &&
        other.message == message &&
        other.wallet_alias == wallet_alias &&
        other.wallet_address == wallet_address;
  }

  @override
  int get hashCode {
    return tier.hashCode ^
        nuban.hashCode ^
        message.hashCode ^
        wallet_alias.hashCode ^
        wallet_address.hashCode;
  }
}
