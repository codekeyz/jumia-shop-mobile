import 'package:intl/intl.dart';

final currencyFormat = NumberFormat("#,##0.00", "en_US");

String displayPrice(num value,
    {bool isCents = true, String currency = 'GHS', NumberFormat? format}) {
  currency = currency.toUpperCase();
  final val = isCents ? value / 100.0 : value;
  return '$currency ${(format ?? currencyFormat).format(val)}';
}

extension EnumExtension on Object {
  String get enumName {
    return toString().split('.')[1];
  }
}
