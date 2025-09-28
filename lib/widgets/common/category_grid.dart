import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {
      'name': 'Mobiles',
      'icon': Icons.smartphone_rounded,
      'color': Colors.blue,
    },
    {
      'name': 'Fashion',
      'icon': Icons.shopping_bag_rounded,
      'color': Colors.pink,
    },
    {
      'name': 'Groceries',
      'icon': Icons.shopping_cart_rounded,
      'color': Colors.green,
    },
    {
      'name': 'Electronics',
      'icon': Icons.computer_rounded,
      'color': Colors.orange,
    },
    {
      'name': 'Home',
      'icon': Icons.home_rounded,
      'color': Colors.purple,
    },
    {
      'name': 'Beauty',
      'icon': Icons.face_retouching_natural_rounded,
      'color': Colors.red,
    },
    {
      'name': 'Jewellery',
      'icon': Icons.diamond_rounded,
      'color': Colors.amber,
    },
    {
      'name': 'Toys',
      'icon': Icons.toys_rounded,
      'color': Colors.cyan,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      padding: const EdgeInsets.all(16),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final category = _categories[index];
        return CategoryItem(
          name: category['name'] as String,
          icon: category['icon'] as IconData,
          color: category['color'] as Color,
        );
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;

  const CategoryItem({
    super.key,
    required this.name,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Icon Container
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: color,
            size: 30,
          ),
        ),
        const SizedBox(height: 8),
        // Category Name
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontFamily: AppConstants.fontFamily,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}