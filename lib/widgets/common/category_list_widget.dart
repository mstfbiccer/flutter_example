import 'package:flutter/material.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text("Category Test Title"),
          Row(
            children: [
             CategoryCard(title:'Cat 1'),
             CategoryCard(title:'Cat 2'),
             CategoryCard(title:'Cat 3')
            ],
          )
        ],
      )
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  const CategoryCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(title),
      )
    );
  }
}