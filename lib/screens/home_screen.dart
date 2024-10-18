// lib/screens/home_screen.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_borrower_screen.dart';
import 'add_spending_screen.dart';
import 'chart_screen.dart';
import 'cubit/budget_cubit.dart';
import 'cubit/budget_state.dart';
import 'spend_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BudgetBuddy'),
      ),
      body: BlocConsumer<BudgetCubit, BudgetState>(
        listener: (context, state) {
          log('list ${state.items}');
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SpendListScreen()),
                    );
                  },
                  child: const Text('Spending'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddSpendingScreen()),
                    );
                  },
                  child: const Text('Add Spending'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddBorrowedScreen()),
                    );
                  },
                  child: const Text('Add Borrowed Money'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChartScreen()),
                    );
                  },
                  child: const Text('View Charts'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
