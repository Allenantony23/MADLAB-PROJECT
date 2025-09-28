import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../../utils/constants.dart';
import 'address_screen.dart';
import 'payment_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final double totalAmount;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.totalAmount,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Address? _selectedAddress;
  PaymentMethod? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address
            _buildSection(
              title: 'Delivery Address',
              child: _selectedAddress == null
                  ? _buildAddAddressButton()
                  : _buildAddressCard(),
            ),

            const SizedBox(height: 24),

            // Order Summary
            _buildSection(
              title: 'Order Summary',
              child: Column(
                children: [
                  ...widget.cartItems.map((item) => _buildOrderItem(item)),
                  const SizedBox(height: 16),
                  _buildPriceSummary(),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Payment Method
            _buildSection(
              title: 'Payment Method',
              child: _selectedPaymentMethod == null
                  ? _buildSelectPaymentButton()
                  : _buildPaymentMethodCard(),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
      
      // Place Order Button
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
          onPressed: _canPlaceOrder() ? _placeOrder : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Place Order • ₹${widget.totalAmount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: AppConstants.fontFamily,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildAddAddressButton() {
    return GestureDetector(
      onTap: _selectAddress,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          children: [
            Icon(Icons.add_rounded, color: AppConstants.primaryColor),
            SizedBox(width: 12),
            Text(
              'Add Delivery Address',
              style: TextStyle(
                fontSize: 16,
                color: AppConstants.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard() {
    return GestureDetector(
      onTap: _selectAddress,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppConstants.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _selectedAddress!.type,
                    style: const TextStyle(
                      color: AppConstants.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (_selectedAddress!.isDefault) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Default',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _selectedAddress!.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _selectedAddress!.fullAddress,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Phone: ${_selectedAddress!.phone}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(CartItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: NetworkImage('https://via.placeholder.com/300'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Qty: ${item.quantity}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            '₹${(item.product.price * item.quantity).toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSummary() {
    final double subtotal = widget.cartItems.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
    final double discount = widget.cartItems.fold(0, (sum, item) => sum + ((item.product.originalPrice - item.product.price) * item.quantity));
    final double delivery = subtotal > 499 ? 0 : 40;
    final double gst = subtotal * 0.18;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildSummaryRow('Subtotal', subtotal),
          _buildSummaryRow('Discount', -discount, isDiscount: true),
          _buildSummaryRow('Delivery', delivery),
          _buildSummaryRow('GST', gst),
          const Divider(height: 16),
          _buildSummaryRow('Total', widget.totalAmount, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isDiscount = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey[600],
            ),
          ),
          Text(
            '${amount >= 0 ? '₹' : '-₹'}${amount.abs().toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal
                  ? AppConstants.primaryColor
                  : isDiscount
                      ? AppConstants.successColor
                      : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectPaymentButton() {
    return GestureDetector(
      onTap: _selectPaymentMethod,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          children: [
            Icon(Icons.payment_rounded, color: AppConstants.primaryColor),
            SizedBox(width: 12),
            Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 16,
                color: AppConstants.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodCard() {
    return GestureDetector(
      onTap: _selectPaymentMethod,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              _selectedPaymentMethod!.icon,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _selectedPaymentMethod!.displayName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16),
          ],
        ),
      ),
    );
  }

  bool _canPlaceOrder() {
    return _selectedAddress != null && _selectedPaymentMethod != null;
  }

  void _selectAddress() async {
    final address = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddressScreen()),
    );
    
    if (address != null) {
      setState(() {
        _selectedAddress = address;
      });
    }
  }

  void _selectPaymentMethod() async {
    final paymentMethod = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PaymentScreen()),
    );
    
    if (paymentMethod != null) {
      setState(() {
        _selectedPaymentMethod = paymentMethod;
      });
    }
  }

  void _placeOrder() {
    // Create order and navigate to order confirmation
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      orderDate: DateTime.now(),
      items: widget.cartItems.map((item) => OrderItem(
        productId: item.product.id,
        productName: item.product.name,
        productImage: item.product.images.first,
        price: item.product.price,
        quantity: item.quantity,
        discount: item.product.discount,
      )).toList(),
      totalAmount: widget.totalAmount,
      discount: widget.cartItems.fold(0, (sum, item) => sum + ((item.product.originalPrice - item.product.price) * item.quantity)),
      deliveryCharge: widget.totalAmount > 499 ? 0 : 40,
      gst: widget.totalAmount * 0.18,
      finalAmount: widget.totalAmount,
      status: OrderStatus.ordered,
      shippingAddress: _selectedAddress!,
      paymentMethod: _selectedPaymentMethod!,
      expectedDelivery: DateTime.now().add(const Duration(days: 3)),
    );

    // Show success dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => OrderSuccessDialog(order: order),
    );
  }
}

class OrderSuccessDialog extends StatelessWidget {
  final Order order;

  const OrderSuccessDialog({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppConstants.successColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_rounded,
                size: 40,
                color: AppConstants.successColor,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Success Message
            const Text(
              'Order Placed Successfully!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: AppConstants.fontFamily,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'Your order ID: ${order.id}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Expected Delivery
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_shipping_rounded, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Expected delivery: ${order.expectedDelivery!.day}/${order.expectedDelivery!.month}/${order.expectedDelivery!.year}',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: const Text('Continue Shopping'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to order details
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('View Order'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}