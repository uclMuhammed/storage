import 'dart:convert';
import 'package:backend/backend.dart';
import 'package:backend/models/product_stats.dart';
import 'package:backend/service/brands_service.dart';
import 'package:backend/service/categories_service.dart';
import 'package:backend/service/categories_sub_service.dart';
import 'package:backend/service/cities_service.dart';
import 'package:backend/service/companies_services.dart';
import 'package:backend/service/company_user_regions_services.dart';
import 'package:backend/service/company_user_role_services.dart';
import 'package:backend/service/company_user_warehouses_services.dart';
import 'package:backend/service/countries_services.dart';
import 'package:backend/service/logger_services.dart';
import 'package:backend/service/modules_services.dart';
import 'package:backend/service/plans_services.dart';
import 'package:backend/service/product_movement_services.dart';
import 'package:backend/service/product_services.dart';
import 'package:backend/service/product_stats_services.dart';
import 'package:backend/service/product_units_services.dart';
import 'package:backend/service/project_code_services.dart';
import 'package:backend/service/reference_code_services.dart';
import 'package:backend/service/regions_services.dart';
import 'package:backend/service/roles_services.dart';
import 'package:backend/service/suppliers_services.dart';
import 'package:backend/service/tax_rate_services.dart';
import 'package:backend/service/users_services.dart';
import 'package:backend/service/warehouses_services.dart';
import 'package:flutter/material.dart';
import 'package:storage/auth/auth_manager/auth_manager.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  // Services
  final authoritiesService = AuthoritiesService();
  final brandsService = BrandsService();
  final categoriesService = CategoriesService();
  final categoriesSubService = CategoriesSubService();
  final citiesService = CitiesService();
  final companiesServices = CompaniesServices();
  final companyUserRegionsServices = CompanyUserRegionsServices();
  final companyUserRoleServices = CompanyUserRoleServices();
  final companyUserWarehousesServices = CompanyUserWarehousesServices();
  final countriesServices = CountriesServices();
  final loggerServices = LoggerServices();
  final modulesServices = ModulesServices();
  final plansServices = PlansServices();
  final productMovementService = ProductMovementService();
  final productServices = ProductServices();
  final productStatsServices = ProductStatsServices();
  final productUnitsServices = ProductUnitsServices();
  final projectCodeServices = ProjectCodeServices();
  final referenceCodeServices = ReferenceCodeServices();
  final regionsServices = RegionsServices();
  final rolesServices = RolesServices();
  final suppliersServices = SuppliersServices();
  final taxRateServices = TaxRateServices();
  final usersServices = UsersServices();
  final warehousesServices = WarehousesServices();

  // Loading states
  bool isLoading = false;
  String currentOperation = '';

  String result = '';

  void printDebug(String title, dynamic data) {
    final separator = '=' * 50;
    debugPrint('\n$separator');
    debugPrint('📌 $title');
    debugPrint(separator);
    if (data != null) {
      try {
        final jsonString = const JsonEncoder.withIndent('  ').convert(data);
        debugPrint(jsonString);
      } catch (e) {
        debugPrint(data.toString());
      }
    } else {
      debugPrint('No data returned (null)');
    }
    debugPrint('$separator\n');
  }

  @override
  void initState() {
    super.initState();
    initializeServices();
  }

  Future<void> initializeServices() async {
    setState(() {
      isLoading = true;
      currentOperation = 'Initializing services...';
    });

    try {
      await Future.wait([
        authoritiesService.init(),
        brandsService.init(),
        categoriesService.init(),
        categoriesSubService.init(),
        citiesService.init(),
        companiesServices.init(),
        companyUserRegionsServices.init(),
        companyUserRoleServices.init(),
        companyUserWarehousesServices.init(),
        countriesServices.init(),
        loggerServices.init(),
        modulesServices.init(),
        plansServices.init(),
        productMovementService.init(),
        productServices.init(),
        productStatsServices.init(),
        productUnitsServices.init(),
        projectCodeServices.init(),
        referenceCodeServices.init(),
        regionsServices.init(),
        rolesServices.init(),
        suppliersServices.init(),
        taxRateServices.init(),
        usersServices.init(),
        warehousesServices.init(),
      ]);

      setState(() {
        result = 'All services initialized successfully';
      });
    } catch (e) {
      setState(() {
        result = 'Error initializing services: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
        currentOperation = '';
      });
    }
  }

  Future<void> testService(
      String serviceName, Future<void> Function() test) async {
    setState(() {
      isLoading = true;
      currentOperation = 'Testing $serviceName...';
      result = '';
    });

    try {
      await test();
      setState(() {
        result = '$serviceName test completed successfully';
      });
    } catch (e) {
      setState(() {
        result = '$serviceName test failed: $e';
      });
      printDebug('$serviceName Error', {'error': e.toString()});
    } finally {
      setState(() {
        isLoading = false;
        currentOperation = '';
      });
    }
  }

  Widget buildTestButton(String serviceName, Future<void> Function() test) {
    return ElevatedButton(
      onPressed: isLoading ? null : () => testService(serviceName, test),
      child: Text('Test $serviceName'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services Test Page'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isLoading) ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(currentOperation, textAlign: TextAlign.center),
            ],
            if (result.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(8),
                color: result.contains('Error') || result.contains('failed')
                    ? Colors.red[100]
                    : Colors.green[100],
                child: Text(
                  result,
                  style: TextStyle(
                    color: result.contains('Error') || result.contains('failed')
                        ? Colors.red[900]
                        : Colors.green[900],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                buildTestButton('authoritiesServices-init', () async {
                  authoritiesService.init();
                  AuthManager().checkLoginStatus();
                  AuthManager().login(
                      companyCode: 87823,
                      email: 'test33@gmail.com',
                      password: 'testpass');
                }),
                buildTestButton('productMovementServices-create', () async {
                  final data = ProductMovement.insert(
                      12,
                      5,
                      6,
                      200,
                      200,
                      26,
                      DateTime.now(),
                      'TEST_DOCUMENT',
                      'TEST_PRODUCT_MOVEMENT',
                      11,
                      13,
                      false,
                      true);
                  printDebug(
                    'productMovementServices-create',
                    await productMovementService.create(data),
                  );
                }),
                buildTestButton('productMovementServices-update', () async {
                  final data = ProductMovement.update(
                    12,
                    5,
                    6,
                    200,
                    200,
                    26,
                    DateTime.now(),
                    'TEST_DOCUMENT_UPDATE',
                    'TEST_PRODUCT_MOVEMENT_UPDATE',
                    11,
                    13,
                    false,
                    false,
                  );
                  printDebug(
                    'productMovementServices-update',
                    await productMovementService.update(7, data),
                  );
                }),
                buildTestButton('productMovementServices-delete', () async {
                  printDebug(
                    'productMovementServices-delete',
                    await productMovementService.delete(7),
                  );
                }),
                buildTestButton('productMovementServices-getall', () async {
                  printDebug(
                    'productMovementServices-getall',
                    await productMovementService.getAll(),
                  );
                }),
                buildTestButton('productMovementServices-getbyid', () async {
                  printDebug(
                    'productMovementServices-getbyid',
                    await productMovementService.getById(7),
                  );
                }),
                //-------------------------------------------------------------
                const SizedBox(
                  width: 200,
                  height: 50,
                ),
                //-------------------------------------------------------------
                buildTestButton('referenceCode-getall', () async {
                  printDebug(
                    'referenceCode-getall',
                    await referenceCodeServices.getAll(),
                  );
                }),
                buildTestButton('referenceCode-getbyid', () async {
                  printDebug(
                    'referenceCode-getbyid',
                    await referenceCodeServices.getById(14),
                  );
                }),
                buildTestButton('referenceCode-create', () async {
                  final data = ReferenceCode.insert(
                    'testReferenceCodeDescription',
                  );
                  printDebug('referenceCode-create',
                      await referenceCodeServices.create(data));
                }),
                buildTestButton('referenceCode-update', () async {
                  final data = ReferenceCode.update(
                    1,
                    'testReferenceCodeDescriptionUpdate',
                  );
                  printDebug('referenceCode-update',
                      await referenceCodeServices.update(14, data));
                }),
                buildTestButton('referenceCode-delete', () async {
                  printDebug(
                    'referenceCode-delete',
                    await referenceCodeServices.delete(14),
                  );
                }),

                //-------------------------------------------------------
                const SizedBox(
                  height: 50,
                  width: 200,
                ),
                //-------------------------------------------------------
                buildTestButton('procjectCode-getall', () async {
                  printDebug(
                    'procjectCode-getall',
                    await projectCodeServices.getAll(),
                  );
                }),
                buildTestButton('procjectCode-getbyid', () async {
                  printDebug(
                    'procjectCode-getbyid',
                    await projectCodeServices.getById(2),
                  );
                }),
                buildTestButton('procjectCode-create', () async {
                  final data = ProjectCode.insert(
                    'testProjectCodeDescription',
                  );
                  printDebug('procjectCode-create',
                      await projectCodeServices.create(data));
                }),
                buildTestButton('procjectCode-update', () async {
                  final data = ProjectCode.update(
                    1,
                    'testProjectCodeDescriptionUpdate',
                  );
                  printDebug('procjectCode-update',
                      await projectCodeServices.update(7, data));
                }),
                buildTestButton('procjectCode-delete', () async {
                  printDebug(
                    'procjectCode-delete',
                    await projectCodeServices.delete(8),
                  );
                }),
                //-------------------------------------------------------
                const SizedBox(
                  width: 200,
                  height: 50,
                ),
                //-------------------------------------------------------
                buildTestButton('testRoles-getall', () async {
                  printDebug('testRoles-getall', await rolesServices.getAll());
                }),
                buildTestButton('testRoles-getbyid', () async {
                  printDebug(
                    'testRoles-getbyid',
                    await rolesServices.getById(1),
                  );
                }),
                buildTestButton('testRoles-create', () async {
                  final data = Roles.insert(
                    'testRoledescription',
                  );
                  printDebug(
                      'testRoles-create', await rolesServices.create(data));
                }),
                buildTestButton('testRoles-update', () async {
                  final data = Roles.update(
                    1,
                    'testRoleDescriptionUpdate',
                  );
                  printDebug(
                      'testRoles-update', await rolesServices.update(1, data));
                }),
                buildTestButton('testRoles-delete', () async {
                  printDebug('testRoles-delete', await rolesServices.delete(1));
                }),
                //-------------------------------------------------------
                const SizedBox(
                  width: 200,
                  height: 50,
                ),
                //-------------------------------------------------------
                buildTestButton('taxRateServices-getall', () async {
                  printDebug(
                      'taxRateServices-getall', await taxRateServices.getAll());
                }),
                buildTestButton('taxRateServices-getbyid', () async {
                  printDebug('taxRateServices-getbyid',
                      await taxRateServices.getById(20));
                }),
                buildTestButton('taxRateServices-create', () async {
                  final data = TaxRate.insert(
                    33,
                    'testTaxRateName40',
                  );
                  printDebug('taxRateServices-create',
                      await taxRateServices.create(data));
                }),
                buildTestButton('taxRateServices-update', () async {
                  final data = TaxRate.update(
                    18,
                    21,
                    'testTaxRateNameUpdate',
                  );
                  printDebug('taxRateServices-update',
                      await taxRateServices.update(20, data));
                }),
                buildTestButton('taxRateServices-delete', () async {
                  printDebug('taxRateServices-delete',
                      await taxRateServices.delete(20));
                }),
                //-------------------------------------------------------
                const SizedBox(
                  width: 200,
                  height: 50,
                ),
                //-------------------------------------------------------
                buildTestButton('suppliersServices-getall', () async {
                  printDebug('suppliersServices-getall',
                      await suppliersServices.getAll());
                }),
                buildTestButton('suppliersServices-getbyid', () async {
                  printDebug('suppliersServices-getbyid',
                      await suppliersServices.getById(2));
                }),
                buildTestButton('suppliersServices-create', () async {
                  final data = Suppliers.insert(
                      'testSuppliersName',
                      'testSuppliersAdress',
                      '222',
                      '05459784461',
                      'muho@muho.com',
                      11);
                  printDebug('suppliersServices-create',
                      await suppliersServices.create(data));
                }),
                buildTestButton('suppliersServices-update', () async {
                  final data = Suppliers.update(
                      3,
                      'testSuppliersNameUpdate',
                      11,
                      'testSuppliersAdressUpdate',
                      '222',
                      '05459784461',
                      'muho@muho.com');
                  printDebug('suppliersServices-update',
                      await suppliersServices.update(2, data));
                }),
                buildTestButton('suppliersServices-delete', () async {
                  printDebug('suppliersServices-delete',
                      await suppliersServices.delete(2));
                }),
                //-------------------------------------------------------------
                const SizedBox(
                  width: 200,
                  height: 50,
                ),
                //-------------------------------------------------------------
                buildTestButton('regionsServices-getall', () async {
                  final data = await regionsServices.getAll();
                  printDebug('regionsServices-getall', data);
                }),
                buildTestButton('regionsServices-getbyid', () async {
                  final data = await regionsServices.getById(12);
                  printDebug('regionsServices-getbyid', data);
                }),
                buildTestButton('regionsServices-create', () async {
                  final data = Regions.insert('testRegions');
                  printDebug('regionsServices-create',
                      await regionsServices.create(data));
                }),
                buildTestButton('regionsServices-update', () async {
                  final data = Regions.update(12, 'testRegionsUpdate');
                  printDebug('regionsServices-update',
                      await regionsServices.update(12, data));
                }),
                buildTestButton('regionsServices-delete', () async {
                  printDebug('regionsServices-delete',
                      await regionsServices.delete(12));
                }),
                //-------------------------------------------------------------
                const SizedBox(
                  width: 200,
                  height: 50,
                ),
                //-------------------------------------------------------------
                buildTestButton('warehousesServices-getall', () async {
                  final data = await warehousesServices.getAll();
                  printDebug('warehousesServices-getall', data);
                }),
                buildTestButton('warehousesServices-getbyid', () async {
                  final data = await warehousesServices.getById(7);
                  printDebug('warehousesServices-getbyid', data);
                }),
                buildTestButton('warehousesServices-create', () async {
                  final data =
                      Warehouses.insert('testWarehouses', 12, 1, 'şurda işte');
                  printDebug('warehousesServices-create',
                      await warehousesServices.create(data));
                }),
                buildTestButton('warehousesServices-update', () async {
                  final data = Warehouses.insert(
                      'testWarehousesUpdate', 12, 1, 'şurda işte');
                  printDebug('warehousesServices-update',
                      await warehousesServices.update(7, data));
                }),
                buildTestButton('warehousesServices-delete', () async {
                  printDebug('warehousesServices-delete',
                      await warehousesServices.delete(7));
                }),
                //-------------------------------------------------------------
                const SizedBox(
                  width: 200,
                  height: 50,
                ),
                //-------------------------------------------------------------
                buildTestButton('productMovementServices-create', () async {
                  final model = ProductMovement.insert(
                    12,
                    1,
                    13,
                    20,
                    1000,
                    26,
                    DateTime(1950),
                    '23',
                    'testProductMovement',
                    11,
                    13,
                    true,
                    false,
                  );
                  printDebug('productMovementServices-create',
                      await productMovementService.create(model));
                }),
                buildTestButton('productMovementServices-getall', () async {
                  printDebug('productMovementServices-getall',
                      await productMovementService.getAll());
                }),
                buildTestButton('productMovementServices-getbyid', () async {
                  printDebug('productMovementServices-getbyid',
                      await productMovementService.getById(9));
                }),
                buildTestButton('productMovementServices-update', () async {
                  final model = ProductMovement.insert(
                      12,
                      1,
                      6,
                      20,
                      20,
                      26,
                      DateTime(1950),
                      '23',
                      'testProductMovementUpdate',
                      11,
                      13,
                      false,
                      false);
                  printDebug('productMovementServices-update',
                      await productMovementService.update(9, model));
                }),
                buildTestButton('productMovementServices-delete', () async {
                  printDebug('productMovementServices-delete',
                      await productMovementService.delete(9));
                }),

                //-------------------------------------------------------------
                const SizedBox(
                  width: 200,
                  height: 50,
                ),
                //-------------------------------------------------------------
                buildTestButton('productsstatsServices-getall', () async {
                  printDebug('productsstatsServices-getall',
                      await productStatsServices.getAll());
                }),
                buildTestButton('productsstatsServices-getbyid', () async {
                  printDebug('productsstatsServices-getbyid',
                      await productStatsServices.getById(11));
                }),
                buildTestButton('productsstatsServices-create', () async {
                  //productStatsServices.setProductId(11);
                  final model = ProductStats.insert(11);
                  printDebug('productsstatsServices-create',
                      await productStatsServices.create(model));
                }),

                //-------------------------------------------------------------
                const SizedBox(
                  width: 200,
                  height: 50,
                ),
                //-------------------------------------------------------------
                buildTestButton('productsUnitsServices-create', () async {
                  final model = ProductUnits.insert('ProductUnits', 200);
                  printDebug('productsUnitsServices-create',
                      await productUnitsServices.create(model));
                }),
                buildTestButton('productsUnitsServices-getall', () async {
                  printDebug('productsUnitsServices-getall',
                      await productUnitsServices.getAll());
                }),
                buildTestButton('productsUnitsServices-getbyid', () async {
                  printDebug('productsUnitsServices-getbyid',
                      await productUnitsServices.getById(16));
                }),
                buildTestButton('productsUnitsServices-update', () async {
                  final update =
                      ProductUnits.update('ProductUnitsUpdate', 200, true);
                  printDebug('productsUnitsServices-update',
                      await productUnitsServices.update(16, update));
                }),
                buildTestButton('productsUnitsServices-delete', () async {
                  printDebug('productsUnitsServices-delete',
                      await productUnitsServices.delete(16));
                }),
                //-------------------------------------------------------------
                const SizedBox(
                  width: 200,
                  height: 50,
                ),
                //-------------------------------------------------------------
                buildTestButton('productsServices-create', () async {
                  final model = Products.insert(
                      '15', '1', 'testProducts1', 112, 83, 18, 2500, '200', 2);
                  printDebug('productsServices-create',
                      await productServices.create(model));
                }),
                buildTestButton('productsServices-getall', () async {
                  final response = await productServices.getAll();
                  printDebug('productsServices-getall', response);
                }),
                buildTestButton('productsServices-getbyid', () async {
                  final response = await productServices.getById(1);
                  printDebug('productsServices-getbyid', response);
                }),
                buildTestButton('productsServices-update', () async {
                  final model = Products.update('2', '1', 'testProductsUpdate',
                      111, 80, 12, 2500, '200', 2);
                  printDebug('productsServices-update',
                      await productServices.update(1, model));
                }),
                buildTestButton('productsServices-delete', () async {
                  printDebug('productsServices-delete',
                      await productServices.delete(1));
                }),
                //-------------------------------------------------------------
                const SizedBox(
                  width: 200,
                  height: 50,
                ),
                //-------------------------------------------------------------
                buildTestButton('plansServices-create', () async {
                  final model = Plans.insert('Plans');
                  printDebug('plansServices-create',
                      await plansServices.create(model));
                }),
                buildTestButton('plansServices-getall', () async {
                  final response = await plansServices.getAll();
                  printDebug('plansServices-getall', response);
                }),
                buildTestButton('plansServices-getbyid', () async {
                  final response = await plansServices.getById(1);
                  printDebug('plansServices-getbyid', response);
                }),
                buildTestButton('plansServices-update', () async {
                  final model = Plans.insert('Plans');
                  printDebug('plansServices-update',
                      await plansServices.update(1, model));
                }),
                buildTestButton('plansServices-delete', () async {
                  printDebug(
                      'plansServices-delete', await plansServices.delete(1));
                }),
                //-------------------------------------------------------------
                const SizedBox(
                  width: 200,
                  height: 50,
                ),
                //-------------------------------------------------------------
                buildTestButton('modulesServices-create', () async {
                  final model = Modules.insert('Modules1');
                  printDebug(
                    'modulesServices-create',
                    await modulesServices.create(model),
                  );
                }),
                buildTestButton('modulesServices-getall', () async {
                  final response = await modulesServices.getAll();
                  printDebug('modulesServices-getall', response);
                }),
                buildTestButton('modulesServices-getbyid', () async {
                  final response = await modulesServices.getById(26);
                  printDebug('modulesServices-getbyid', response);
                }),
                buildTestButton('modulesServices-update', () async {
                  final model = Modules.insert('Modules');
                  printDebug(
                    'modulesServices-update',
                    await modulesServices.update(26, model),
                  );
                }),
                buildTestButton('modulesServices-delete', () async {
                  printDebug(
                    'modulesServices-delete',
                    await modulesServices.delete(26),
                  );
                }),
                //-------------------------------------------------------------
                const SizedBox(
                  width: 200,
                  height: 50,
                ),
                //-------------------------------------------------------------
                buildTestButton('Countries-getall', () async {
                  final response = await countriesServices.getAll();
                  printDebug('Countries', response);
                }),
                buildTestButton('Countries-getbyid', () async {
                  final response = await countriesServices.getById(1);
                  printDebug('Countries', response);
                }),
                buildTestButton('Countries-create', () async {
                  final model = Countries.insert('Turkey', 1);
                  printDebug(
                    'Countries-create',
                    await countriesServices.create(model),
                  );
                }),
                buildTestButton('Countries-update', () async {
                  final model = Countries.insert('Turkey', 1);
                  printDebug(
                    'Countries-update',
                    await countriesServices.update(1, model),
                  );
                }),
                buildTestButton('Countries-delete', () async {
                  printDebug(
                    'Countries-delete',
                    await countriesServices.delete(1),
                  );
                }),
                //-------------------------------------------------------------
                buildTestButton('authoritiesServices', () async {}),
                buildTestButton('regionsServices', () async {
                  final response = await regionsServices.getAll();
                  printDebug('regionsServices', response);
                }),
                buildTestButton('comanyUserRegionsService-create', () async {
                  final model = CompanyUserRegions.insert(1, 1, 1);
                  printDebug(
                    'comanyUserRegionsService-create',
                    await companyUserRegionsServices.create(model),
                  );
                }),
                //-------------------------------------------------------------
                const SizedBox(
                  width: 200,
                  height: 50,
                ),
                //-------------------------------------------------------------
                buildTestButton('roles', () async {
                  final response = await rolesServices.getAll();
                  printDebug('roles', response);
                }),
                //-------------------------------------------------------------
                Container(
                  width: 200,
                ),
                //-------------------------------------------------------------
                buildTestButton('companyUserRole-create', () async {
                  final model = CompanyUserRole(
                    userID: 0,
                    companyID: 0,
                    roleID: 7,
                    id: 0,
                    isActive: true,
                    isDelete: false,
                  );
                  final response = await companyUserRoleServices.create(model);
                  printDebug('companyUserRole-create', response);
                }),
                //-------------------------------------------------------------
                const SizedBox(
                  width: 200,
                  height: 50,
                ),
                //-------------------------------------------------------------
                buildTestButton('CitiesService-create', () async {
                  citiesService.setCountryId(1);
                  final model = Cities.insert('testCities', 1);
                  printDebug(
                    'CitiesService-create',
                    await citiesService.create(model),
                  );
                }),
                buildTestButton('CitiesService-getAll', () async {
                  citiesService.setCountryId(1);
                  printDebug(
                    'CitiesService-getAll',
                    await citiesService.getAll(),
                  );
                }),
                buildTestButton('CitiesService-update', () async {
                  citiesService.setCountryId(1);
                  final update = Cities.update(1, 'testCitiesupdate');
                  printDebug(
                    'CitiesService-update',
                    await citiesService.update(1, update),
                  );
                }),
                buildTestButton('CitiesService-GetById', () async {
                  citiesService.setCountryId(1);
                  printDebug(
                    'CitiesService-GetById',
                    await citiesService.getById(1),
                  );
                }),
                buildTestButton('CitiesService-delete', () async {
                  citiesService.setCountryId(1);
                  printDebug(
                    'CitiesService-delete',
                    await citiesService.delete(1),
                  );
                }),
                //----------------------------------------------
                const SizedBox(
                  width: 200,
                  height: 50,
                ),
                //------------------CategoriesSubService------------------
                buildTestButton('CategoriesSubService-Create', () async {
                  categoriesSubService.setCategoryId(77);
                  final model = CategoriesSub.insert('testCategoriesSub', 77);
                  printDebug('CategoriesSubService-Create',
                      await categoriesSubService.create(model));
                }),
                buildTestButton('CategoriesSubService-getAll', () async {
                  categoriesSubService.setCategoryId(77);
                  printDebug('CategoriesSubService-getAll',
                      await categoriesSubService.getAll());
                }),
                buildTestButton('CategoriesSubService-update', () async {
                  categoriesSubService.setCategoryId(77);
                  final update =
                      CategoriesSub.update('testCategoriesSubupdate', 77);
                  printDebug(
                    'CategoriesSubService-update',
                    await categoriesSubService.update(42, update),
                  );
                }),
                buildTestButton('CategoriesSubService-GetById', () async {
                  categoriesSubService.setCategoryId(77);
                  printDebug(
                    'CategoriesSubService-GetById',
                    await categoriesSubService.getById(41),
                  );
                }),
                buildTestButton('CategoriesSubService-delete', () async {
                  categoriesSubService.setCategoryId(77);
                  printDebug(
                    'CategoriesSubService-delete',
                    await categoriesSubService.delete(42),
                  );
                }),
                //-----------------------------------------------------------
                const SizedBox(
                  width: 200,
                  height: 50,
                ),
                //-----------------------------------------------------------
                buildTestButton('CategoriesService-create', () async {
                  final model = Categories.insert('testCategories');
                  await categoriesService.create(model);
                }),
                buildTestButton('CategoriesService-getAll', () async {
                  await categoriesService.getAll();
                  printDebug(
                    'CategoriesService-getAll',
                    await categoriesService.getAll(),
                  );
                }),
                buildTestButton('CategoriesService-update', () async {
                  final update =
                      Categories.update('testCategoriesupdate', true);
                  printDebug(
                    'CategoriesService-getById',
                    await categoriesService.update(77, update),
                  );
                }),
                buildTestButton('CategoriesService-GetById', () async {
                  printDebug('', await categoriesService.getById(77));
                }),
                buildTestButton('CategoriesService-delete', () async {
                  await categoriesService.delete(78);
                }),
                //-----------------------------------------------------------
                const SizedBox(
                  width: 200,
                  height: 50,
                ),
                //-----------------------------------------------------------
                buildTestButton('AuthoritiesService-Create', () async {
                  final model = Authorities.insert(
                      'adsawadsa', false, false, false, false);
                  await authoritiesService.create(model);
                }),
                buildTestButton('AuthoritiesService-GetAll', () async {
                  await authoritiesService.getAll();
                }),
                buildTestButton('AuthoritiesService-GetById', () async {
                  await authoritiesService.getById(3);
                }),
                buildTestButton('AuthoritiesService-Update', () async {
                  final model = Authorities.update(
                      'adsawadsa', false, false, false, false);
                  await authoritiesService.update(3, model);
                }),
                buildTestButton('AuthoritiesService-Delete', () async {
                  await authoritiesService.delete(3);
                }),
                //-----------------------------------------------------------
                const SizedBox(
                  width: 200,
                  height: 50,
                ),
                //-----------------------------------------------------------
                buildTestButton('BrandsService-GetAll', () async {
                  printDebug(
                      'BrandsService-GetAll', await brandsService.getAll());
                }),
                buildTestButton('BrandsService-GetById', () async {
                  printDebug('BrandsService-GetById',
                      await brandsService.getById(110));
                }),
                buildTestButton('BrandsService-Create', () async {
                  final model = Brands.insert('TestBrandsUpdated');
                  printDebug('BrandsService-Create',
                      await brandsService.create(model));
                }),
                buildTestButton('BrandsService-Update', () async {
                  final model = Brands.update(92, 'TestBrandsUpdated');
                  printDebug('BrandsService-Update',
                      await brandsService.update(92, model));
                }),
                buildTestButton('BrandsService-Delete', () async {
                  printDebug(
                      'BrandsService-Delete', await brandsService.delete(110));
                })
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose all services
    authoritiesService.dispose();
    brandsService.dispose();
    categoriesService.dispose();
    categoriesSubService.dispose();
    citiesService.dispose();
    companiesServices.dispose();
    companyUserRegionsServices.dispose();
    companyUserRoleServices.dispose();
    companyUserWarehousesServices.dispose();
    countriesServices.dispose();
    loggerServices.dispose();
    modulesServices.dispose();
    plansServices.dispose();
    productMovementService.dispose();
    productServices.dispose();
    productStatsServices.dispose();
    productUnitsServices.dispose();
    projectCodeServices.dispose();
    referenceCodeServices.dispose();
    regionsServices.dispose();
    rolesServices.dispose();
    suppliersServices.dispose();
    taxRateServices.dispose();
    usersServices.dispose();
    warehousesServices.dispose();
    super.dispose();
  }
}
