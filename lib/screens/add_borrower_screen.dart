// lib/screens/add_borrowed_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/budget_cubit.dart';

class AddBorrowedScreen extends StatefulWidget {
  const AddBorrowedScreen({super.key});

  @override
  State<AddBorrowedScreen> createState() => _AddBorrowedScreenState();
}

class _AddBorrowedScreenState extends State<AddBorrowedScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _personController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _returnDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Borrowed Money'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _personController,
                decoration: const InputDecoration(labelText: 'Person Name'),
              ),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: _returnDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  ).then((date) {
                    if (date != null) setState(() => _returnDate = date);
                  });
                },
                child: const Text('Pick Return Date'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final person = _personController.text;
                    final amount = double.tryParse(_amountController.text) ?? 0;

                    context
                        .read<BudgetCubit>()
                        .addBorrowedMoney(person, amount);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Borrowed Money'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
