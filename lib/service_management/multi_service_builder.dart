import 'package:backend/base/models.dart';
import 'package:backend/models/index.dart';
import 'package:backend/service/generic_api_service.dart';
import 'package:flutter/material.dart';
import '../service_management/service_manager.dart';

class ServiceResponse<T extends BaseModel<T>> {
  final GenericApiService<T> service;
  final List<T> data;

  ServiceResponse({required this.service, required this.data});
}

class MultiServiceBuilder extends StatefulWidget {
  final List<Type> serviceTypes;
  final Widget Function(BuildContext context, Map<Type, dynamic> services) builder;
  final Widget? loadingWidget;
  final Widget Function(BuildContext context, String error)? errorBuilder;

  const MultiServiceBuilder({
    Key? key,
    required this.serviceTypes,
    required this.builder,
    this.loadingWidget,
    this.errorBuilder,
  }) : super(key: key);

  @override
  State<MultiServiceBuilder> createState() => _MultiServiceBuilderState();
}

class _MultiServiceBuilderState extends State<MultiServiceBuilder> {
  late Map<Type, Future<dynamic>> _serviceFutures;

  @override
  void initState() {
    super.initState();
    _initServices();
  }

  void _initServices() {
    _serviceFutures = {};
    for (var type in widget.serviceTypes) {
      switch (type) {
        case const (GenericApiService<Authorities>):
          _serviceFutures[type] = _initializeService<Authorities>();
        case const (GenericApiService<Brands>):
          _serviceFutures[type] = _initializeService<Brands>();
        case const (GenericApiService<Categories>):
          _serviceFutures[type] = _initializeService<Categories>();
        case const (GenericApiService<CategoriesSub>):
          _serviceFutures[type] = _initializeService<CategoriesSub>();
        case const (GenericApiService<Cities>):
          _serviceFutures[type] = _initializeService<Cities>();
        case const (GenericApiService<Companies>):
          _serviceFutures[type] = _initializeService<Companies>();
        case const (GenericApiService<CompanyUserRegions>):
          _serviceFutures[type] = _initializeService<CompanyUserRegions>();
        case const (GenericApiService<CompanyUserRole>):
          _serviceFutures[type] = _initializeService<CompanyUserRole>();
        case const (GenericApiService<CompanyUserWarehouses>):
          _serviceFutures[type] = _initializeService<CompanyUserWarehouses>();
        case const (GenericApiService<Countries>):
          _serviceFutures[type] = _initializeService<Countries>();
        case const (GenericApiService<Logger>):
          _serviceFutures[type] = _initializeService<Logger>();
        case const (GenericApiService<Modules>):
          _serviceFutures[type] = _initializeService<Modules>();
        case const (GenericApiService<Plans>):
          _serviceFutures[type] = _initializeService<Plans>();
        case const (GenericApiService<ProductMovement>):
          _serviceFutures[type] = _initializeService<ProductMovement>();
        case const (GenericApiService<ProductUnits>):
          _serviceFutures[type] = _initializeService<ProductUnits>();
        case const (GenericApiService<Products>):
          _serviceFutures[type] = _initializeService<Products>();
        case const (GenericApiService<ProjectCode>):
          _serviceFutures[type] = _initializeService<ProjectCode>();
        case const (GenericApiService<ReferenceCode>):
          _serviceFutures[type] = _initializeService<ReferenceCode>();
        case const (GenericApiService<Regions>):
          _serviceFutures[type] = _initializeService<Regions>();
        case const (GenericApiService<Roles>):
          _serviceFutures[type] = _initializeService<Roles>();
        case const (GenericApiService<Suppliers>):
          _serviceFutures[type] = _initializeService<Suppliers>();
        case const (GenericApiService<TaxRate>):
          _serviceFutures[type] = _initializeService<TaxRate>();
        case const (GenericApiService<UserModuleAuthority>):
          _serviceFutures[type] = _initializeService<UserModuleAuthority>();
        case const (GenericApiService<Users>):
          _serviceFutures[type] = _initializeService<Users>();
        case const (GenericApiService<Warehouses>):
          _serviceFutures[type] = _initializeService<Warehouses>();
      }
    }
  }

  Future<ServiceResponse<T>> _initializeService<T extends BaseModel<T>>() async {
    final service = await ServiceManager().getService<GenericApiService<T>>(runtimeType);
    final data = await service.getAll();
    return ServiceResponse(service: service, data: data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<Type, dynamic>>(
      future: Future.wait(_serviceFutures.values).then(
        (results) => Map.fromIterables(widget.serviceTypes, results),
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          if (widget.errorBuilder != null) {
            return widget.errorBuilder!(context, snapshot.error.toString());
          }
          return Center(child: Text('Hata: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return widget.loadingWidget ?? const Center(child: CircularProgressIndicator());
        }

        return widget.builder(context, snapshot.data!);
      },
    );
  }

  void refresh() {
    if (mounted) {
      setState(() {
        _initServices();
      });
    }
  }
}
