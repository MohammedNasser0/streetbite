// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get invalidCredentials => 'Email or password is incorrect.';

  @override
  String get emailInUse =>
      'An account already uses this email. Log in instead.';

  @override
  String get authThrottled => 'Too many attempts. Please wait and try again.';

  @override
  String get authNetworkError =>
      'Cannot connect. Check your internet and try again.';

  @override
  String get authNotEnabled =>
      'Email sign-in is currently unavailable. Please try later.';

  @override
  String get accountDisabled => 'This account is disabled. Contact support.';

  @override
  String get appName => 'StreetBite';

  @override
  String get home => 'Home';

  @override
  String get search => 'Search meals';

  @override
  String get offers => 'Hot offers';

  @override
  String get recommended => 'Recommended';

  @override
  String get cart => 'Cart';

  @override
  String get add => 'Add to cart';

  @override
  String get added => 'Added to your cart';

  @override
  String get emptyCart => 'Your cart is empty';

  @override
  String get remove => 'Remove';

  @override
  String get total => 'Total';

  @override
  String get instructions => 'Instructions';

  @override
  String get retry => 'Try again';

  @override
  String get networkError =>
      'Could not load meals. Check your connection and try again.';

  @override
  String get noMeals => 'No meals found';

  @override
  String get demoPrices => 'Demonstration prices • Recipes by TheMealDB';

  @override
  String get welcome => 'Good food, wherever you are.';

  @override
  String get start => 'Explore meals';

  @override
  String get language => 'العربية';

  @override
  String get theme => 'Change theme';

  @override
  String get featured => 'Discover something delicious';

  @override
  String get details => 'Meal details';

  @override
  String get email => 'Email';

  @override
  String get favourites => 'Favourites';

  @override
  String get vendors => 'Nearby vendors';

  @override
  String get nameError => 'Enter a name starting with a capital letter';

  @override
  String get passwordError => 'Use at least six characters';

  @override
  String get password => 'Password';

  @override
  String get placeOrder => 'Place demo order';

  @override
  String get mapsSetup => 'Configure a Google Maps key to see the map.';

  @override
  String get firebaseSetup =>
      'Account features need StreetBite Firebase configuration.';

  @override
  String get cash => 'Cash on delivery';

  @override
  String get changePhoto => 'Change photo';

  @override
  String get orderPlaced => 'Order placed';

  @override
  String get profile => 'Profile';

  @override
  String get login => 'Log in';

  @override
  String get authError =>
      'Could not sign in. Check your details and connection.';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get unlockProfile => 'Unlock profile with fingerprint';

  @override
  String get biometricUnavailable =>
      'Biometrics unavailable. Set up fingerprint on a supported device.';

  @override
  String get confirmError => 'Passwords must match';

  @override
  String get logout => 'Log out';

  @override
  String get unsave => 'Remove favourite';

  @override
  String get orders => 'Order history';

  @override
  String get signup => 'Create account';

  @override
  String get fullName => 'Full name';

  @override
  String get visibility => 'Password visibility';

  @override
  String get save => 'Save favourite';

  @override
  String get demoVendors => 'Illustrative vendor locations';

  @override
  String get card => 'Demo card payment';

  @override
  String get photoError => 'Could not update photo. Try a smaller image.';

  @override
  String get emailError => 'Enter a valid email';

  @override
  String get orderReceived => 'Order received';

  @override
  String get vendorCairo => 'Cairo Bite';

  @override
  String get vendorAlexandria => 'Alexandria Bite';

  @override
  String get vendorLuxor => 'Luxor Bite';

  @override
  String get vendorAswan => 'Aswan Bite';

  @override
  String get vendorHurghada => 'Hurghada Bite';

  @override
  String get vendorCuisine => 'Street food';

  @override
  String get saveAddress => 'Save address';

  @override
  String get comment => 'Comment';

  @override
  String get notStarted => 'Not started';

  @override
  String get delivered => 'Order delivered';

  @override
  String get enterAddress => 'Enter your delivery address below';

  @override
  String get addDetails => 'Add delivery details';

  @override
  String get apartment => 'Apartment';

  @override
  String get cooking => 'Cooking your order';

  @override
  String get address => 'Address';

  @override
  String get courier => 'Courier picking up your order';

  @override
  String get all => 'All meals';

  @override
  String get addressError => 'Enter a complete delivery address';

  @override
  String get browse => 'Browse';

  @override
  String get settings => 'More';

  @override
  String get deliveryAddress => 'Delivery address';

  @override
  String get demoOrderNotice =>
      'Demo order saved. No restaurant dispatch or live delivery tracking is connected.';

  @override
  String get noOrders => 'No orders yet';

  @override
  String get addDemoCard => 'Add demo card';

  @override
  String get demoCardNotice =>
      'Simulation only. Fixed sample details; no real card information or payment is collected.';

  @override
  String get cardNumber => 'Card number';

  @override
  String get cardholder => 'Name on card';

  @override
  String get demoCardholder => 'Demo customer';

  @override
  String get expiry => 'Expiry';

  @override
  String get securityCode => 'CVV';

  @override
  String get postalCode => 'ZIP';

  @override
  String get useDemoCard => 'Use demo card';

  @override
  String get increaseQuantity => 'Increase quantity';

  @override
  String get decreaseQuantity => 'Decrease quantity';

  @override
  String get seeMenu => 'See menu';
}
