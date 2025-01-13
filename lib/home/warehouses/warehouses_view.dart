import 'package:backend/backend.dart';
import 'package:backend/service/cities_service.dart';
import 'package:backend/service/regions_services.dart';
import 'package:backend/service/warehouses_services.dart';
import 'package:flutter/foundation.dart';
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints size) {
        return context.responsiveWrapper(
          small: _buildMobileLayout(context, size),
          medium: _buildTabletLayout(context, size),
          large: _buildDesktopLayout(context, size),
        );
      },
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
    return FutureBuilder<List<Warehouses>>(
      future: getAllWarehouses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Henüz depo bulunmamaktadır'));
        }

        final warehouses = snapshot.data!;

        return SizedBox(
          height: context.cardHeight,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              context.responsiveGridView(
                crossAxiscount: 1,
                padding: EdgeInsets.all(context.smallPadding),
                childAspectRatio: 1,
                children: warehouses
                    .map(
                      (warehouse) => InkWell(
                        onTap: () async {
                          await getWarehouseById(warehouse.id);
                          await getRegionsById(selectedWarehouse!.regionId);
                          await getCitiesById(selectedWarehouse!.cityId);
                          setState(() {});
                        },
                        child: context.myCard(
                          title: warehouse.description,
                          subtitle: warehouse.address,
                          icon: Icons.warehouse,
                          isSelected: selectedWarehouse?.id == warehouse.id,
                          onTap: () async {
                            await getWarehouseById(warehouse.id);
                            await getRegionsById(selectedWarehouse!.regionId);
                            await getCitiesById(selectedWarehouse!.cityId);
                            setState(() {});
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _warehousesDetails(BoxConstraints size) {
    if (selectedWarehouse == null) {
      return const Center(
        child: Text('Lütfen bir depo seçin'),
      );
    }

    return FutureBuilder<void>(
      future: Future.wait([
        getRegionsById(selectedWarehouse!.regionId),
        getCitiesById(selectedWarehouse!.cityId),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return Container(
          width: size.maxWidth,
          color: Colors.black87,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(
                  Icons.warehouse,
                  color: Colors.white,
                  size: context.iconSize,
                ),
                title: context.mySubheadingText(text: 'Depo Adı'),
                subtitle: context.myText(
                    text: selectedWarehouse?.description ?? '',
                    textAlign: TextAlign.start),
              ),
              ListTile(
                leading: Icon(
                  Icons.location_city,
                  color: Colors.white,
                  size: context.iconSize,
                ),
                title: context.mySubheadingText(text: 'Bölge'),
                subtitle: context.myText(
                    text: selectedRegion?.description ?? 'Yükleniyor...',
                    textAlign: TextAlign.start),
              ),
              ListTile(
                leading: Icon(
                  Icons.map,
                  color: Colors.white,
                  size: context.iconSize,
                ),
                title: context.mySubheadingText(text: 'Şehir'),
                subtitle: context.myText(
                    text: selectedCity?.description ?? 'Yükleniyor...',
                    textAlign: TextAlign.start),
              ),
              ListTile(
                leading: Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: context.iconSize,
                ),
                title: context.mySubheadingText(text: 'Adres'),
                subtitle: context.myText(
                    text: selectedWarehouse?.address ?? '',
                    textAlign: TextAlign.start),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () => editWarehouse(selectedWarehouse!),
                    child: const Icon(
                      Icons.edit,
                    ),
                  ).paddingAll(context.smallPadding),
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: () => deleteWarehouse(selectedWarehouse!),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ).paddingAll(context.smallPadding),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  //------------------------------------------------------------------------

  Widget _buildMobileLayout(BuildContext context, BoxConstraints size) {
    return Expanded(
      flex: 12,
      child: Column(
        children: [
          Row(
            children: [
              context
                  .mySubheadingText(text: 'Warehouses')
                  .paddingLeft(context.smallPadding),
              const Spacer(),
              _addWarehouses().paddingRight(context.smallPadding),
            ],
          ),
          _warehousesGridList(),
          Expanded(
            child: _warehousesDetails(size).paddingAll(context.smallPadding),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, BoxConstraints size) {
    return _buildDesktopLayout(context, size);
  }

  Widget _buildDesktopLayout(BuildContext context, BoxConstraints size) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    context
                        .mySubheadingText(text: 'Warehouses')
                        .paddingLeft(context.smallPadding),
                    const Spacer(),
                    _addWarehouses().paddingRight(context.smallPadding),
                  ],
                ),
                _warehousesGridList(),
                Expanded(
                  child:
                      _warehousesDetails(size).paddingAll(context.smallPadding),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
