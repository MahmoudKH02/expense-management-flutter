import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expenses_management/ui/manage_expenses/viewmodels/expenses_list_view_model.dart';

import 'package:expenses_management/data/models/expense.dart';

class ExpenseFormView extends StatefulWidget {
  const ExpenseFormView({super.key, this.intialData});

  final Expense? intialData;

  @override
  State<ExpenseFormView> createState() => _ExpenseFormViewState();
}

class _ExpenseFormViewState extends State<ExpenseFormView> {
  final _formKey = GlobalKey<FormState>();
  String? _enteredTitle;
  double? _enteredAmount;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _enteredTitle = widget.intialData?.title;
    _enteredAmount = widget.intialData?.amount;
    _selectedDate = widget.intialData?.dueDate;
  }

  String? _validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a title';
    }
    if (value.length > 50) {
      return 'Title cannot be longer than 50 characters';
    }
    return null;
  }

  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an amount';
    }
    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Please enter a valid number';
    }
    if (amount <= 0) {
      return 'Amount must be greater than zero';
    }
    return null;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final expensesViewModel = ProviderScope.containerOf(context)
          .read(expensesListViewModelProvider.notifier);

      // add new or edit widget
      if (widget.intialData == null) {
        await expensesViewModel.addNewItem(
            _enteredTitle!, _enteredAmount!, _selectedDate!);
      } else {
        await expensesViewModel.editItem(widget.intialData!.copyWith(
          title: _enteredTitle,
          amount: _enteredAmount,
          dueDate: _selectedDate,
        ));
      }

      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  void _showDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.intialData != null
            ? const Text('Edit Expense')
            : const Text('Add New Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
                initialValue: _enteredTitle,
                validator: _validateTitle,
                onSaved: (newValue) => _enteredTitle = newValue,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Amount'),
                ),
                keyboardType: TextInputType.number,
                initialValue: _enteredAmount?.toString(),
                validator: _validateAmount,
                onSaved: (newValue) => _enteredAmount = double.parse(newValue!),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Flexible(
                    child: InputDatePickerFormField(
                      firstDate: DateTime(DateTime.now().year),
                      lastDate: DateTime(DateTime.now().year + 1),
                      initialDate: _selectedDate,
                      onDateSubmitted: (date) {
                        _selectedDate = date;
                      },
                      onDateSaved: (date) {
                        _selectedDate = date;
                      },
                    ),
                  ),
                  Flexible(
                    child: IconButton(
                      onPressed: _showDatePicker,
                      icon: const Icon(Icons.date_range),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final expenseListState =
                          ref.watch(expensesListViewModelProvider);
                      return ElevatedButton(
                        onPressed: _submitForm,
                        child: expenseListState.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Submit'),
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
