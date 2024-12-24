import 'package:flutter/material.dart';
import 'package:flutter_example/widgets/product/detail.dart';

class Product extends StatelessWidget {
  const Product({super.key});

  @override
  Widget build(context) { 
  return Scaffold(
      body: const Center(
        child: ProductContent()
      ),
    );
  }
}


class ProductContent extends StatelessWidget {
  const ProductContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          Detail(2)
        ],
      ),
    );
  }
}