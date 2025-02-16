import '../models/time_filter_model.dart';

class TimeFilterData {
  static List<TimeFilterModel> timeFiltersData = [
    TimeFilterModel(
      text: '1 GÜN',
      startDate: DateTime.now().subtract(
        const Duration(days: 1),
      ),
      endDate: DateTime.now(),
      isSelected: false,
    ),
    TimeFilterModel(
      text: '1 HAFTA',
      startDate: DateTime.now().subtract(
        const Duration(days: 7),
      ),
      endDate: DateTime.now(),
      isSelected: false,
    ),
    TimeFilterModel(
      text: '1 AY',
      startDate: DateTime.now().subtract(
        const Duration(days: 30),
      ),
      endDate: DateTime.now(),
      isSelected: false,
    ),
    TimeFilterModel(
      text: '3 AY',
      startDate: DateTime.now().subtract(
        const Duration(days: 90),
      ),
      endDate: DateTime.now(),
      isSelected: false,
    ),
    TimeFilterModel(
      text: '6 AY',
      startDate: DateTime.now().subtract(
        const Duration(days: 180),
      ),
      endDate: DateTime.now(),
      isSelected: false,
    ),
    TimeFilterModel(
      text: '1 YIL',
      startDate: DateTime.now().subtract(
        const Duration(days: 365),
      ),
      endDate: DateTime.now(),
      isSelected: false,
    ),
  ];
}
