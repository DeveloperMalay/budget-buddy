import 'package:budgetbuddy/screens/cubit/budget_state.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/budget_cubit.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spending Overview'),
      ),
      body: BlocBuilder<BudgetCubit, BudgetState>(
        builder: (context, state) {
          if (state.status == BudgetStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == BudgetStatus.error) {
            return const Center(child: Text('Failed to load data'));
          }

          // Filter only spending items
          final spendingItems =
              state.items.where((item) => !item.isBorrowed).toList();

          // Create a category-wise spending map
          final Map<String, double> categoryMap = {};
          for (var item in spendingItems) {
            categoryMap[item.title] =
                (categoryMap[item.title] ?? 0) + item.amount;
          }

          final categories = categoryMap.keys.toList();
          final data = categoryMap.values.toList();

          if (categories.isEmpty) {
            return const Center(child: Text('No spending data available'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: PieChart(
              PieChartData(
                sections: List.generate(categories.length, (index) {
                  return PieChartSectionData(
                    value: data[index],
                    title: categories[index],
                    titleStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    color: Colors.primaries[index % Colors.primaries.length],
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
