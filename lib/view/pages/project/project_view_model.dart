import 'package:backend/backend.dart';
import 'package:flutter/foundation.dart';
import 'package:widgets/base/base_view_model.dart';

class ProjectViewModel extends BaseViewModel {
  late final ServiceAuthClient _serviceAuthClient;
  late final SmartApiService<ProjectCode> _projectsService;
  bool _isInitialized = false;

  //value notifier
  final projects = ValueNotifier<List<ProjectCode>>([]);

  final selectedProject = ValueNotifier<ProjectCode?>(null);

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

      _projectsService = SmartApiService<ProjectCode>(
        fromJson: ProjectCode.fromJson,
        toJson: (p) => p.toJson(),
        endPoint: ApiEndpoints.projects,
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
      final projectsData =
          await _projectsService.getAll(priority: CachePriority.high);
      projects.value = projectsData;

      if (projectsData.isNotEmpty && selectedProject.value == null) {
        selectedProject.value = projectsData.first;
      }
    } catch (e) {
      error.value = 'Proje verisi yüklenemedi: $e';
      if (kDebugMode) {
        print('Proje verisi yüklenirken hata: $e');
      }
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> createProject(
    String description,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      setLoading(true);
      final project = ProjectCode.insert(
        description,
        startDate,
        endDate,
      );
      await _projectsService.create(project);
      await _loadData();
      selectedProject.value = projects.value.firstWhere(
        (p) => p.id == project.id,
        orElse: () => project,
      );
    } catch (e) {
      error.value = 'Proje oluşturulamadı: $e';
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateProject(int id, String description) async {
    try {
      setLoading(true);
      final project = ProjectCode.update(id, description);
      await _projectsService.updateById(id, project);
      await _loadData();
      if (selectedProject.value != null) {
        selectedProject.value = projects.value.firstWhere(
          (p) => p.id == selectedProject.value!.id,
          orElse: () => ProjectCode.empty(),
        );
      }
    } catch (e) {
      error.value = 'Proje güncellenemedi: $e';
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteProject(int id) async {
    try {
      setLoading(true);
      await _projectsService.deleteById(id);
      await _loadData();
      if (selectedProject.value != null) {
        selectedProject.value = projects.value.firstWhere(
          (p) => p.id == selectedProject.value!.id,
          orElse: () => ProjectCode.empty(),
        );
      }
    } catch (e) {
      error.value = 'Proje silinemedi: $e';
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  @override
  void dispose() {
    projects.dispose();
    selectedProject.dispose();
    error.dispose();
    loadingNotifier.dispose();
    super.dispose();
  }
}
