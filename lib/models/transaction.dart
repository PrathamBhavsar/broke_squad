class Transaction {
  final String category;
  final List<String> contributors;
  final DateTime dateTime;
  final double amount;
  final List<String> unpaidParticipants;
  final String groupName;

  Transaction({
    required this.category,
    required this.contributors,
    required this.dateTime,
    required this.amount,
    required this.unpaidParticipants,
    required this.groupName,
  });
}
