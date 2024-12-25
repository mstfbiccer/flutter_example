import 'package:flutter/material.dart';
import 'package:flutter_example/services/database/database_helper.dart';
import 'package:flutter_example/widgets/product/detail.dart';

class ProductList extends StatelessWidget {
  final String title;
  const ProductList({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final dbHelper = DatabaseHelper();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(title),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Text('Ürün Adı ${index + 1}'),
                    ElevatedButton(
                      onPressed: () async {
                        final productId = index + 1;
                        final productName = 'Ürün Adı $productId';
                        // Ürün bilgilerini kaydet
                        await dbHelper.insertProduct(productId, productName);
                        // Detay ekranına yönlendir
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detail(productId),
                          ),
                        );
                      },
                      child: const Text('İncele'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
