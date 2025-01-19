extension StringNullExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

extension ValueCheck on String {

  bool isLength(int length) {
    if (isNullOrEmpty) return false;
    if (length != this.length) return false;
    return true;
  }

  bool minLength(int min) {
    if (isNullOrEmpty) return false;
    if (min > length) return false;
    return true;
  }

  bool maxLength(int max) {
    if (isNullOrEmpty) return false;
    if (max < length) return false;
    return true;
  }

  bool isBetweenLength({int min = 0, int max = 100}) {
    if (isNullOrEmpty) return false;
    if (length < min || length > max) return false;
    return true;
  }



  bool get isNumber {
    RegExp numberRegex = RegExp(r'^-?[0-9]+$');
    return numberRegex.hasMatch(this);
  }

  bool get isIntValue {
    return int.tryParse(this) != null;
  }

  bool get isDoubleValue {
    return double.tryParse(this) != null;
  }

  bool get isBoolValue {
    return bool.tryParse(this) != null;
  }

  bool get isDateValue {
    return DateTime.tryParse(this) != null;
  }

  bool get isEmail {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);
  }

  bool isPhoneNumber() {
    return RegExp(r'^[0-9]{10}$').hasMatch(this);
  }

  bool isUrl() {
    return RegExp(r'^https?://[^\s/$.?#].[^\s]*$').hasMatch(this);
  }

  
}
