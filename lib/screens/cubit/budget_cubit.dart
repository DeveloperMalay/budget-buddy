import 'package:bloc/bloc.dart';
import 'package:budgetbuddy/screens/cubit/budget_state.dart';
import 'package:budgetbuddy/models/budget_item.dart';

class BudgetCubit extends Cubit<BudgetState> {
  BudgetCubit()
      : super(const BudgetState(status: BudgetStatus.initial, items: []));

  void addSpending(double amount, String title) {
    try {
      final newSpending = BudgetItem(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        isBorrowed: false,
        date: DateTime.now(),
      );

      emit(state.copyWith(
        status: BudgetStatus.loaded,
        items: List.from(state.items)..add(newSpending),
      ));
    } catch (e) {
      emit(state.copyWith(status: BudgetStatus.error));
    }
  }

  void addBorrowedMoney(String person, double amount) {
    try {
      final newLoan = BudgetItem(
        id: DateTime.now().toString(),
        title: 'Loan to $person',
        amount: amount,
        isBorrowed: true,
        date: DateTime.now(),
      );

      emit(state.copyWith(
        status: BudgetStatus.loaded,
        items: List.from(state.items)..add(newLoan),
      ));
    } catch (e) {
      emit(state.copyWith(status: BudgetStatus.error));
    }
  }

  void markLoanAsPaid(String id) {
    try {
      final updatedItems = state.items.map((item) {
        if (item.id == id && item.isBorrowed) {
          return item;
        }
        return item;
      }).toList();

      emit(state.copyWith(
        status: BudgetStatus.loaded,
        items: updatedItems,
      ));
    } catch (e) {
      emit(state.copyWith(status: BudgetStatus.error));
    }
  }
}
