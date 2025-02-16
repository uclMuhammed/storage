import 'package:backend/backend.dart';
import 'package:flutter/foundation.dart';
import 'package:widgets/base/base_view_model.dart';

class ProductMovementViewModel extends BaseViewModel {
  late final ServiceAuthClient _serviceAuthClient;
  late final SmartApiService<ProductMovement> _productMovementsService;
  late final SmartApiService<Products> _productsService;
  late final SmartApiService<ProjectCode> _projectsService;
  late final SmartApiService<ReferenceCode> _referenceService;
  late final SmartApiService<Warehouses> _warehousesService;
  late final SmartApiService<Suppliers> _suppliersService;
  late final SmartApiService<TaxRate> _taxesService;
  bool _isInitialized = false;

  //value notifier
  final productMovements = ValueNotifier<List<ProductMovement>>([]);
  final products = ValueNotifier<List<Products>>([]);
  final projects = ValueNotifier<List<ProjectCode>>([]);
  final reference = ValueNotifier<List<ReferenceCode>>([]);
  final warehouses = ValueNotifier<List<Warehouses>>([]);
  final suppliers = ValueNotifier<List<Suppliers>>([]);
  final taxes = ValueNotifier<List<TaxRate>>([]);

  final selectedProductMovement = ValueNotifier<ProductMovement?>(null);
  final selectedProduct = ValueNotifier<Products?>(null);
  final selectedProject = ValueNotifier<ProjectCode?>(null);
  final selectedReference = ValueNotifier<ReferenceCode?>(null);
  final selectedWarehouse = ValueNotifier<Warehouses?>(null);
  final selectedSupplier = ValueNotifier<Suppliers?>(null);
  final selectedTax = ValueNotifier<TaxRate?>(null);

  final error = ValueNotifier<String?>(null);
  final loadingNotifier = ValueNotifier<bool>(false);

  @override
  bool get isLoading => loadingNotifier.value;

  @override
  void setLoading(bool value) {
    loadingNotifier.value = value;
    if (value) error.value = null;
    notifyListeners();
  }

  @override
  void init() {
    _initServices().then((_) => _loadData());
  }

  Future<void> _initServices() async {
    if (_isInitialized) return;
    try {
      _serviceAuthClient = ServiceAuthClient()..init();
      final token = await _serviceAuthClient.getToken();
      if (token == null) throw Exception('Oturum açmanız gerekiyor');

      _productMovementsService = SmartApiService<ProductMovement>(
        fromJson: ProductMovement.fromJson,
        toJson: (p) => p.toJson(),
        endPoint: ApiEndpoints.productMovements,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      )..init();

      _productsService = SmartApiService<Products>(
        fromJson: Products.fromJson,
        toJson: (p) => p.toJson(),
        endPoint: ApiEndpoints.products,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      )..init();

      _projectsService = SmartApiService<ProjectCode>(
        fromJson: ProjectCode.fromJson,
        toJson: (p) => p.toJson(),
        endPoint: ApiEndpoints.projects,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      )..init();

      _referenceService = SmartApiService<ReferenceCode>(
        fromJson: ReferenceCode.fromJson,
        toJson: (p) => p.toJson(),
        endPoint: ApiEndpoints.references,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      )..init();

      _warehousesService = SmartApiService<Warehouses>(
        fromJson: Warehouses.fromJson,
        toJson: (p) => p.toJson(),
        endPoint: ApiEndpoints.warehouses,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      )..init();

      _suppliersService = SmartApiService<Suppliers>(
        fromJson: Suppliers.fromJson,
        toJson: (p) => p.toJson(),
        endPoint: ApiEndpoints.suppliers,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      )..init();

      _taxesService = SmartApiService<TaxRate>(
        fromJson: TaxRate.fromJson,
        toJson: (p) => p.toJson(),
        endPoint: ApiEndpoints.taxRates,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      )..init();

      _isInitialized = true;
    } catch (e) {
      error.value = 'Servis başlatılamadı: $e';
      rethrow;
    }
  }

  Future<void> _loadData() async {
    try {
      setLoading(true);
      await _loadProductMovements();
      await _loadProducts();
      await _loadProjects();
      await _loadReferences();
      await _loadWarehouses();
      await _loadSuppliers();
      await _loadTaxes();
    } catch (e) {
      error.value = 'Veriler yüklenirken hata oluştu: $e';
      if (kDebugMode) {
        print('Veri yükleme hatası: $e');
      }
    } finally {
      setLoading(false);
    }
  }

  Future<void> _loadProductMovements() async {
    try {
      final productMovementsData =
          await _productMovementsService.getAll(priority: CachePriority.high);
      productMovements.value = productMovementsData;

      if (productMovementsData.isNotEmpty &&
          selectedProductMovement.value == null) {
        selectedProductMovement.value = productMovementsData.first;
      }
    } catch (e) {
      error.value = 'Ürün hareketleri yüklenirken hata oluştu: $e';
      if (kDebugMode) {
        print('Ürün hareketleri yükleme hatası: $e');
      }
    }
  }

  Future<void> _loadProducts() async {
    try {
      final productsData =
          await _productsService.getAll(priority: CachePriority.high);
      products.value = productsData;
    } catch (e) {
      error.value = 'Ürünler yüklenirken hata oluştu: $e';
      if (kDebugMode) {
        print('Ürün yükleme hatası: $e');
      }
    }
  }

  Future<void> _loadProjects() async {
    try {
      final projectsData =
          await _projectsService.getAll(priority: CachePriority.high);
      projects.value = projectsData;
    } catch (e) {
      error.value = 'Proje kodları yüklenirken hata oluştu: $e';
      if (kDebugMode) {
        print('Proje kodları yükleme hatası: $e');
      }
    }
  }

  Future<void> _loadReferences() async {
    try {
      final referencesData =
          await _referenceService.getAll(priority: CachePriority.high);
      reference.value = referencesData;
    } catch (e) {
      error.value = 'Referans kodları yüklenirken hata oluştu: $e';
      if (kDebugMode) {
        print('Referans kodları yükleme hatası: $e');
      }
    }
  }

  Future<void> _loadWarehouses() async {
    try {
      final warehousesData =
          await _warehousesService.getAll(priority: CachePriority.high);
      warehouses.value = warehousesData;
    } catch (e) {
      error.value = 'Depolar yüklenirken hata oluştu: $e';
      if (kDebugMode) {
        print('Depolar yükleme hatası: $e');
      }
    }
  }

  Future<void> _loadSuppliers() async {
    try {
      final suppliersData =
          await _suppliersService.getAll(priority: CachePriority.high);
      suppliers.value = suppliersData;
    } catch (e) {
      error.value = 'Tedarikçiler yüklenirken hata oluştu: $e';
      if (kDebugMode) {
        print('Tedarikçiler yükleme hatası: $e');
      }
    }
  }

  Future<void> _loadTaxes() async {
    try {
      final taxesData =
          await _taxesService.getAll(priority: CachePriority.high);
      taxes.value = taxesData;
    } catch (e) {
      error.value = 'Vergi oranları yüklenirken hata oluştu: $e';
      if (kDebugMode) {
        print('Vergi oranları yükleme hatası: $e');
      }
    }
  }

  Future<void> createProductMovement(
    int warehouseId,
    String warehouseName,
    int supplierId,
    int productId,
    int price,
    double quantity,
    int taxId,
    DateTime transactionDate,
    String documentNo,
    String description,
    int projectId,
    int referenceId,
    bool isPurchases,
    bool isReturn,
  ) async {
    try {
      setLoading(true);
      final productMovement = ProductMovement.insert(
        warehouseId,
        warehouseName,
        supplierId,
        productId,
        price,
        quantity,
        taxId,
        transactionDate,
        documentNo,
        description,
        projectId,
        referenceId,
        isPurchases,
        isReturn,
      );
      await _productMovementsService.create(productMovement);
      await _loadData();
      selectedProductMovement.value = productMovements.value.firstWhere(
        (p) => p.id == productMovement.id,
        orElse: () => productMovement,
      );
    } catch (e) {
      error.value = 'Ürün hareketi oluşturulamadı: $e';
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateProductMovement(
    int id,
    String warehouseName,
    int warehouseId,
    int supplierId,
    int productId,
    int price,
    double quantity,
    int taxId,
    DateTime transactionDate,
    String documentNo,
    String description,
    int projectId,
    int referenceId,
    bool isPurchases,
    bool isReturn,
  ) async {
    try {
      setLoading(true);
      final productMovement = ProductMovement.update(
        warehouseId,
        warehouseName,
        supplierId,
        productId,
        price,
        quantity,
        taxId,
        transactionDate,
        documentNo,
        description,
        projectId,
        referenceId,
        isPurchases,
        isReturn,
      );
      await _productMovementsService.updateById(id, productMovement);
      await _loadData();
      selectedProductMovement.value = productMovements.value.firstWhere(
        (p) => p.id == productMovement.id,
        orElse: () => productMovement,
      );
    } catch (e) {
      error.value = 'Ürün hareketi güncellenemedi: $e';
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteProductMovement(int id) async {
    try {
      setLoading(true);
      await _productMovementsService.deleteById(id);
      await _loadData();
      if (selectedProductMovement.value?.id == id) {
        selectedProductMovement.value = productMovements.value.isNotEmpty
            ? productMovements.value.first
            : null;
      }
    } catch (e) {
      error.value = 'Ürün hareketi silinemedi: $e';
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  @override
  void dispose() {
    productMovements.dispose();
    products.dispose();
    projects.dispose();
    reference.dispose();
    warehouses.dispose();
    suppliers.dispose();
    taxes.dispose();
    selectedProductMovement.dispose();
    selectedProduct.dispose();
    selectedProject.dispose();
    selectedReference.dispose();
    selectedWarehouse.dispose();
    selectedSupplier.dispose();
    selectedTax.dispose();
    error.dispose();
    loadingNotifier.dispose();
    super.dispose();
  }
}
