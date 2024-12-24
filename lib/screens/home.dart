import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_example/providers/theme_provider.dart';
import 'package:flutter_example/widgets/common/category_list_widget.dart';
import 'package:flutter_example/widgets/common/product_list_widget.dart';
import 'package:flutter_example/widgets/home/banner_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDarkMode = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: HomeScreenContent(),
      ),
    );
  }

  void setTheme() {
    setState(() {
      _isDarkMode = false;
    });
  }

  @override 
  void initState() {
    super.initState();
    print('initState');
  }

  @override
  void didUpdateWidget(covariant HomeScreen _currentTheme) {
    super.didUpdateWidget(_currentTheme);
    print('didUpdateWidget');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }
}

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);    

    return SingleChildScrollView(
      child: Column(
        children: [
          BannerWidget(),
          DatePickerWidget(),
          ElevatedButton(
            onPressed: () {
              themeProvider.toggleTheme();
            },
            child: Text('Tema Değiştir'),
          ),
          ProductList(title: "Öne Çıkanlar"),
          CategoryListWidget()
        ],
      ),
    );
  }
}

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    if(Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoTextField(
        placeholder: 'Cupertino Input',
        padding: EdgeInsets.all(16),
      );
    }else {
      return TextField(
        decoration: InputDecoration(
          hintText: 'Material Input',
          contentPadding: EdgeInsets.all(16),
        ),
      );
    }
  }
}