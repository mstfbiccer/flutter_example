import 'package:flutter/material.dart';
import 'package:flutter_example/services/products/fetch_products.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class Detail extends StatefulWidget {
  final int id;
  const Detail(this.id, {super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late Future<Map<String, dynamic>> _product;

  @override
  void initState() {
    super.initState();
    _product = FetchProducts.productById(widget.id); 
  }



  @override
  Widget build(BuildContext context) {
     void scanQrCode() async{
       final code = await SimpleBarcodeScanner.scanBarcode(
        context,
        barcodeAppBar: const BarcodeAppBar(
          appBarTitle: 'Test',
          centerTitle: false,
          enableBackButton: true,
          backButtonIcon: Icon(Icons.arrow_back_ios),
        ),
        isShowFlashIcon: true,
        delayMillis: 500,
        cameraFace: CameraFace.back,
        scanFormat: ScanFormat.ALL_FORMATS,
        );
        print("----------------Barcode------------------: $code");
      }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ürün Detayı"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _product,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else {
            final product = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        product['image'],
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      product['title'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${product['price']} ₺',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      product['description'],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                     ElevatedButton(
                      onPressed: () {
                        scanQrCode();
                      },
                      child: const Text("Yeni Ürün Ekle"),
                    ),
                  ],
                ),
               
              ),
              
            );
          }
        },
      ),
    );
  }
}
