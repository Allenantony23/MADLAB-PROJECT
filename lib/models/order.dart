class Order {
  final String id;
  final DateTime orderDate;
  final List<OrderItem> items;
  final double totalAmount;
  final double discount;
  final double deliveryCharge;
  final double gst;
  final double finalAmount;
  final OrderStatus status;
  final Address shippingAddress;
  final PaymentMethod paymentMethod;
  final String? trackingNumber;
  final DateTime? expectedDelivery;

  Order({
    required this.id,
    required this.orderDate,
    required this.items,
    required this.totalAmount,
    required this.discount,
    required this.deliveryCharge,
    required this.gst,
    required this.finalAmount,
    required this.status,
    required this.shippingAddress,
    required this.paymentMethod,
    this.trackingNumber,
    this.expectedDelivery,
  });
}

class OrderItem {
  final String productId;
  final String productName;
  final String productImage;
  final double price;
  final int quantity;
  final double discount;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    required this.discount,
  });

  double get totalPrice => price * quantity;
}

enum OrderStatus {
  ordered,
  confirmed,
  shipped,
  outForDelivery,
  delivered,
  cancelled,
  returned
}

extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.ordered:
        return 'Ordered';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.outForDelivery:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
      case OrderStatus.returned:
        return 'Returned';
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.ordered:
        return Colors.orange;
      case OrderStatus.confirmed:
        return Colors.blue;
      case OrderStatus.shipped:
        return Colors.purple;
      case OrderStatus.outForDelivery:
        return Colors.green;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
      case OrderStatus.returned:
        return Colors.grey;
    }
  }
}

enum PaymentMethod {
  upi,
  creditCard,
  debitCard,
  netBanking,
  cashOnDelivery,
  wallet
}

extension PaymentMethodExtension on PaymentMethod {
  String get displayName {
    switch (this) {
      case PaymentMethod.upi:
        return 'UPI';
      case PaymentMethod.creditCard:
        return 'Credit Card';
      case PaymentMethod.debitCard:
        return 'Debit Card';
      case PaymentMethod.netBanking:
        return 'Net Banking';
      case PaymentMethod.cashOnDelivery:
        return 'Cash on Delivery';
      case PaymentMethod.wallet:
        return 'Wallet';
    }
  }

  String get icon {
    switch (this) {
      case PaymentMethod.upi:
        return '💰';
      case PaymentMethod.creditCard:
        return '💳';
      case PaymentMethod.debitCard:
        return '💳';
      case PaymentMethod.netBanking:
        return '🏦';
      case PaymentMethod.cashOnDelivery:
        return '💵';
      case PaymentMethod.wallet:
        return '👛';
    }
  }
}