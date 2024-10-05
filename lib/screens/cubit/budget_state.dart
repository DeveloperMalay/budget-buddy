import 'package:equatable/equatable.dart';

import 'package:budgetbuddy/models/budget_item.dart';

enum BudgetStatus { initial, loading, loaded, error }

class BudgetState extends Equatable {
  final BudgetStatus status;
  final List<BudgetItem> items;

  const BudgetState({required this.status, required this.items});

  @override
  List<Object?> get props => [items, status];

  BudgetState copyWith({
    BudgetStatus? status,
    List<BudgetItem>? items,
  }) {
    return BudgetState(
      status: status ?? this.status,
      items: items ?? this.items,
    );
  }
}
