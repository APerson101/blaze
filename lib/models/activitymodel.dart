import 'dart:convert';

class RecentActivityModel {
  String type;
  double amount;
  String name;
  DateTime date;
  RecentActivityModel({
    required this.type,
    required this.amount,
    required this.name,
    required this.date,
  });

  RecentActivityModel copyWith({
    String? type,
    double? amount,
    String? name,
    DateTime? date,
  }) {
    return RecentActivityModel(
      type: type ?? this.type,
      amount: amount ?? this.amount,
      name: name ?? this.name,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'amount': amount,
      'name': name,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory RecentActivityModel.fromMap(Map<String, dynamic> map) {
    return RecentActivityModel(
      type: map['type'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
      name: map['name'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RecentActivityModel.fromJson(String source) =>
      RecentActivityModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RecentActivityModel(type: $type, amount: $amount, name: $name, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecentActivityModel &&
        other.type == type &&
        other.amount == amount &&
        other.name == name &&
        other.date == date;
  }

  @override
  int get hashCode {
    return type.hashCode ^ amount.hashCode ^ name.hashCode ^ date.hashCode;
  }
}
