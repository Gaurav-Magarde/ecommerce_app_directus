import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';

class ViewAllScreen extends StatefulWidget {
  final List<Product> products;
  final Set<String> favorites;
  final Function(String) onToggleFavorite;

  const ViewAllScreen({
    super.key,
    required this.products,
    required this.favorites,
    required this.onToggleFavorite,
  });

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  String _sortBy = 'name'; // name, price_low, price_high, rating
  List<Product> _sortedProducts = [];

  @override
  void initState() {
    super.initState();
    _sortedProducts = List.from(widget.products);
    _sortProducts();
  }

  void _sortProducts() {
    setState(() {
      switch (_sortBy) {
        case 'name':
          _sortedProducts.sort((a, b) => a.name.compareTo(b.name));
          break;
        case 'price_low':
          _sortedProducts.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'price_high':
          _sortedProducts.sort((a, b) => b.price.compareTo(a.price));
          break;
        case 'rating':
          _sortedProducts.sort((a, b) => b.rating.compareTo(a.rating));
          break;
      }
    });
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sort By',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...[
              {'value': 'name', 'label': 'Name (A-Z)'},
              {'value': 'price_low', 'label': 'Price (Low to High)'},
              {'value': 'price_high', 'label': 'Price (High to Low)'},
              {'value': 'rating', 'label': 'Rating (High to Low)'},
            ].map((option) => ListTile(
                  leading: Icon(
                    _sortBy == option['value']
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: Colors.purple,
                  ),
                  title: Text(option['label']!),
                  onTap: () {
                    setState(() {
                      _sortBy = option['value']!;
                    });
                    _sortProducts();
                    Navigator.pop(context);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        title: const Text('All Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _showSortOptions,
            tooltip: 'Sort',
          ),
        ],
      ),
      body: Column(
        children: [
          // Product Count and Sort Info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_sortedProducts.length} Products',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton.icon(
                  onPressed: _showSortOptions,
                  icon: const Icon(Icons.filter_list),
                  label: const Text('Sort'),
                ),
              ],
            ),
          ),

          // Products Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: _sortedProducts.length,
                itemBuilder: (context, index) {
                  final product = _sortedProducts[index];
                  return _buildProductCard(product);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    final isFavorite = widget.favorites.contains(product.id);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              product: product,
              isFavorite: isFavorite,
              onToggleFavorite: () => widget.onToggleFavorite(product.id),
            ),
          ),
        ).then((_) {
          // Refresh the screen when returning from detail page
          setState(() {});
        });
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    product.imageUrl,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 140,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.image, size: 50, color: Colors.grey),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () {
                      widget.onToggleFavorite(product.id);
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Product Details
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
