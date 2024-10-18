import 'package:budgetbuddy/screens/cubit/budget_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/budget_state.dart';

class SpendListScreen extends StatelessWidget {
  const SpendListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spend List'),
      ),
      body: BlocConsumer<BudgetCubit, BudgetState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Text(state.items[index].title);
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: state.items.length,
              )
            ],
          );
        },
      ),
    );
  }
}
