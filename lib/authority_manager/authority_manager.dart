import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:backend/backend.dart';
import 'authority_type_implementations.dart';

// Yetki yönetimi için Provider veya state management kullanabilirsiniz
class AuthorityManager extends ChangeNotifier {
  final AuthoritiesService _authoritiesService;
  List<Authorities> _authorities = [];
  bool _isLoading = false;
  String? _error;

  AuthorityManager() : _authoritiesService = AuthoritiesService();

  List<Authorities> get authorities => _authorities;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> initialize() async {
    try {
      await _authoritiesService.init();
    } catch (e) {
      _error = e.toString();
      if (kDebugMode) print('Authority Manager Init Error: $e');
    }
  }

  Future<void> loadAuthorities() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _authoritiesService.init();
      final response = await _authoritiesService.getAll();

      if (response.isNotEmpty) {
        _authorities = response.map((authority) {
          // Yetki tipini belirle

          AuthorityType type = _determineAuthorityType(authority);
          // Factory ile yeni yetki objesi oluştur
          return AuthorityFactory.create(type, authorId: authority.author);
        }).toList();

        if (kDebugMode) {
          print('Authorities loaded: ${_authorities.length}');
          for (var auth in _authorities) {
            print('Authority: ${auth.description}');
          }
        }
      } else {
        if (kDebugMode) print('No authorities found');
      }
    } catch (e) {
      _error = e.toString();
      if (kDebugMode) print('Load Authorities Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  AuthorityType _determineAuthorityType(Authorities authority) {
    if (authority.readAt && authority.writeAt && authority.updateAt && authority.deleteAt) {
      return AuthorityType.admin;
    } else if (authority.readAt && authority.writeAt && authority.updateAt) {
      return AuthorityType.manager;
    } else if (authority.readAt && authority.updateAt) {
      return AuthorityType.supervisor;
    } else if (authority.readAt && authority.writeAt) {
      return AuthorityType.editor;
    } else if (authority.readAt) {
      return AuthorityType.viewer;
    } else {
      return AuthorityType.none;
    }
  }

  void dispose() {
    _authoritiesService.dispose();
    super.dispose();
  }
}

// UI için Widget
class AuthoritiesScreen extends StatefulWidget {
  const AuthoritiesScreen({Key? key}) : super(key: key);

  @override
  State<AuthoritiesScreen> createState() => _AuthoritiesScreenState();
}

class _AuthoritiesScreenState extends State<AuthoritiesScreen> {
  final AuthorityManager _authorityManager = AuthorityManager();

  @override
  void initState() {
    super.initState();
    _loadAuthorities();
  }

  Future<void> _loadAuthorities() async {
    await _authorityManager.loadAuthorities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yetkiler'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAuthorities,
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _authorityManager,
        builder: (context, child) {
          if (_authorityManager.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_authorityManager.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Hata: ${_authorityManager.error}'),
                  ElevatedButton(
                    onPressed: _loadAuthorities,
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            );
          }

          final authorities = _authorityManager.authorities;

          if (authorities.isEmpty) {
            return const Center(child: Text('Yetki bulunamadı'));
          }

          return ListView.builder(
            itemCount: authorities.length,
            itemBuilder: (context, index) {
              final authority = authorities[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: AuthorityBadge(authority: authority),
                  title: Text('Kullanıcı ID: ${authority.author}'),
                  subtitle: Text(authority.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (authority.readAt)
                        const Tooltip(
                          message: 'Okuma Yetkisi',
                          child: Icon(Icons.visibility, color: Colors.blue),
                        ),
                      if (authority.writeAt)
                        const Tooltip(
                          message: 'Yazma Yetkisi',
                          child: Icon(Icons.edit, color: Colors.green),
                        ),
                      if (authority.updateAt)
                        const Tooltip(
                          message: 'Güncelleme Yetkisi',
                          child: Icon(Icons.update, color: Colors.orange),
                        ),
                      if (authority.deleteAt)
                        const Tooltip(
                          message: 'Silme Yetkisi',
                          child: Icon(Icons.delete, color: Colors.red),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _authorityManager.dispose();
    super.dispose();
  }
}
