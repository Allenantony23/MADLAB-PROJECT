import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../utils/constants.dart';
import '../checkout/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItem> _cartItems = [
    CartItem(
      product: Product(
        id: '1',
        name: 'Samsung Galaxy S23',
        description: 'Latest Samsung flagship phone',
        price: 74999,
        originalPrice: 84999,
        discount: 12,
        rating: 4.5,
        reviewCount: 1247,
        images: ['https://via.placeholder.com/300'],
        category: 'Mobiles',
        tags: ['5G', '128GB'],
        isBestSeller: true,
      ),
      quantity: 1,
    ),
    CartItem(
      product: Product(
        id: '2',
        name: 'Nike Air Max',
        description: 'Comfortable running shoes',
        price: 4599,
        originalPrice: 5999,
        discount: 23,
        rating: 4.3,
        reviewCount: 892,
        images: ['https://via.placeholder.com/300'],
        category: 'Fashion',
        tags: ['Sports', 'Running'],
        isBestSeller: true,
      ),
      quantity: 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double subtotal = _cartItems.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
    final double discount = _cartItems.fold(0, (sum, item) => sum + ((item.product.originalPrice - item.product.price) * item.quantity));
    final double delivery = subtotal > 499 ? 0 : 40;
    final double gst = subtotal * 0.18;
    final double total = subtotal + delivery + gst;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: _clearCart,
          ),
        ],
      ),
      body: Column(
        children: [
          // Cart Items List
          Expanded(
            child: _cartItems.isEmpty
                ? _buildEmptyCart()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      return CartItemCard(
                        item: _cartItems[index],
                        onQuantityChanged: (quantity) {
                          setState(() {
                            _cartItems[index].quantity = quantity;
                            if (quantity == 0) {
                              _cartItems.removeAt(index);
                            }
                          });
                        },
                        onRemove: () {
                          setState(() {
                            _cartItems.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
          ),

          // Price Summary
          if (_cartItems.isNotEmpty) _buildPriceSummary(subtotal, discount, delivery, gst, total),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          const Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: AppConstants.fontFamily,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add some items to get started',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text('Start Shopping'),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSummary(double subtotal, double discount, double delivery, double gst, double total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          // Price Breakdown
          _buildPriceRow('Subtotal', '₹${subtotal.toStringAsFixed(2)}'),
          _buildPriceRow('Discount', '-₹${discount.toStringAsFixed(2)}', isDiscount: true),
          _buildPriceRow('Delivery', delivery == 0 ? 'FREE' : '₹${delivery.toStringAsFixed(2)}'),
          _buildPriceRow('GST (18%)', '₹${gst.toStringAsFixed(2)}'),
          
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          
          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Amount',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppConstants.fontFamily,
                ),
              ),
              Text(
                '₹${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.primaryColor,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Checkout Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutScreen(
                      cartItems: _cartItems,
                      totalAmount: total,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Proceed to Checkout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDiscount ? AppConstants.successColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _clearCart() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text('Are you sure you want to remove all items from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _cartItems.clear();
              });
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: AppConstants.errorColor,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  double get totalPrice => product.price * quantity;
}

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final Function(int) onQuantityChanged;
  final Function() onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 80,
            height: 80,
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
          
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppConstants.fontFamily,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 4),
                
                Text(
                  item.product.formattedPrice,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.primaryColor,
                  ),
                ),
                
                if (item.product.discount > 0)
                  Text(
                    '₹${item.product.originalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
          ),
          
          // Quantity and Remove
          Column(
            children: [
              // Quantity Selector
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_rounded, size: 18),
                      onPressed: item.quantity > 1
                          ? () => onQuantityChanged(item.quantity - 1)
                          : null,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 32),
                    ),
                    Text(
                      item.quantity.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_rounded, size: 18),
                      onPressed: () => onQuantityChanged(item.quantity + 1),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 32),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Remove Button
              TextButton(
                onPressed: onRemove,
                style: TextButton.styleFrom(
                  foregroundColor: AppConstants.errorColor,
                  padding: EdgeInsets.zero,
                ),
                child: const Row(
                  children: [
                    Icon(Icons.delete_outline_rounded, size: 16),
                    SizedBox(width: 4),
                    Text('Remove'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}