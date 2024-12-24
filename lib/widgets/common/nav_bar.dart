import 'package:flutter/material.dart';
class NavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const NavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Dört veya daha fazla öğe için gerekli
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
        BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Kategoriler'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Sepetim'),
        BottomNavigationBarItem(icon: Icon(Icons.exit_to_app), label: 'Çıkış Yap'),
      ],
    );
  }
}
