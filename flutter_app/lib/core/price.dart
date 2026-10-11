import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String price(BuildContext context, int piastres) => NumberFormat.simpleCurrency(
  locale: Localizations.localeOf(context).toLanguageTag(),
  name: 'EGP',
).format(piastres / 100);
