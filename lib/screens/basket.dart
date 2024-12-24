import "package:flutter/material.dart";

class Basket extends StatefulWidget {
  const Basket({super.key});

  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: const Center(
        child: BasketContent(),
      ),
    );
  }
}

class BasketContent extends StatelessWidget {
  const BasketContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          Text("Sepet")
        ],
      ),
    );
  }
}