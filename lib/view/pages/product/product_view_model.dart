import 'package:backend/backend.dart';
import 'package:backend/errors/api_exception.dart';
import 'package:backend/errors/error_codes.dart';
import 'package:flutter/foundation.dart';
import 'package:widgets/base/base_view_model.dart';
import 'package:backend/errors/error_handler.dart';

class ProductViewModel extends BaseViewModel {
  late final ServiceAuthClient _serviceAuthClient;
  late final SmartApiService<Products> _productsService;
  late final SmartApiService<Brands> _brandsService;
  late final SmartApiService<Categories> _categoriesService;
  late final SmartApiService<ProductUnits> _productUnitsService;
  late SmartApiService<CategoriesSub> _categoriesSubService;
  bool _isInitialized = false;

  // ValueNotifier
  final products = ValueNotifier<List<Products>>([]);
  final brands = ValueNotifier<List<Brands>>([]);
  final categories = ValueNotifier<List<Categories>>([]);
  final categoriesSub = ValueNotifier<List<CategoriesSub>>([]);
  final productUnits = ValueNotifier<List<ProductUnits>>([]);

  final selectedProduct = ValueNotifier<Products?>(null);
  final selectedBrand = ValueNotifier<Brands?>(null);
  final selectedCategory = ValueNotifier<Categories?>(null);
  final selectedCategorySub = ValueNotifier<CategoriesSub?>(null);
  final selectedProductUnit = ValueNotifier<ProductUnits?>(null);

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

  int? brandIndex;
  int? categoryIndex;
  int? productUnitIndex;

  @override
  void init() {
    _initialize().then((_) => _loadData());
  }

  Future<void> _initialize() async {
    if (_isInitialized) return;

    try {
      _serviceAuthClient = ServiceAuthClient()..init();
      final token = await _serviceAuthClient.getToken();

      if (token == null) {
        throw ApiException(
          errorCode: ApiErrorCode.unauthorized,
          customMessage: 'Oturum süresi doldu',
        );
      }

      _productsService = SmartApiService<Products>(
        fromJson: Products.fromJson,
        toJson: (p) => p.toJson(),
        endPoint: ApiEndpoints.products,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      )..init();

      _brandsService = SmartApiService<Brands>(
        fromJson: Brands.fromJson,
        toJson: (b) => b.toJson(),
        endPoint: ApiEndpoints.brands,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      )..init();

      _categoriesService = SmartApiService<Categories>(
        fromJson: Categories.fromJson,
        toJson: (c) => c.toJson(),
        endPoint: ApiEndpoints.categories,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      )..init();

      _productUnitsService = SmartApiService<ProductUnits>(
        fromJson: ProductUnits.fromJson,
        toJson: (pu) => pu.toJson(),
        endPoint: ApiEndpoints.units,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      )..init();

      _categoriesSubService = SmartApiService<CategoriesSub>(
        fromJson: CategoriesSub.fromJson,
        toJson: (cs) => cs.toJson(),
        endPoint: ApiEndpoints.categoriesSub,
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      )..init();

      _isInitialized = true;
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      error.value = 'Servis başlatılamadı: $e';
      rethrow;
    }
  }

  Future<void> _loadData() async {
    try {
      setLoading(true);
      await _loadProducts();
      await _loadBrands();
      await _loadCategories();
      await _loadProductUnits();
    } catch (e) {
      error.value = 'Veriler yüklenirken hata oluştu: $e';
    } finally {
      setLoading(false);
    }
  }

  Future<void> _loadProducts() async {
    await ErrorHandler().handleError(
      operation: () async {
        final productsData = await _productsService.getAll(
          priority: CachePriority.high,
        );
        products.value = productsData;
        if (productsData.isNotEmpty && selectedProduct.value == null) {
          selectedProduct.value = productsData.first;
        }
      },
      context: context,
      customMessage: 'Ürünler yüklenirken bir hata oluştu',
    );
  }

  Future<void> _loadBrands() async {
    try {
      final brandsData =
          await _brandsService.getAll(priority: CachePriority.high);
      brands.value = brandsData;
    } catch (e) {
      if (kDebugMode) {
        print('Marka verisi yüklenirken hata: $e');
      }
      error.value = 'Marka verisi yüklenemedi: $e';
      rethrow;
    }
  }

  Future<void> _loadCategories() async {
    try {
      final categoriesData =
          await _categoriesService.getAll(priority: CachePriority.high);
      categories.value = categoriesData;
    } catch (e) {
      if (kDebugMode) {
        print('Kategori verisi yüklenirken hata: $e');
      }
      error.value = 'Kategori verisi yüklenemedi: $e';
      rethrow;
    }
  }

  Future<void> loadCategoriesSub(int categoryId) async {
    try {
      if (kDebugMode) {
        print('Alt kategoriler yükleniyor. Kategori ID: $categoryId');
      }

      categoriesSub.value = []; // Mevcut listeyi temizle

      final token = await _serviceAuthClient.getToken() ?? '';
      _categoriesSubService = SmartApiService<CategoriesSub>(
        fromJson: CategoriesSub.fromJson,
        toJson: (cs) => cs.toJson(),
        endPoint: '${ApiEndpoints.categoriesSub}/$categoryId',
        baseUrl: StockTrackerApiUrl,
        header: HeaderWithToken(token),
      )..init();

      final categoriesSubData =
          await _categoriesSubService.getAll(priority: CachePriority.high);

      if (kDebugMode) {
        print('Yüklenen alt kategoriler: $categoriesSubData');
      }

      categoriesSub.value = categoriesSubData;
    } catch (e) {
      if (kDebugMode) {
        print('Alt kategori verisi yüklenirken hata: $e');
      }
      error.value = 'Alt kategori verisi yüklenemedi: $e';
      rethrow;
    }
  }

  Future<void> _loadProductUnits() async {
    try {
      final unitsData =
          await _productUnitsService.getAll(priority: CachePriority.high);
      productUnits.value = unitsData;
    } catch (e) {
      if (kDebugMode) {
        print('Birim verisi yüklenirken hata: $e');
      }
      error.value = 'Birim verisi yüklenemedi: $e';
      rethrow;
    }
  }

  Future<void> createProduct(
    String barcode,
    String code,
    String description,
    int brandId,
    int categoryId,
    int categorySubId,
    int unitId,
    double price,
    String dimensions,
    double weight,
  ) async {
    try {
      setLoading(true);
      final product = Products.insert(
        barcode,
        code,
        description,
        brandId,
        categoryId,
        categorySubId,
        unitId,
        price,
        dimensions,
        weight,
      );
      await _productsService.create(product);
      await _loadData();
      selectedProduct.value = products.value.firstWhere(
        (p) => p.id == product.id,
        orElse: () => product,
      );
    } catch (e) {
      error.value = 'Ürün oluşturulamadı: $e';
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateProduct(
    int id,
    String barcode,
    String code,
    String description,
    int brandId,
    int categoryId,
    int categorySubId,
    int unitId,
    double price,
    String dimensions,
    double weight,
  ) async {
    try {
      setLoading(true);
      final product = Products.insert(
        barcode,
        code,
        description,
        brandId,
        categoryId,
        categorySubId,
        unitId,
        price,
        dimensions,
        weight,
      );
      await _productsService.updateById(id, product);
      await _loadData();
      selectedProduct.value = products.value.firstWhere(
        (p) => p.id == product.id,
        orElse: () => product,
      );
    } catch (e) {
      error.value = 'Ürün güncellenemedi: $e';
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteProduct(int id) async {
    await ErrorHandler().handleError(
      operation: () async {
        await _productsService.deleteById(id);
        if (selectedProduct.value?.id == id) {
          selectedProduct.value =
              products.value.isNotEmpty ? products.value.first : null;
        }
        await _loadData();
      },
      context: context,
      customMessage: 'Ürün silinirken bir hata oluştu',
      onError: () {
        setLoading(false);
        error.value = 'Ürün silinemedi';
      },
    );
  }

  @override
  void dispose() {
    products.dispose();
    brands.dispose();
    categories.dispose();
    productUnits.dispose();
    selectedProduct.dispose();
    selectedBrand.dispose();
    selectedCategory.dispose();
    selectedProductUnit.dispose();
    error.dispose();
    loadingNotifier.dispose();
    super.dispose();
  }
}
