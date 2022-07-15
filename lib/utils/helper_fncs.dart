import 'package:intl/intl.dart';

final currencyFormat = NumberFormat("#,##0.00", "en_US");

String displayPrice(num value,
    {bool isCents = true, String currency = 'USD', NumberFormat? format}) {
  currency = currency.toUpperCase();
  final val = isCents ? value / 100.0 : value;
  return '$currency ${(format ?? currencyFormat).format(val)}';
}

extension EnumExtension on Object {
  String get enumName {
    return toString().split('.')[1];
  }
}

extension MapExtension on Map {
  Map removeNulls() {
    List<dynamic> _keysToRemove = [];

    for (final k in keys) {
      if (this[k] == null) _keysToRemove.add(k);
    }

    if (_keysToRemove.isNotEmpty) {
      for (final _k in _keysToRemove) {
        remove(_k);
      }
    }

    return this;
  }
}
