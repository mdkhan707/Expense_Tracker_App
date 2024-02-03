import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

var KColor = ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 96, 59, 181));

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: KColor,
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: KColor.onPrimaryContainer,
            foregroundColor: KColor.primaryContainer,
          ),
          cardTheme: CardTheme().copyWith(
              color: KColor.secondaryContainer,
              margin: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              )),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: KColor.primaryContainer),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                  titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: KColor.onSecondaryContainer,
                fontSize: 24,
              ))),
      home: const Expenses()));
}
