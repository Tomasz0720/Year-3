import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ---------------------- MODEL CLASS ----------------------
class Product {
  final int id;
  final String title;
  final double price;
  final String? brand;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
    this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'], // already int
      title: json['title'], // already String
      price: (json['price'] as num).toDouble(), // keep this cast: ensures numeric safety
      thumbnail: json['thumbnail'], // already String
      brand: json['brand'], // already nullable String
    );
  }
}

// ---------------------- MAIN APP ----------------------
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProductListScreen(),
  ));
}

// ---------------------- PRODUCT LIST SCREEN ----------------------
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> _products = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  // ---------------------- LOAD PRODUCTS ----------------------
  Future<void> loadProducts() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final uri = Uri.parse(
      'https://dummyjson.com/products?limit=20&select=id,title,price,brand,thumbnail',
    );

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List items = data['products'] ?? [];
        setState(() {
          _products = items.map((e) => Product.fromJson(e)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _error = 'HTTP ${response.statusCode}: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Network/parse error: $e';
      });
    }
  }

  // ---------------------- BUILD UI ----------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: loadProducts,
            tooltip: 'Reload',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text(_error!))
          : _products.isEmpty
          ? const Center(child: Text('No products found'))
          : ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final p = _products[index];
          return Card(
            margin: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 4),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  p.thumbnail,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image),
                ),
              ),
              title: Text(p.title),
              subtitle: Text(
                '${p.brand ?? 'Unknown brand'}\n\$${p.price.toStringAsFixed(2)}',
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
