class TimeFilterModel {
  final String text;
  final DateTime startDate;
  final DateTime endDate;
  final bool isSelected;

  TimeFilterModel({
    required this.text,
    required this.startDate,
    required this.endDate,
    required this.isSelected,
  });
}
