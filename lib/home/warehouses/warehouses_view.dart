import 'package:backend/backend.dart';
import 'package:backend/service/cities_service.dart';
import 'package:backend/service/regions_services.dart';
import 'package:backend/service/warehouses_services.dart';
import 'package:flutter/material.dart';
import 'package:widgets/index.dart';

part 'warehouses_view_model.dart';

class WarehousesView extends StatefulWidget {
  const WarehousesView({super.key});

  @override
  WarehousesViewState createState() => WarehousesViewState();
}

class WarehousesViewState extends State<WarehousesView>
    with WarehousesViewModel {
  @override
  Widget build(BuildContext context) {
    return context.responsiveWrapper(
      small: _buildMobileLayout(context),
      medium: _buildTabletLayout(context),
      large: _buildDesktopLayout(context),
    );
  }

  //------------------------------------------------------------------------
  Widget _addWarehouses() {
    return FloatingActionButton(
      backgroundColor: Colors.black87,
      onPressed: createWarehouse,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Widget _warehousesGridList() {
    return SizedBox(
      height: context.cardHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          context.responsiveGridView(
            crossAxiscount: 1,
            padding: EdgeInsets.all(context.smallPadding),
            childAspectRatio: 1,
            children: List.generate(
              10,
              (index) {
                return context.myCard(
                  onTap: () {},
                  title: 'Card',
                  subtitle: 'Subtitle',
                  icon: Icons.warehouse,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _warehousesDetails() {
    return Card(
      color: Colors.black87,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Warehouse',
              style: TextStyle(
                fontSize: context.bodySize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ).paddingLeft(context.smallPadding),
        ],
      ),
    );
  }

  //------------------------------------------------------------------------

  Widget _buildMobileLayout(BuildContext context) {
    return const Scaffold();
  }

  Widget _buildTabletLayout(BuildContext context) {
    return const Scaffold();
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 12,
            child: Column(
              children: [
                Row(
                  children: [
                    context
                        .mySubheadingText(text: 'Warehouses')
                        .paddingLeft(context.smallPadding),
                    Spacer(),
                    _addWarehouses().paddingRight(context.smallPadding),
                  ],
                ),
                _warehousesGridList(),
                Expanded(
                  child: _warehousesDetails().paddingAll(context.smallPadding),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
