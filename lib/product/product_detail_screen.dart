import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../utils/constants.dart';
import '../../widgets/common/quantity_selector.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedImageIndex = 0;
  int _quantity = 1;
  bool _isWishlisted = false;

  final List<ProductReview> _reviews = [
    ProductReview(
      id: '1',
      userName: 'Rahul Sharma',
      rating: 4.5,
      comment: 'Great product! Fast delivery and good quality.',
      date: DateTime.now().subtract(const Duration(days: 2)),
      verifiedPurchase: true,
    ),
    ProductReview(
      id: '2',
      userName: 'Priya Patel',
      rating: 5.0,
      comment: 'Excellent quality and perfect fit. Highly recommended!',
      date: DateTime.now().subtract(const Duration(days: 5)),
      verifiedPurchase: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // Product Images
                  PageView.builder(
                    itemCount: widget.product.images.length,
                    onPageChanged: (index) {
                      setState(() {
                        _selectedImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.network(
                        widget.product.images[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.shopping_bag_rounded,
                                size: 100, color: Colors.grey),
                          );
                        },
                      );
                    },
                  ),
                  
                  // Image Indicators
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.product.images.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _selectedImageIndex == index
                                ? AppConstants.primaryColor
                                : Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  _isWishlisted ? Icons.favorite : Icons.favorite_border,
                  color: _isWishlisted ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _isWishlisted = !_isWishlisted;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.share_rounded),
                onPressed: () {},
              ),
            ],
          ),
          
          SliverList(
            delegate: SliverChildListDelegate([
              // Product Details
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name and Brand
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppConstants.fontFamily,
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Ratings and Reviews
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppConstants.successColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Text(
                                widget.product.rating.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.white,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${widget.product.reviewCount} Reviews',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Price Section
                    Row(
                      children: [
                        Text(
                          widget.product.formattedPrice,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: AppConstants.fontFamily,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (widget.product.discount > 0)
                          Text(
                            widget.product.formattedOriginalPrice,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        if (widget.product.discount > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppConstants.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${widget.product.discount.toInt()}% OFF',
                              style: const TextStyle(
                                color: AppConstants.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Delivery Info
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green.withOpacity(0.2)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.local_shipping_rounded,
                              color: Colors.green, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Free Delivery',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  'Order above ₹499 • Delivery by tomorrow',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.green[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Product Description
                    const Text(
                      'Product Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppConstants.fontFamily,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.product.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Quantity Selector
                    const Text(
                      'Quantity',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppConstants.fontFamily,
                      ),
                    ),
                    const SizedBox(height: 12),
                    QuantitySelector(
                      quantity: _quantity,
                      onChanged: (value) {
                        setState(() {
                          _quantity = value;
                        });
                      },
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Reviews Section
                    const Text(
                      'Customer Reviews',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppConstants.fontFamily,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    ..._reviews.map((review) => ReviewCard(review: review)),
                    
                    const SizedBox(height: 80), // Space for bottom button
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      
      // Bottom Add to Cart Button
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
        child: Row(
          children: [
            // Add to Cart Button
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: () {
                  _addToCart();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.secondaryColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.shopping_cart_outlined),
                label: const Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Buy Now Button
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  _buyNow();
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
                  'Buy Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addToCart() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added ${widget.product.name} to cart'),
        backgroundColor: AppConstants.successColor,
      ),
    );
  }

  void _buyNow() {
    // Navigate to checkout
  }
}

class ReviewCard extends StatelessWidget {
  final ProductReview review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info and Rating
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppConstants.primaryColor.withOpacity(0.1),
                child: Text(
                  review.userName[0],
                  style: const TextStyle(
                    color: AppConstants.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: index < review.rating.floor()
                                ? AppConstants.secondaryColor
                                : Colors.grey[300],
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              if (review.verifiedPurchase)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppConstants.successColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Verified',
                    style: TextStyle(
                      color: AppConstants.successColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Review Comment
          Text(
            review.comment,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Review Date
          Text(
            '${review.date.day}/${review.date.month}/${review.date.year}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}