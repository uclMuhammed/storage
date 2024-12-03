import 'package:backend/service/generic_api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:backend/backend.dart';

class ServiceManager {
  static final ServiceManager _instance = ServiceManager._internal();
  factory ServiceManager() => _instance;
  ServiceManager._internal();

  final Map<Type, dynamic> _services = {};

  Future<T> getService<T>(Type serviceType) async {
    try {
      if (!_services.containsKey(T)) {
        final service = _createService<T>();
        await service.init();
        _services[T] = service;
      }
      return _services[T] as T;
    } catch (e) {
      if (kDebugMode) print('GetService Error for $T: $e');
      rethrow;
    }
  }

  dynamic _createService<T>() {
    // Auth service için özel durum
    if (T == AuthenticationService) {
      return AuthenticationService(
        endPoint: '/auth',
        client: null,
        storage: null,
      );
    }

    // Generic API servisleri için
    switch (T) {
      case const (GenericApiService<Authorities>):
        return GenericApiService<Authorities>(
          endPoint: '/authorities',
          fromJson: Authorities.fromJson,
        );

      case const (GenericApiService<Brands>):
        return GenericApiService<Brands>(
          endPoint: '/brands',
          fromJson: Brands.fromJson,
        );

      case const (GenericApiService<Categories>):
        return GenericApiService<Categories>(
          endPoint: '/categories',
          fromJson: Categories.fromJson,
        );

      case const (GenericApiService<CategoriesSub>):
        return GenericApiService<CategoriesSub>(
          endPoint: '/categoriesSub',
          fromJson: CategoriesSub.fromJson,
        );

      case const (GenericApiService<Cities>):
        return GenericApiService<Cities>(
          endPoint: '/cities',
          fromJson: Cities.fromJson,
        );

      case const (GenericApiService<Companies>):
        return GenericApiService<Companies>(
          endPoint: '/companies',
          fromJson: Companies.fromJson,
        );

      case const (GenericApiService<CompanyUserRegions>):
        return GenericApiService<CompanyUserRegions>(
          endPoint: '/companyUserRegions',
          fromJson: CompanyUserRegions.fromJson,
        );

      case const (GenericApiService<CompanyUserRole>):
        return GenericApiService<CompanyUserRole>(
          endPoint: '/companyUserRole',
          fromJson: CompanyUserRole.fromJson,
        );

      case const (GenericApiService<CompanyUserWarehouses>):
        return GenericApiService<CompanyUserWarehouses>(
          endPoint: '/companyUserWarehouses',
          fromJson: CompanyUserWarehouses.fromJson,
        );

      case const (GenericApiService<Countries>):
        return GenericApiService<Countries>(
          endPoint: '/countries',
          fromJson: Countries.fromJson,
        );

      case const (GenericApiService<Logger>):
        return GenericApiService<Logger>(
          endPoint: '/logger',
          fromJson: Logger.fromJson,
        );

      case const (GenericApiService<Modules>):
        return GenericApiService<Modules>(
          endPoint: '/modules',
          fromJson: Modules.fromJson,
        );

      case const (GenericApiService<Plans>):
        return GenericApiService<Plans>(
          endPoint: '/plans',
          fromJson: Plans.fromJson,
        );

      case const (GenericApiService<ProductMovement>):
        return GenericApiService<ProductMovement>(
          endPoint: '/productMovement',
          fromJson: ProductMovement.fromJson,
        );

      case const (GenericApiService<ProductUnits>):
        return GenericApiService<ProductUnits>(
          endPoint: '/productUnits',
          fromJson: ProductUnits.fromJson,
        );

      case const (GenericApiService<Products>):
        return GenericApiService<Products>(
          endPoint: '/products',
          fromJson: Products.fromJson,
        );

      case const (GenericApiService<ProjectCode>):
        return GenericApiService<ProjectCode>(
          endPoint: '/projectCode',
          fromJson: ProjectCode.fromJson,
        );

      case const (GenericApiService<ReferenceCode>):
        return GenericApiService<ReferenceCode>(
          endPoint: '/referenceCode',
          fromJson: ReferenceCode.fromJson,
        );

      case const (GenericApiService<Regions>):
        return GenericApiService<Regions>(
          endPoint: '/regions',
          fromJson: Regions.fromJson,
        );

      case const (GenericApiService<Roles>):
        return GenericApiService<Roles>(
          endPoint: '/roles',
          fromJson: Roles.fromJson,
        );

      case const (GenericApiService<Suppliers>):
        return GenericApiService<Suppliers>(
          endPoint: '/suppliers',
          fromJson: Suppliers.fromJson,
        );

      case const (GenericApiService<TaxRate>):
        return GenericApiService<TaxRate>(
          endPoint: '/taxRate',
          fromJson: TaxRate.fromJson,
        );

      case const (GenericApiService<UserModuleAuthority>):
        return GenericApiService<UserModuleAuthority>(
          endPoint: '/userModuleAuthority',
          fromJson: UserModuleAuthority.fromJson,
        );

      case const (GenericApiService<Users>):
        return GenericApiService<Users>(
          endPoint: '/users',
          fromJson: Users.fromJson,
        );

      case const (GenericApiService<Warehouses>):
        return GenericApiService<Warehouses>(
          endPoint: '/warehouses',
          fromJson: Warehouses.fromJson,
        );

      default:
        throw Exception('Undefined service type: $T');
    }
  }

  Future<void> disposeService<T>() async {
    try {
      if (_services.containsKey(T)) {
        await _services[T].dispose();
        _services.remove(T);
      }
    } catch (e) {
      if (kDebugMode) print('DisposeService Error for $T: $e');
      rethrow;
    }
  }

  Future<void> disposeAll() async {
    try {
      for (var service in _services.values) {
        await service.dispose();
      }
      _services.clear();
    } catch (e) {
      if (kDebugMode) print('DisposeAll Error: $e');
      rethrow;
    }
  }

  bool isServiceInitialized<T>() {
    return _services.containsKey(T);
  }
}
