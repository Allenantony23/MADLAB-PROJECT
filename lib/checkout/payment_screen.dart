import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../../utils/constants.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethod? _selectedPaymentMethod;

  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod.upi,
    PaymentMethod.creditCard,
    PaymentMethod.debitCard,
    PaymentMethod.netBanking,
    PaymentMethod.cashOnDelivery,
    PaymentMethod.wallet,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Payment Method'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _paymentMethods.length,
        itemBuilder: (context, index) {
          return PaymentMethodCard(
            paymentMethod: _paymentMethods[index],
            isSelected: _selectedPaymentMethod == _paymentMethods[index],
            onSelect: () {
              setState(() {
                _selectedPaymentMethod = _paymentMethods[index];
              });
            },
          );
        },
      ),
      
      // Confirm Button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: _selectedPaymentMethod != null ? _confirmPayment : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Confirm Payment Method',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _confirmPayment() {
    Navigator.pop(context, _selectedPaymentMethod);
  }
}

class PaymentMethodCard extends StatelessWidget {
  final PaymentMethod paymentMethod;
  final bool isSelected;
  final VoidCallback onSelect;

  const PaymentMethodCard({
    super.key,
    required this.paymentMethod,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        color: isSelected ? AppConstants.primaryColor.withOpacity(0.1) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected ? AppConstants.primaryColor : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isSelected ? AppConstants.primaryColor : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                paymentMethod.icon,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          title: Text(
            paymentMethod.displayName,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isSelected ? AppConstants.primaryColor : null,
            ),
          ),
          trailing: isSelected
              ? Icon(
                  Icons.check_circle_rounded,
                  color: AppConstants.primaryColor,
                )
              : null,
          onTap: onSelect,
        ),
      ),
    );
  }
}