import 'package:backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:widgets/base/base_view_model.dart';
import 'package:dio/dio.dart';

class CategoryViewModel extends BaseViewModel {
  // API Services
  late final ServiceAuthClient _serviceAuthClient;
  late final SmartApiService<Categories> _categoryService;
  bool _isInitialized = false;
  Future<void>? _initializationFuture;

  // State Management
  final categories = ValueNotifier<List<Categories>>([]);
  final subCategories = ValueNotifier<List<CategoriesSub>>([]);
  final selectedCategory = ValueNotifier<Categories?>(null);
  final selectedSubCategory = ValueNotifier<CategoriesSub?>(null);
  final _loadingNotifier = ValueNotifier<bool>(false);
  final error = ValueNotifier<String?>(null);

  // Getters
  ValueNotifier<bool> get loadingNotifier => _loadingNotifier;
  SmartApiService<Categories> get categoryService => _categoryService;

  @override
  bool get isLoading => _loadingNotifier.value;
  set isLoading(bool value) {
    _loadingNotifier.value = value;
    if (value) error.value = null;
  }

  @override
  void init() {
    initializeServices().then((_) => _loadCategories());
    _setupListeners();
  }

  void _setupListeners() {
    selectedCategory.addListener(() {
      selectedSubCategory.value = null;
      if (selectedCategory.value != null) {
        _loadSubCategories(selectedCategory.value!.id!);
      } else {
        subCategories.value = [];
      }
    });
  }

  Future<void> initializeServices() async {
    if (_isInitialized) return;
    _initializationFuture ??= _initialize();
    return _initializationFuture;
  }

  Future<void> _initialize() async {
    try {
      _serviceAuthClient = ServiceAuthClient();
      await _serviceAuthClient.init();

      final headers = await _getHeaders();
      _categoryService = _createService<Categories>(
        ApiEndpoints.categories,
        Categories.fromJson,
        (category) => category.toJson(),
        headers,
      );

      _isInitialized = true;
    } catch (e) {
      _handleError('Servisler başlatılırken hata oluştu', e);
      rethrow;
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    try {
      final token = await _serviceAuthClient.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('Oturum açmanız gerekiyor');
      }

      final authHeaders = await _serviceAuthClient.getAuthHeaders();
      return {
        ...authHeaders,
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
    } catch (e) {
      _handleError('Kimlik doğrulama hatası', e);
      rethrow;
    }
  }

  SmartApiService<T> _createService<T extends IModel>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic> Function(T) toJson,
    Map<String, String> headers,
  ) {
    return SmartApiService<T>(
      fromJson: fromJson,
      toJson: toJson,
      endPoint: endpoint,
      baseUrl: StockTrackerApiUrl,
      header: headers,
    );
  }

  Future<SmartApiService<CategoriesSub>> _createSubCategoryService(
      int categoryId) async {
    try {
      final headers = await _getHeaders();
      return _createService<CategoriesSub>(
        '${ApiEndpoints.categoriesSub}/$categoryId',
        CategoriesSub.fromJson,
        (subCategory) => subCategory.toJson(),
        headers,
      );
    } catch (e) {
      _handleError('Alt kategori servisi oluşturulurken hata', e);
      rethrow;
    }
  }

  void _handleError(String message, dynamic error) {
    if (error is DioException) {
      final response = error.response;
      if (response?.statusCode == 401) {
        this.error.value = 'Oturum süreniz dolmuş. Lütfen tekrar giriş yapın.';
      } else if (response?.statusCode == 404) {
        this.error.value = 'İstenilen kayıt bulunamadı.';
      } else {
        this.error.value =
            '$message: ${response?.statusMessage ?? error.message}';
      }
    } else {
      this.error.value = '$message: $error';
    }
  }

  Future<void> _loadCategories() async {
    try {
      isLoading = true;
      final updatedCategories =
          await _categoryService.getAll(priority: CachePriority.high);
      categories.value = updatedCategories;

      if (categories.value.isNotEmpty && selectedCategory.value == null) {
        selectedCategory.value = categories.value.first;
      }
    } catch (e) {
      _handleError('Kategoriler yüklenirken hata oluştu', e);
      categories.value = [];
      selectedCategory.value = null;
    } finally {
      isLoading = false;
    }
  }

  Future<void> _loadSubCategories(int categoryId) async {
    try {
      isLoading = true;
      final service = await _createSubCategoryService(categoryId);
      final response = await service.getAll(priority: CachePriority.high);

      subCategories.value = response;
      if (subCategories.value.isEmpty) {
        error.value = 'Bu kategoriye ait alt kategori bulunamadı';
      }
    } catch (e) {
      _handleError('Alt kategoriler yüklenirken hata oluştu', e);
      subCategories.value = [];
      selectedSubCategory.value = null;
    } finally {
      isLoading = false;
    }
  }

  Future<void> refresh() async {
    try {
      isLoading = true;
      await _loadCategories();

      if (selectedCategory.value != null) {
        await _loadSubCategories(selectedCategory.value!.id!);
      }
    } catch (e) {
      _handleError('Veriler yenilenirken hata oluştu', e);
    } finally {
      isLoading = false;
    }
  }

  Future<void> createCategory(String name) async {
    try {
      isLoading = true;
      final newCategory = Categories.insert(name);
      final createdCategory = await _categoryService.create(newCategory);
      await refresh();
      selectedCategory.value = createdCategory;
    } catch (e) {
      _handleError('Kategori oluşturulurken hata oluştu', e);
    } finally {
      isLoading = false;
    }
  }

  Future<void> createSubCategory(String name, int categoryId) async {
    try {
      isLoading = true;
      final service = await _createSubCategoryService(categoryId);
      final newSubCategory = CategoriesSub(
        id: 0,
        description: name,
        categoryId: categoryId,
        categorySub: 0,
        companyId: 0,
        isActive: true,
        isDelete: false,
      );

      final createdSubCategory = await service.create(newSubCategory);
      await _loadSubCategories(categoryId);
      selectedSubCategory.value = createdSubCategory;
    } catch (e) {
      _handleError('Alt kategori oluşturulurken hata oluştu', e);
    } finally {
      isLoading = false;
    }
  }

  Future<void> updateCategory(String name) async {
    try {
      if (selectedCategory.value == null) return;

      isLoading = true;
      final updatedCategory = Categories(
        id: selectedCategory.value!.id,
        description: name,
        category: selectedCategory.value!.category,
        companyId: selectedCategory.value!.companyId,
        isActive: selectedCategory.value!.isActive,
        isDelete: selectedCategory.value!.isDelete,
      );

      await _categoryService.updateById(updatedCategory.id!, updatedCategory);
      await refresh();
      selectedCategory.value = updatedCategory;
    } catch (e) {
      _handleError('Kategori güncellenirken hata oluştu', e);
    } finally {
      isLoading = false;
    }
  }

  Future<void> updateSubCategory(String name) async {
    try {
      if (selectedSubCategory.value == null || selectedCategory.value == null) {
        return;
      }

      isLoading = true;
      final categoryId = selectedCategory.value!.id!;
      final service = await _createSubCategoryService(categoryId);

      final updatedSubCategory = CategoriesSub(
        id: selectedSubCategory.value!.id,
        description: name,
        categoryId: categoryId,
        categorySub: selectedSubCategory.value!.categorySub,
        companyId: selectedSubCategory.value!.companyId,
        isActive: selectedSubCategory.value!.isActive,
        isDelete: selectedSubCategory.value!.isDelete,
      );

      final result = await service.updateById(
          selectedSubCategory.value!.id!, updatedSubCategory);
      await _loadSubCategories(categoryId);
      selectedSubCategory.value = result;
    } catch (e) {
      _handleError('Alt kategori güncellenirken hata oluştu', e);
    } finally {
      isLoading = false;
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      isLoading = true;
      await _categoryService.deleteById(id);

      if (selectedCategory.value?.id == id) {
        selectedCategory.value = null;
        subCategories.value = [];
      }

      await refresh();
    } catch (e) {
      _handleError('Kategori silinirken hata oluştu', e);
    } finally {
      isLoading = false;
    }
  }

  Future<void> deleteSubCategory() async {
    try {
      if (selectedSubCategory.value == null || selectedCategory.value == null) {
        return;
      }

      isLoading = true;
      final categoryId = selectedCategory.value!.id!;
      final service = await _createSubCategoryService(categoryId);

      await service.deleteById(selectedSubCategory.value!.id!);
      selectedSubCategory.value = null;
      await _loadSubCategories(categoryId);
    } catch (e) {
      _handleError('Alt kategori silinirken hata oluştu', e);
    } finally {
      isLoading = false;
    }
  }
}
