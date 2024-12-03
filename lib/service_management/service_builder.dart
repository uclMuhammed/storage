import 'package:backend/base/models.dart';
import 'package:backend/service/generic_api_service.dart';
import 'package:flutter/material.dart';
import 'package:storage/service_management/service_manager.dart';

class ServiceBuilder<T extends BaseModel<T>> extends StatefulWidget {
  final Widget Function(BuildContext context, GenericApiService<T> service) builder;
  final Widget? loadingWidget;
  final Widget Function(BuildContext context, String error)? errorBuilder;

  const ServiceBuilder({
    super.key,
    required this.builder,
    this.loadingWidget,
    this.errorBuilder,
  });

  @override
  State<ServiceBuilder<T>> createState() => _ServiceBuilderState<T>();
}

class _ServiceBuilderState<T extends BaseModel<T>> extends State<ServiceBuilder<T>> {
  late Future<GenericApiService<T>> _serviceFuture;

  @override
  void initState() {
    super.initState();
    _serviceFuture = ServiceManager().getService<GenericApiService<T>>(runtimeType);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GenericApiService<T>>(
      future: _serviceFuture,
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

        return widget.builder(context, snapshot.data as GenericApiService<T>);
      },
    );
  }
}
