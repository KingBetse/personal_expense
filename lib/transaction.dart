class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime time;
  Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.time});
}
