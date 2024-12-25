import 'package:flutter/material.dart';
import 'package:flutter_example/widgets/common/product_list_widget.dart';

class Category extends StatefulWidget {
  const Category({super.key});

   @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: CategoryContent(),
      ),
    );
  }
}

class CategoryContent extends StatelessWidget {
  const CategoryContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          ProductList(title: "Kategori Listesi")
        ],
      ),
    );
  }
}