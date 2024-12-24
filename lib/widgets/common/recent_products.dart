import 'package:flutter/material.dart';
import 'package:flutter_example/services/database/database_helper.dart';

class RecentProducts extends StatelessWidget {
  const RecentProducts({super.key});
  @override
  Widget build(BuildContext context) {
    final dbHelper = DatabaseHelper();

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: dbHelper.getVisitedProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Hata oluştu!'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Son gezilen ürün bulunamadı.'));
        } else {
          final products = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Son Gezilen Ürünler',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.clear, color: Colors.red),
                    onPressed: () async {
                      await dbHelper.clearVisitedProducts();
                      // Sayfayı yeniden oluşturmak için StatefulWidget kullanımı önerilir
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(right: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(products[index]['name']),
                            const SizedBox(height: 5),
                            Text('ID: ${products[index]['id']}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
