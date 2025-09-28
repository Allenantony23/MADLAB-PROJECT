import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../utils/constants.dart';
import '../../widgets/product/product_card.dart';
import '../../widgets/common/category_grid.dart';
import '../../widgets/common/banner_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Product> _trendingProducts = [
    Product(
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
      isMadeInIndia: false,
    ),
    Product(
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
      isMadeInIndia: true,
    ),
    Product(
      id: '3',
      name: 'MacBook Air M2',
      description: 'Apple laptop with M2 chip',
      price: 114999,
      originalPrice: 129999,
      discount: 12,
      rating: 4.8,
      reviewCount: 567,
      images: ['https://via.placeholder.com/300'],
      category: 'Electronics',
      tags: ['Laptop', 'Apple'],
      isBestSeller: false,
      isMadeInIndia: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Search
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for mobiles, sarees, groceries...',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontFamily: AppConstants.fontFamily,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {},
              ),
            ],
          ),

          // Body Content
          SliverList(
            delegate: SliverChildListDelegate([
              // Banner Carousel
              const BannerCarousel(),

              // Categories Grid
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Categories',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const CategoryGrid(),

              // Trending in India Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      'Trending in India',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppConstants.secondaryColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Hot',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Trending Products Horizontal List
              SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _trendingProducts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: ProductCard(product: _trendingProducts[index]),
                    );
                  },
                ),
              ),

              // Festival Offers Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Diwali Special Offers',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),

              // Gamification: Spin & Win
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppConstants.primaryColor,
                      AppConstants.secondaryColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              '🎉 Special Offer',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Spin & Win\n₹50 Cashback!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Try your luck and get instant cashback',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Spin Wheel Icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.casino_rounded,
                        size: 40,
                        color: AppConstants.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}