import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/constant/color.dart';
import 'package:zeus/features/dashboard%20as%20features/transactions/transactions_controller.dart';

class TransactionsHistoryScreen extends StatefulWidget {
  final String cardId;
  final PageController pageController;

  const TransactionsHistoryScreen({
    super.key,
    required this.cardId,
    required this.pageController,
  });

  @override
  State<TransactionsHistoryScreen> createState() =>
      _TransactionsHistoryScreenState();
}

class _TransactionsHistoryScreenState extends State<TransactionsHistoryScreen> {
  final TransactionsController controller = Get.find<TransactionsController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ("aaaaaaaaaaaaaaasssssssssssssssssssssssssssssaaaaaaa: ${DateTime.now()}");
    _scrollController.addListener(_onScroll);
    _loadTransactions(); // Call _loadTransactions here
  }

  @override
  void didUpdateWidget(TransactionsHistoryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.cardId != oldWidget.cardId) {
      _loadTransactions(); // Call _loadTransactions here
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      controller.loadMoreTransactions();
    }
  }

  Future<void> _loadTransactions() async {
    await controller.loadTransactionsForCard(widget.cardId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.more_time_sharp, size: 18),
                SizedBox(width: 10.w),
                Text(
                  'Transactions History',
                  style: AppTextStyle.montserratSimiBold14Black
                      .copyWith(color: Colors.black87, fontSize: 14),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<void>(
              future: _loadTransactions(), // Trigger the async operation
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.white,
                      backgroundColor: AppColor.primaryColor,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  final transactions =
                      controller.cardTransactions[widget.cardId] ??
                          <dynamic>[].obs;

                  if (transactions.isEmpty) {
                    return const Center(
                      child: Text('No transactions found.'),
                    );
                  } else {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = transactions[index];
                        return GestureDetector(
                          onTap: () =>
                              showTransactionDetails(context, transaction),
                          child: buildTransactionItem(transaction),
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: AppTextStyle.montserratSimiBold14Black.copyWith(
                  fontWeight: AppFontWeight.bold,
                  fontSize: 13.5,
                  color: AppColor.primaryColor)),
          Text(value,
              style: AppTextStyle.montserratSimiBold14Black
                  .copyWith(fontWeight: FontWeight.w300, fontSize: 13.5)),
        ],
      ),
    );
  }

  String _getTransactionStatus(int accepted) {
    switch (accepted) {
      case 3:
        return 'Declined';
      case 2:
        return 'Completed';
      case 1:
        return 'Pending';
      default:
        return 'Submitted';
    }
  }

  void showTransactionDetails(BuildContext context, dynamic transaction) {
    String type = transaction['source'];
    String status = _getTransactionStatus(transaction['accepted']);
    String date = DateFormat('dd-MM-yyyy hh:mm a')
        .format(DateTime.parse(transaction['created_at_tz']));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'Transaction Details',
              style:
                  AppTextStyle.montserratSimiBold14Black.copyWith(fontSize: 18),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(
                    'Transaction ID:', transaction['id'].toString()),
                _buildDetailRow(
                  // تحقق من نوع `type`
                  type.contains(RegExp(r'[0-9]'))
                      ? 'Reciever Card Code: ' // إذا كان `type`  يحتوي على أرقام، اعرض Reciever
                      : 'Classification:', // وإلا اعرض Classification
                  type,
                ),
                _buildDetailRow('Type:',
                    transaction['transaction_type'] ?? 'ZEUS Transfer'),
                _buildDetailRow('Date:', date),
                _buildDetailRow('Amount:',
                    '\$${transaction['price']} ${transaction['currency'] ?? "USD"}'),
                _buildDetailRow('Sender Card Code:', transaction['card_id']),
                _buildDetailRow('Status:', status),
                if (transaction['benif'] != null)
                  _buildDetailRow('Beneficiary:', transaction['benif']),
                if (transaction['notes'] != null)
                  _buildDetailRow('Notes:', transaction['notes']),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget buildTransactionItem(dynamic transaction) {
    String amount = transaction['price'].toString();
    String currency = transaction['currency'] ?? "USD";
    String type = transaction['source'];
    String status = controller.getTransactionStatus(transaction['accepted']);
    String date = DateFormat('dd-MM-yyyy')
        .format(DateTime.parse(transaction['created_at_tz']));

    Color amountColor = controller.getAmountColor(type);

    // Use the correct transaction type based on 'source'
    String transactionType = type;
    if (type == 'Deposit' || type == 'Withdraw') {
      transactionType = type;
    } else if (type == "Card Transaction") {
      transactionType = 'Card Trans.';
    } else {
      transactionType = 'Transfer'; // Default to 'Transfer'
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
              decoration: BoxDecoration(
                color: amountColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '\$$amount $currency',
                  style: AppTextStyle.montserratSimiBold14Black
                      .copyWith(fontSize: 12, color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Text(
              transactionType, // Display the correct type
              style: AppTextStyle.montserratSimiBold14Black
                  .copyWith(fontSize: 12, color: Colors.black),
            ),
          ),
          Expanded(
            child: Text(
              status,
              style: AppTextStyle.montserratSimiBold14Black
                  .copyWith(fontSize: 11, color: Colors.black),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              date,
              style: AppTextStyle.montserratSimiBold14Black
                  .copyWith(fontSize: 10, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
