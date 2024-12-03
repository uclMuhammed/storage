import 'package:backend/backend.dart';
import 'package:backend/service/generic_api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:storage/pages/auth/auth_manager/auth_manager.dart';

class Deneme extends StatefulWidget {
  const Deneme({super.key});

  @override
  State<Deneme> createState() => _DenemeState();
}

class _DenemeState extends State<Deneme> {
  GenericApiService<Brands> service =
      GenericApiService<Brands>(endPoint: '/brands', fromJson: Brands.fromJson);
  List<Brands> brands = []; // Brands listesi>
  String brandId = ""; // Brands listesi>
  final AuthManager _auth = AuthManager();
  final AuthenticationService _authService = AuthenticationService();
  AuthoritiesService authoritiesService = AuthoritiesService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              brandId,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _handleLogin,
            heroTag: "login",
            child: const Icon(Icons.login),
          ),
          FloatingActionButton(
            onPressed: _logout,
            heroTag: "logout",
            child: const Icon(Icons.logout),
          ),
          FloatingActionButton(
            onPressed: () {
              _service();
            },
            heroTag: "brands",
            child: const Icon(Icons.branding_watermark_sharp),
          ),
          FloatingActionButton(
            onPressed: () {
              _serviceGetbyId();
            },
            heroTag: "brandsId",
            child: const Icon(Icons.get_app),
          ),
          FloatingActionButton(
            onPressed: () {},
            heroTag: "",
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogin() async {
    try {
      final success = await _auth.login(
        companyCode: 68738,
        email: "test11@gmail.com",
        password: "testpass",
      );
      if (success && mounted) {
        // Login başarılı - Ana sayfaya yönlendir
        if (kDebugMode) {
          print(_authService.client);
        }
        if (kDebugMode) {
          print("Login success");
        }
      } else if (mounted) {
        // Hata mesajını göster
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_auth.error ?? 'Giriş başarısız'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bir hata oluştu: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _logout() async {
    await _auth.logout();
  }

  Future<void> _service() async {
    try {
      await service.init();
      final loadService = await service.getAll();
      setState(() {
        brands = loadService;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Hata:$e");
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bir hata olştu: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _serviceGetbyId() async {
    try {
      await service.init();
      final loadService = await service.getById(1);
      setState(
        () {
          brandId = loadService.toString();
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print("Hata:$e");
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bir hata olştu: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
