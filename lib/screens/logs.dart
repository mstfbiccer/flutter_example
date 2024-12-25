import 'package:flutter/material.dart';
import 'package:flutter_example/services/database/crud.dart';
import 'package:flutter_example/services/database/orm.dart'; // Drift veritabanını dahil edin

class LogScreen extends StatelessWidget {
  final AppDb database = AppDb(); // Veritabanı burada tanımlanıyor

  LogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş Kayıtları'),
      ),
      body: StreamBuilder<List<User>>(
        stream: database.watchAllUsers(), // Tüm kullanıcıları izleyen stream
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Veri Bulunamadı.'),
            );
          }

          final logs = snapshot.data ?? [];

          if (logs.isEmpty) {
            return const Center(
              child: Text('Henüz kayıtlı bir giriş yok.'),
            );
          }

          return ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(log.username),
                subtitle: Text(''
                    'Giriş Zamanı: ${log.loginTime.toLocal()}'),
                isThreeLine: true,
              );
            },
          );
        },
      ),
    );
  }
}
