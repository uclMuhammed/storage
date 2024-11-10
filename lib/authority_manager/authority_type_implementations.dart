import 'package:flutter/material.dart';
import 'package:backend/backend.dart';

// Authority tipleri için enum
enum AuthorityType { admin, manager, supervisor, editor, user, viewer, none }

// Authority Factory - Yetki oluşturucu
class AuthorityFactory {
  static Authorities create(AuthorityType type, {int authorId = 0}) {
    switch (type) {
      case AuthorityType.admin:
        return _AdminAuthority(authorId);
      case AuthorityType.manager:
        return _ManagerAuthority(authorId);
      case AuthorityType.supervisor:
        return _SupervisorAuthority(authorId);
      case AuthorityType.editor:
        return _EditorAuthority(authorId);
      case AuthorityType.user:
        return _UserAuthority(authorId);
      case AuthorityType.viewer:
        return _ViewerAuthority(authorId);
      case AuthorityType.none:
        return _NoAuthority(authorId);
    }
  }
}

// Admin Yetkisi - Tam yetkili kullanıcı
class _AdminAuthority extends Authorities {
  _AdminAuthority(int authorId)
      : super(
          id: 1,
          author: authorId,
          readAt: true,
          writeAt: true,
          updateAt: true,
          deleteAt: true,
          description: 'Admin - Tam yetki',
          isActive: true,
          isDelete: false,
          createdAt: DateTime.now(),
          createdBy: 'SYSTEM',
          updatedAt: null,
          updatedBy: null,
          deletedBy: null,
          deletedAt: null,
        );
}

// Yönetici Yetkisi - Silme hariç tam yetkili
class _ManagerAuthority extends Authorities {
  _ManagerAuthority(int authorId)
      : super(
          id: 2,
          author: authorId,
          readAt: true,
          writeAt: true,
          updateAt: true,
          deleteAt: false,
          description: 'Manager - Silme hariç tam yetki',
          isActive: true,
          isDelete: false,
          createdAt: DateTime.now(),
          createdBy: 'SYSTEM',
          updatedAt: null,
          updatedBy: null,
          deletedBy: null,
          deletedAt: null,
        );
}

// Supervisor Yetkisi - Denetleme ve düzenleme yetkisi
class _SupervisorAuthority extends Authorities {
  _SupervisorAuthority(int authorId)
      : super(
          id: 3,
          author: authorId,
          readAt: true,
          writeAt: false,
          updateAt: true,
          deleteAt: false,
          description: 'Supervisor - Denetleme ve düzenleme yetkisi',
          isActive: true,
          isDelete: false,
          createdAt: DateTime.now(),
          createdBy: 'SYSTEM',
          updatedAt: null,
          updatedBy: null,
          deletedBy: null,
          deletedAt: null,
        );
}

// Editor Yetkisi - İçerik düzenleme yetkisi
class _EditorAuthority extends Authorities {
  _EditorAuthority(int authorId)
      : super(
          id: 4,
          author: authorId,
          readAt: true,
          writeAt: true,
          updateAt: true,
          deleteAt: false,
          description: 'Editor - İçerik düzenleme yetkisi',
          isActive: true,
          isDelete: false,
          createdAt: DateTime.now(),
          createdBy: 'SYSTEM',
          updatedAt: null,
          updatedBy: null,
          deletedBy: null,
          deletedAt: null,
        );
}

// Kullanıcı Yetkisi - Temel kullanıcı yetkileri
class _UserAuthority extends Authorities {
  _UserAuthority(int authorId)
      : super(
          id: 5,
          author: authorId,
          readAt: true,
          writeAt: true,
          updateAt: false,
          deleteAt: false,
          description: 'User - Temel kullanıcı yetkileri',
          isActive: true,
          isDelete: false,
          createdAt: DateTime.now(),
          createdBy: 'SYSTEM',
          updatedAt: null,
          updatedBy: null,
          deletedBy: null,
          deletedAt: null,
        );
}

// Görüntüleyici Yetkisi - Sadece okuma yetkisi
class _ViewerAuthority extends Authorities {
  _ViewerAuthority(int authorId)
      : super(
          id: 6,
          author: authorId,
          readAt: true,
          writeAt: false,
          updateAt: false,
          deleteAt: false,
          description: 'Viewer - Sadece okuma yetkisi',
          isActive: true,
          isDelete: false,
          createdAt: DateTime.now(),
          createdBy: 'SYSTEM',
          updatedAt: null,
          updatedBy: null,
          deletedBy: null,
          deletedAt: null,
        );
}

// Yetkisiz Kullanıcı
class _NoAuthority extends Authorities {
  _NoAuthority(int authorId)
      : super(
          id: 7,
          author: authorId,
          readAt: false,
          writeAt: false,
          updateAt: false,
          deleteAt: false,
          description: 'No Authority - Yetkisiz kullanıcı',
          isActive: true,
          isDelete: false,
          createdAt: DateTime.now(),
          createdBy: 'SYSTEM',
          updatedAt: null,
          updatedBy: null,
          deletedBy: null,
          deletedAt: null,
        );
}

// Yetki kontrolü için extension
extension AuthorityExtension on Authorities {
  bool canRead() => readAt;
  bool canWrite() => writeAt;
  bool canUpdate() => updateAt;
  bool canDelete() => deleteAt;
  bool hasFullAccess() => readAt && writeAt && updateAt && deleteAt;
  bool hasNoAccess() => !readAt && !writeAt && !updateAt && !deleteAt;
}

// UI için yetki widget'ı
class AuthorityBadge extends StatelessWidget {
  final Authorities authority;

  const AuthorityBadge({Key? key, required this.authority}) : super(key: key);

  Color get _badgeColor {
    if (authority.hasFullAccess()) return Colors.red;
    if (authority.hasNoAccess()) return Colors.grey;
    if (authority.updateAt) return Colors.orange;
    if (authority.writeAt) return Colors.blue;
    if (authority.readAt) return Colors.green;
    return Colors.grey;
  }

  String get _badgeText {
    if (authority.hasFullAccess()) return 'Admin';
    if (authority.hasNoAccess()) return 'No Access';
    if (authority.updateAt) return 'Editor';
    if (authority.writeAt) return 'User';
    if (authority.readAt) return 'Viewer';
    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _badgeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _badgeText,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
