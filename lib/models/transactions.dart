// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Transaction {
  String sender;
  String receiver;
  String amount;
  DateTime time;
  String reason;
  Transaction({
    required this.sender,
    required this.receiver,
    required this.amount,
    required this.time,
    required this.reason,
  });

  Transaction copyWith({
    String? sender,
    String? receiver,
    String? amount,
    DateTime? time,
    String? reason,
  }) {
    return Transaction(
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      amount: amount ?? this.amount,
      time: time ?? this.time,
      reason: reason ?? this.reason,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender,
      'receiver': receiver,
      'amount': amount,
      'time': time.millisecondsSinceEpoch,
      'reason': reason,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      sender: map['sender'] as String,
      receiver: map['receiver'] as String,
      amount: map['amount'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      reason: map['reason'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(sender: $sender, receiver: $receiver, amount: $amount, time: $time, reason: $reason)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;

    return other.sender == sender &&
        other.receiver == receiver &&
        other.amount == amount &&
        other.time == time &&
        other.reason == reason;
  }

  @override
  int get hashCode {
    return sender.hashCode ^
        receiver.hashCode ^
        amount.hashCode ^
        time.hashCode ^
        reason.hashCode;
  }
}
