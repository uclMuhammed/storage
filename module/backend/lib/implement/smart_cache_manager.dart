import 'dart:async';

// Cache öncelik seviyeleri
enum CachePriority {
  low, // Uzun süre cache'de kalabilir
  medium, // Normal cache süresi
  high, // Kısa cache süresi
  critical // Çok kısa cache süresi
}

// Cache verisi sınıfı
class CacheData {
  final dynamic data;
  final DateTime timestamp;
  final CachePriority priority;
  int accessCount = 0;
  DateTime lastAccessed;

  CacheData({
    required this.data,
    required this.timestamp,
    required this.priority,
  }) : lastAccessed = DateTime.now();

  bool isValid(Duration timeout) {
    return DateTime.now().difference(timestamp) < timeout;
  }

  void accessed() {
    accessCount++;
    lastAccessed = DateTime.now();
  }
}

// Cache ayarları sınıfı
class CacheSettings {
  final int maxSize;
  final Duration defaultTimeout;
  final Duration criticalDataTimeout;
  final Duration cleanupInterval;
  final int maxMemoryUsage;

  const CacheSettings({
    this.maxSize = 100,
    this.defaultTimeout = const Duration(minutes: 5),
    this.criticalDataTimeout = const Duration(minutes: 1),
    this.cleanupInterval = const Duration(minutes: 15),
    this.maxMemoryUsage = 50 * 1024 * 1024, // 50 MB
  });
}

// Cache metrikleri sınıfı
class CacheMetrics {
  int hits = 0;
  int misses = 0;
  int writes = 0;
  int evictions = 0;
  int expirations = 0;
  Duration totalAccessTime = Duration.zero;
  int accessCount = 0;

  double calculateHitRate() {
    final total = hits + misses;
    return total > 0 ? hits / total : 0;
  }

  Duration get averageAccessTime {
    return accessCount > 0 ? totalAccessTime ~/ accessCount : Duration.zero;
  }

  int get estimatedMemoryUsage => 0;

  void recordRead(String key) {
    hits++;
    accessCount++;
  }

  void recordWrite(String key, dynamic data) {
    writes++;
  }

  void recordEviction(String key) {
    evictions++;
  }

  void recordExpiration(String key) {
    expirations++;
  }

  void updatePerformanceMetrics() {}
}

// Cache istatistikleri sınıfı
class CacheStats {
  final int totalItems;
  final double hitRate;
  final int memoryUsage;
  final Duration averageAccessTime;

  CacheStats({
    required this.totalItems,
    required this.hitRate,
    required this.memoryUsage,
    required this.averageAccessTime,
  });
}

// Akıllı Cache Yönetim Sistemi
class SmartCacheManager {
  // Singleton pattern
  static final SmartCacheManager _instance = SmartCacheManager._internal();
  factory SmartCacheManager() => _instance;
  SmartCacheManager._internal();

  // Cache veri yapısı
  final Map<String, CacheData> _cache = {};

  // Cache ayarları
  final _settings = const CacheSettings();

  // Cache durumu
  final _metrics = CacheMetrics();

  // Cache'e veri ekleme
  Future<void> set(
    String key,
    dynamic data, {
    CachePriority priority = CachePriority.medium,
    Duration? customTimeout,
  }) async {
    // Cache boyut kontrolü
    _checkAndCleanIfNeeded();

    // Veriyi cache'e ekle
    _cache[key] = CacheData(
      data: data,
      timestamp: DateTime.now(),
      priority: priority,
    );

    // Metrikleri güncelle
    _metrics.recordWrite(key, data);
  }

  // Cache'den veri silme
  Future<void> invalidate(String key) async {
    _cache.remove(key);
  }

  // Cache'den veri okuma
  Future<T?> get<T>(String key) async {
    final cachedData = _cache[key];
    if (cachedData == null) return null;

    // Timeout kontrolü
    if (!_isDataValid(cachedData)) {
      _cache.remove(key);
      return null;
    }

    // Kullanım metriklerini güncelle
    cachedData.accessed();
    _metrics.recordRead(key);

    return cachedData.data as T;
  }

  // Akıllı veri geçerlilik kontrolü
  bool _isDataValid(CacheData data) {
    final timeout = _getTimeoutForPriority(data.priority);
    return data.isValid(timeout);
  }

  // Önceliğe göre timeout süresi belirleme
  Duration _getTimeoutForPriority(CachePriority priority) {
    switch (priority) {
      case CachePriority.low:
        return _settings.defaultTimeout * 2;
      case CachePriority.medium:
        return _settings.defaultTimeout;
      case CachePriority.high:
        return _settings.defaultTimeout ~/ 2;
      case CachePriority.critical:
        return _settings.criticalDataTimeout;
    }
  }

  // Akıllı cache temizleme
  void _checkAndCleanIfNeeded() {
    if (_cache.length < _settings.maxSize) return;

    // En az kullanılan ve en eski verileri temizle
    final itemsToRemove = _cache.entries.toList()
      ..sort((a, b) {
        // Öncelik, kullanım sayısı ve son kullanım zamanına göre sırala
        if (a.value.priority != b.value.priority) {
          return a.value.priority.index - b.value.priority.index;
        }
        if (a.value.accessCount != b.value.accessCount) {
          return a.value.accessCount - b.value.accessCount;
        }
        return a.value.lastAccessed.compareTo(b.value.lastAccessed);
      });

    final itemsToRemoveCount = (_cache.length - _settings.maxSize) + 1;
    for (var i = 0; i < itemsToRemoveCount && i < itemsToRemove.length; i++) {
      _cache.remove(itemsToRemove[i].key);
      _metrics.recordEviction(itemsToRemove[i].key);
    }
  }

  // Otomatik cache yönetimi başlatma
  void startAutoManagement() {
    // Periyodik temizlik
    Timer.periodic(_settings.cleanupInterval, (_) {
      _performMaintenance();
    });

    // Bellek kullanımı kontrolü
    Timer.periodic(const Duration(minutes: 5), (_) {
      _checkMemoryUsage();
    });
  }

  // Cache bakımı
  void _performMaintenance() {
    // Süresi geçmiş verileri temizle
    _cache.removeWhere((key, data) {
      final isExpired = !_isDataValid(data);
      if (isExpired) _metrics.recordExpiration(key);
      return isExpired;
    });

    // Performans metriklerini güncelle
    _metrics.updatePerformanceMetrics();
  }

  // Bellek kullanımı kontrolü
  void _checkMemoryUsage() {
    if (_metrics.estimatedMemoryUsage > _settings.maxMemoryUsage) {
      _reduceMemoryUsage();
    }
  }

  // Akıllı veri yenileme
  Future<T> getOrFetch<T>(
    String key,
    Future<T> Function() fetchFunction, {
    CachePriority priority = CachePriority.medium,
    Duration? customTimeout,
  }) async {
    // Önce cache'den kontrol et
    final cachedData = await get<T>(key);
    if (cachedData != null) return cachedData;

    // Veriyi API'dan al
    final newData = await fetchFunction();

    // Cache'e kaydet
    await set(
      key,
      newData,
      priority: priority,
      customTimeout: customTimeout,
    );

    return newData;
  }

  // Cache metrikleri
  Future<CacheStats> getStats() async {
    return CacheStats(
      totalItems: _cache.length,
      hitRate: _metrics.calculateHitRate(),
      memoryUsage: _metrics.estimatedMemoryUsage,
      averageAccessTime: _metrics.averageAccessTime,
    );
  }

  void _reduceMemoryUsage() {
    // En az kullanılan verilerin %20'sini temizle
    final itemsToRemove = (_cache.length * 0.2).ceil();
    final sortedItems = _cache.entries.toList()
      ..sort((a, b) => a.value.accessCount.compareTo(b.value.accessCount));

    for (var i = 0; i < itemsToRemove && i < sortedItems.length; i++) {
      _cache.remove(sortedItems[i].key);
      _metrics.recordEviction(sortedItems[i].key);
    }
  }
}
