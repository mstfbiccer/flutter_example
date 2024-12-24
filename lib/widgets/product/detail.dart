import 'package:flutter/material.dart';
import 'package:flutter_example/services/products/fetch_products.dart';
class Detail extends StatefulWidget {
  final int id;
  const Detail(this.id, {super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late Future<Map<String,dynamic>> _products;
  @override 
  void initState() {
    super.initState();
    _products = FetchProducts.productById(49);
  }

  @override
  Widget build(BuildContext context) {
     return FutureBuilder<Map<String, dynamic>>(
      future: _products,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }else if(snapshot.hasError) {
          return Center(child: Text('Hata ${snapshot.error}'));
        }else {
          return SingleChildScrollView(
            child: Column(
            children: [
              Image(image:NetworkImage(snapshot.data!['thumbnailUrl'])),
              Text(snapshot.data!['title'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () {},
                child: Text('Sepete Ekle'),
              )
            ]
          )
          );
        }
      }
    );
  }
}