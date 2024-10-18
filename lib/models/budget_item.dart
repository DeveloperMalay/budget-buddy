class BudgetItem {
  final String id;
  final String title;
  final double amount;
  final bool isBorrowed;
  final DateTime date;

  BudgetItem({
    required this.id,
    required this.title,
    required this.amount,
    required this.isBorrowed,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'isBorrowed': isBorrowed ? 1 : 0,
      'date': date.toIso8601String(),
    };
  }

  factory BudgetItem.fromMap(Map<String, dynamic> map) {
    return BudgetItem(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      isBorrowed: map['isBorrowed'] == 1,
      date: DateTime.parse(map['date']),
    );
  }
}
