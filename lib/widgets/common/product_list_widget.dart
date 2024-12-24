import 'package:flutter/material.dart';
import 'package:flutter_example/widgets/product/detail.dart';

class ProductList extends StatelessWidget {
  final String title;
  const ProductList({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return (Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(title),
            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Card(
                      child: Column(children: [
                    Text('Ürün Adı ${index + 1}'),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Detail(index + 1)));
                        },
                        child: Text('İncele'))
                  ]));
                }),
          ],
        )));
  }
}
