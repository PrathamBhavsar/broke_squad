import 'package:contri_buter/models/transaction.dart';

List<Transaction> demoTransactions = [
  Transaction(
    category: 'Groceries',
    contributors: ['Alice', 'Bob'],
    dateTime: DateTime.now(),
    amount: 150.0,
    unpaidParticipants: ['Charlie', 'David'],
    groupName: 'first',
  ),
  Transaction(
    category: 'Dinner',
    contributors: ['Eve', 'Frank'],
    dateTime: DateTime.now().subtract(Duration(days: 100)),
    amount: 80.0,
    unpaidParticipants: ['George'],
    groupName: 'second',
  ),
  Transaction(
    category: 'Lunch',
    contributors: ['Eve'],
    dateTime: DateTime.now().subtract(Duration(days: 12)),
    amount: 410.0,
    unpaidParticipants: ['Frank'],
    groupName: 'test',
  ),
  Transaction(
    category: 'Bike',
    contributors: ['Eve'],
    dateTime: DateTime.now().subtract(Duration(days: 11)),
    amount: 8000.0,
    unpaidParticipants: ['George'],
    groupName: 'bike',
  ),
  Transaction(
    category: 'Bike',
    contributors: ['Eve'],
    dateTime: DateTime.now().subtract(Duration(days: 11)),
    amount: 8000.0,
    unpaidParticipants: ['George'],
    groupName: '2',
  ),
  Transaction(
    category: 'Bike',
    contributors: ['Eve'],
    dateTime: DateTime.now().subtract(Duration(days: 11)),
    amount: 8000.0,
    unpaidParticipants: ['George'],
    groupName: 'lksdjahflkjasdhfljah',
  ),
];
