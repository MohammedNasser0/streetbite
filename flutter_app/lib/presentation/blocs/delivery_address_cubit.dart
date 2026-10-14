import 'package:flutter_bloc/flutter_bloc.dart';

/// A session draft shared by Home and Checkout; never persisted across accounts.
class DeliveryAddressCubit extends Cubit<Map<String, String>?> {
  DeliveryAddressCubit() : super(null);

  void select(Map<String, String> address) => emit(Map.unmodifiable(address));
  void clear() => emit(null);
}
