import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  final List<BannerItem> _banners = [
    BannerItem(
      title: 'Diwali Dhamaka Sale',
      subtitle: 'Upto 70% OFF',
      color: Colors.deepOrange,
      image: Icons.celebration_rounded,
    ),
    BannerItem(
      title: 'Republic Day Special',
      subtitle: 'Flat ₹500 OFF',
      color: Colors.green,
      image: Icons.flag_rounded,
    ),
    BannerItem(
      title: 'Free Delivery',
      subtitle: 'On orders above ₹499',
      color: Colors.blue,
      image: Icons.local_shipping_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _banners.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: BannerCard(banner: _banners[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        // Page Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _banners.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? AppConstants.primaryColor
                    : Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BannerItem {
  final String title;
  final String subtitle;
  final Color color;
  final IconData image;

  BannerItem({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.image,
  });
}

class BannerCard extends StatelessWidget {
  final BannerItem banner;

  const BannerCard({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            banner.color,
            banner.color.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: banner.color.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Pattern
          Positioned(
            right: -20,
            top: -20,
            child: Icon(
              banner.image,
              size: 120,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  banner.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppConstants.fontFamily,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  banner.subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    fontFamily: AppConstants.fontFamily,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Shop Now',
                    style: TextStyle(
                      color: banner.color,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppConstants.fontFamily,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}