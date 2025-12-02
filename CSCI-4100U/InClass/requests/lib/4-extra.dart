import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(const ProductApp());

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Explorer',
      theme: ThemeData(useMaterial3: true),
      home: const ProductScreen(),
    );
  }
}

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  late Future<List<Product>> _future;

  @override
  void initState() {
    super.initState();
    _future = ProductService.fetch(); // initial load
  }

  void _runSearch() {
    setState(() {
      final q = _searchCtrl.text.trim();
      _future = ProductService.fetch(query: q.isEmpty ? null : q);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Explorer')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: TextField(
              controller: _searchCtrl,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _runSearch(),
              decoration: InputDecoration(
                hintText: 'Search products (e.g., phone, shoes)…',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchCtrl.clear();
                    _runSearch();
                  },
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Error: ${snapshot.error}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                final products = snapshot.data ?? [];
                if (products.isEmpty) {
                  return const Center(child: Text('No products found.'));
                }

                return RefreshIndicator(
                  onRefresh: () async => _runSearch(),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: products.length,
                    itemBuilder: (_, i) => ProductCard(product: products[i]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _runSearch,
        icon: const Icon(Icons.cloud_download),
        label: const Text('Fetch'),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(product.title),
            content: Text('Price: \$${product.price.toStringAsFixed(2)}\n\n${product.brand ?? ''}'),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
                product.thumbnail,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image)),
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Text('\$${product.price.toStringAsFixed(2)}'),
            ),
          ],
        ),
      ),
    );
  }
}

// --------- Data Layer ---------

class Product {
  final int id;
  final String title;
  final double price;
  final String thumbnail;
  final String? brand;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
    this.brand,
  });

  factory Product.fromMap(Map<String, dynamic> m) => Product(
    id: m['id'] as int,
    title: m['title'] as String,
    price: (m['price'] as num).toDouble(),
    thumbnail: m['thumbnail'] as String,
    brand: m['brand'] as String?,
  );
}

class ProductService {
  static Future<List<Product>> fetch({String? query}) async {
    final base = 'https://dummyjson.com';
    final path = (query == null || query.isEmpty) ? '/products' : '/products/search';
    final params = {
      if (query != null && query.isNotEmpty) 'q': query,
      'limit': '20',
      'select': 'id,title,price,thumbnail,brand',
    };

    final uri = Uri.parse(base).replace(path: path, queryParameters: params);
    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.reasonPhrase}');
    }

    final Map<String, dynamic> json = jsonDecode(res.body);
    final List items = json['products'] ?? [];
    return items.map((e) => Product.fromMap(e as Map<String, dynamic>)).toList();
  }
}
