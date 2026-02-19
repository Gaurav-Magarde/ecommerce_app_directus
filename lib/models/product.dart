class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.category,
  });

  // Sample products data
  static List<Product> getSampleProducts() {
    return [
      Product(
        id: '1',
        name: 'Wireless Headphones',
        description: 'High-quality wireless headphones with noise cancellation',
        price: 99.99,
        imageUrl: 'https://picsum.photos/200/200?random=1',
        rating: 4.5,
        category: 'Electronics',
      ),
      Product(
        id: '2',
        name: 'Smart Watch',
        description: 'Feature-rich smartwatch with health tracking',
        price: 199.99,
        imageUrl: 'https://picsum.photos/200/200?random=2',
        rating: 4.7,
        category: 'Electronics',
      ),
      Product(
        id: '3',
        name: 'Running Shoes',
        description: 'Comfortable running shoes for daily workouts',
        price: 79.99,
        imageUrl: 'https://picsum.photos/200/200?random=3',
        rating: 4.3,
        category: 'Sports',
      ),
      Product(
        id: '4',
        name: 'Coffee Maker',
        description: 'Automatic coffee maker with timer',
        price: 49.99,
        imageUrl: 'https://picsum.photos/200/200?random=4',
        rating: 4.2,
        category: 'Home',
      ),
      Product(
        id: '5',
        name: 'Backpack',
        description: 'Durable backpack with laptop compartment',
        price: 39.99,
        imageUrl: 'https://picsum.photos/200/200?random=5',
        rating: 4.6,
        category: 'Accessories',
      ),
      Product(
        id: '6',
        name: 'Bluetooth Speaker',
        description: 'Portable Bluetooth speaker with great sound',
        price: 59.99,
        imageUrl: 'https://picsum.photos/200/200?random=6',
        rating: 4.4,
        category: 'Electronics',
      ),
      Product(
        id: '7',
        name: 'Yoga Mat',
        description: 'Non-slip yoga mat for comfortable workouts',
        price: 29.99,
        imageUrl: 'https://picsum.photos/200/200?random=7',
        rating: 4.5,
        category: 'Sports',
      ),
      Product(
        id: '8',
        name: 'Water Bottle',
        description: 'Insulated water bottle keeps drinks cold for 24h',
        price: 24.99,
        imageUrl: 'https://picsum.photos/200/200?random=8',
        rating: 4.8,
        category: 'Sports',
      ),
    ];
  }
}
