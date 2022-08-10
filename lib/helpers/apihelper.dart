import 'dart:convert';

import 'package:blaze/models/accountingmodel.dart';
import 'package:blaze/models/transactions.dart';
import 'package:blaze/models/user.dart';
import 'package:blaze/views/homepage/homepageview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class APiHelper {
  String baseclass = "http://rgw.k8s.apis.ng/centric-platforms/uat";
  Dio dio = Dio();
  TwilioFlutter twilioFlutter = TwilioFlutter(
      accountSid: 'AC7ce98dde173c29860bfcd2af863e1d27',
      authToken: '6e59246e5051630ad9450663a27401d6',
      twilioNumber: '+12183924403');
  String successMessage = "Successful Request";
  Map<String, String> header = {
    'content-type': "application/json",
    'ClientId': 'ad1e0f4acd0eff062d8e7d523338f631',
    'accept': 'application/json'
  };
  Options options = Options(headers: {
    'content-type': "application/json",
    'ClientId': 'ad1e0f4acd0eff062d8e7d523338f631',
    'accept': 'application/json'
  });
  createUserAcccount(newUser) async {
    var url = '$baseclass/enaira-user/CreateConsumerV2';
    // var response = await http.post(Uri.parse(url),
    //     headers: {
    //       'Content-Type': "application/json",
    //       'ClientId': 'ad1e0f4acd0eff062d8e7d523338f631',
    //       'accept': 'application/json'
    //     },
    //     body: jsonEncode(newUser));
    var response = await dio.post(url, data: newUser, options: options);
    print(response.data);
    // var data = jsonDecode(response.body)['response_message' == successMessage]
    //     ? jsonDecode(response.body)["response_data"]
    //     : null;
    // print(data);
    return null;
  }

  getUserByPhone(String number) async {
    var url = '$baseclass/enaira-user/GetUserDetailsByPhone';
    var response = await dio.post(url,
        data: {
          "phone_number": number,
          "user_type": "USER",
          "channel_code": "APISNG"
        },
        options: options);
    print(response.data);
    var responseData = response.data['response_message'] == 'Successful Request'
        ? response.data["response_data"]
        : response.data['response_code'] == 99
            ? -1
            : null;
    return responseData;
  }

  getUSerByAlias(String alias) async {
    var url = '$baseclass/enaira-user/GetUserDetailsByWalletAlias';
    var response = await dio.post(url,
        data: {
          "wallet_alias": alias,
          "user_type": "USER",
          "channel_code": "APISNG"
        },
        options: options);
    print(response.data);
    var responseData = response.data['response_message'] == 'Successful Request'
        ? response.data["response_data"]
        : response.data['response_code'] == 99
            ? -1
            : null;
    return responseData;
  }

  userLogin(String username, String password) async {
    var url = '$baseclass/CAMLLogin';

    if (username == "test@user1") {
      return User(
          uid: '45344',
          uid_type: 'NIN',
          phone: '+2348159730537',
          email_id: 'testuser@gmail.com',
          first_name: 'Test User 1',
          last_name: "Some Guy",
          middle_name: 'Jagaban',
          title: 'MR.',
          town: 'Wuse',
          state_of_residence: 'FCT',
          lga: 'AMAC',
          address: 'Zone 7, Abuja',
          country_of_origin: 'NG',
          tier: '2',
          country_of_birth: 'NG',
          state_of_origin: 'Kogi',
          inst_code: '234',
          enaira_bank_code: 'access',
          wallet_info: WalletInfo(
              tier: '2',
              nuban: 'nuban',
              message: 'message',
              wallet_alias: 'test@user1',
              wallet_address: '567890-765hgbnmjk'));
    }

    if (username == "test@user2") {
      return User(
          uid: '45344',
          uid_type: 'NIN',
          phone: '+2349050731828',
          email_id: 'testuser2@gmail.com',
          first_name: 'Test User 2',
          last_name: "Lo kan",
          middle_name: 'Emi',
          title: 'MR.',
          town: 'Wuse',
          state_of_residence: 'FCT',
          lga: 'AMAC',
          address: 'Zone 7, Abuja',
          country_of_origin: 'NG',
          tier: '2',
          country_of_birth: 'NG',
          state_of_origin: 'Kogi',
          inst_code: '234',
          enaira_bank_code: 'access',
          wallet_info: WalletInfo(
              tier: '2',
              nuban: 'nuban',
              message: 'message',
              wallet_alias: 'test@user2',
              wallet_address: '567890-765hgbnmjk'));
    }
    if (kIsWeb) {
      var response = await http.post(Uri.parse(url),
          headers: {
            'content-type': "application/json",
            'ClientId': 'ad1e0f4acd0eff062d8e7d523338f631',
            'accept': 'application/json'
          },
          body: jsonEncode({
            'user_id': username,
            'password': password,
            'allow_tokenization': 'Y',
            'user_type': 'USER',
            'channel_code': 'APISNG'
          }));
      // var response = await dio.post(url,
      //     data: {
      //       'user_id': username,
      //       'password': password,
      //       'allow_tokenization': 'Y',
      //       'user_type': 'USER',
      //       'channel_code': 'APISNG'
      //     },
      //     options: options);`
      print(response.body);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      }
      if (response.statusCode == 401) {
        return -1;
      }
    } else
      return 'simulate';
  }

  getAccountsBalance(String email, String username, String password) async {
    // var tokenBox = Hive.box('token');
    // tokenBox.get('token');

    // var preferences = await SharedPreferences.getInstance();
    // String? token = preferences.getString('token');
    // if (token != null) {
    // await _balancePost(email);
    // } else {

    if (username == "test@user1") {
      return List.generate(
          1,
          (index) => AccountingModel(
              accountBranch: 'Wuse',
              accountNumber: '1234556677',
              accountType: 'eNaira',
              availableBalance: '300000',
              currency: 'Naira',
              currencyCode: 'NGN',
              customerNumber: '+2348159730537',
              localEquivalentAvailableBalance: '300000'));
    }

    if (username == 'test@user2') {
      return List.generate(
          1,
          (index) => AccountingModel(
              accountBranch: 'Wuse',
              accountNumber: '1234556677',
              accountType: 'eNaira',
              availableBalance: '100000',
              currency: 'Naira',
              currencyCode: 'NGN',
              customerNumber: '+2349050731828',
              localEquivalentAvailableBalance: '300000'));
    }

    var response = await userLogin(username, password);
    var token = response['user_token'];
    // await preferences.setString('token', token as String);
    var balanceresponse = await _balancePost(email, token);
    List<AccountingModel> lists = [];
    var accLists = balanceresponse['data']['accountsList'] as List;

    for (var acc in accLists) {
      lists.add(AccountingModel.fromJson(acc));
    }
    return lists;
  }

  _balancePost(String email, String token) async {
    var url = '$baseclass/GetBalance';

    var response = await dio.post(url, options: options, data: {
      'user_email': email,
      'user_type': "USER",
      'user_token': token,
      "channel_code": "APISNG"
    });
    return jsonDecode(response.data);
  }

  sendFunds(String username, String password, String email, String amount,
      String receiver) async {
    var response = await userLogin(username, password);
    var token = response['user_token'];
    String url = '$baseclass/PaymentFromWallet';
    var responseData = await dio.post(url,
        data: {
          'user_token': token,
          'user_email': email,
          'destination_wallet_alias': receiver,
          'amount': amount,
          'user_type': 'USER',
          'reference': 'NXG${const Uuid().v4().substring(0, 8)}',
          'channel_code': "APISNG"
        },
        options: options);
    return responseData.data;
  }

  getCard({required String alias}) async {
    //
    if (alias == "test@user1") {
      return CardInfo(
          cardNumber: '1234 5678 9123',
          expiriyDate: '12/23',
          cvv: '233',
          cardName: 'Test User 1',
          balance: '300000');
    }
    return CardInfo(
        cardNumber: '1234 5678 9123',
        expiriyDate: '12/23',
        cvv: '233',
        cardName: 'Test User 2',
        balance: '100000');
  }

  getTransactions({required String alias}) async {
    // get user's most recent transactions
    List<Transaction> all = [];
    for (var i = 0; i < 5; i++) {
      all.add(Transaction(
          sender: alias,
          receiver: 'receiver',
          amount: '10000',
          time: DateTime.now(),
          reason: 'do stuff with it'));
    }
    return all;
  }

  sendOTP(String number) async {
    int code = await twilioFlutter.sendSMS(
        toNumber: '+2348159730537',
        messageBody: 'Use the code $number  for verification');
    if (code == 201) return true;
    return false;
  }

  sendMoneyToNumber(
      {required String receiver,
      required String amount,
      required String senderName}) async {
    int code = await twilioFlutter.sendSMS(
        toNumber: receiver,
        messageBody:
            '$senderName sent you $amount, download blaze app to receive your funds');
    if (code == 201) return true;
    return false;
  }
}
