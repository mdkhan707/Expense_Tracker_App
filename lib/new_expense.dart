import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/new_expense.dart';
import 'package:flutter/rendering.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({
    super.key,
    required this.onAddExpense,
  });

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // var entertitle = '';
  // void savetilteinput(String Inputvalue) {
  //   entertitle = Inputvalue;
  // }
  final titlecontroller = TextEditingController();
  final textcontroller = TextEditingController();
  DateTime? selectedDate;
  Category selectcategory = Category.leisure;

  void Datepicker() async {
    final now = DateTime.now();
    final Firstdate = DateTime(now.year - 1, now.month, now.day);
    final Pickeddate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: Firstdate,
        lastDate: now);

    setState(() {
      selectedDate = Pickeddate;
    });
  }

  void SubmitExpenseData() {
    final enteredData = double.tryParse(textcontroller.text);
    final AMountIsInvalid = enteredData == null || enteredData <= 0;
    if (titlecontroller.text.trim().isEmpty ||
        AMountIsInvalid ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: ((ctx) => AlertDialog(
              title: const Text('Invalid Input'),
              content: Text(
                  'Please make sure that a valid amount ,date and category was erntered'),
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.pop(ctx);
                    }),
                    child: Text('Okay'))
              ],
            )),
      );
      return;
    }
    widget.onAddExpense(Expense(
        titile: titlecontroller.text,
        amount: enteredData,
        date: selectedDate!,
        category: selectcategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titlecontroller.dispose();
    textcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Keyboardspace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, Constraints) {
      final width = Constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, Keyboardspace + 16),
            child: Column(children: [
              if (width >= 600)
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: titlecontroller,
                        maxLength: 50,
                        decoration: const InputDecoration(label: Text('Title')),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: TextField(
                        controller: textcontroller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            prefixText: '\$', label: Text('Amount')),
                      ),
                    ),
                  ],
                )
              else
                TextField(
                  controller: titlecontroller,
                  maxLength: 50,
                  decoration: const InputDecoration(label: Text('Title')),
                ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textcontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          prefixText: '\$', label: Text('Amount')),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(selectedDate == null
                          ? 'No date selected'
                          : formatter.format(selectedDate!)),
                      IconButton(
                          onPressed: (Datepicker),
                          icon: Icon(Icons.calendar_month))
                    ],
                  )),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  DropdownButton(
                      value: selectcategory,
                      items: Category.values
                          .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase())))
                          .toList(),
                      onChanged: ((value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          selectcategory = value;
                        });
                      })),
                  const Spacer(),
                  TextButton(
                      onPressed: (() {
                        Navigator.pop(context);
                      }),
                      child: Text('Cancel')),
                  ElevatedButton(
                      onPressed: SubmitExpenseData,
                      child: Text('Save Expense')),
                ],
              )
            ]),
          ),
        ),
      );
    });
  }
}
