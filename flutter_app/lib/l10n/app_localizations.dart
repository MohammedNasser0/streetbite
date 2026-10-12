import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Email or password is incorrect.'**
  String get invalidCredentials;

  /// No description provided for @emailInUse.
  ///
  /// In en, this message translates to:
  /// **'An account already uses this email. Log in instead.'**
  String get emailInUse;

  /// No description provided for @authThrottled.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please wait and try again.'**
  String get authThrottled;

  /// No description provided for @authNetworkError.
  ///
  /// In en, this message translates to:
  /// **'Cannot connect. Check your internet and try again.'**
  String get authNetworkError;

  /// No description provided for @authNotEnabled.
  ///
  /// In en, this message translates to:
  /// **'Email sign-in is currently unavailable. Please try later.'**
  String get authNotEnabled;

  /// No description provided for @accountDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account is disabled. Contact support.'**
  String get accountDisabled;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'StreetBite'**
  String get appName;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search meals'**
  String get search;

  /// No description provided for @offers.
  ///
  /// In en, this message translates to:
  /// **'Hot offers'**
  String get offers;

  /// No description provided for @recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get recommended;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get add;

  /// No description provided for @added.
  ///
  /// In en, this message translates to:
  /// **'Added to your cart'**
  String get added;

  /// No description provided for @emptyCart.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get emptyCart;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @instructions.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get instructions;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Could not load meals. Check your connection and try again.'**
  String get networkError;

  /// No description provided for @noMeals.
  ///
  /// In en, this message translates to:
  /// **'No meals found'**
  String get noMeals;

  /// No description provided for @demoPrices.
  ///
  /// In en, this message translates to:
  /// **'Demonstration prices • Recipes by TheMealDB'**
  String get demoPrices;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Good food, wherever you are.'**
  String get welcome;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Explore meals'**
  String get start;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Change theme'**
  String get theme;

  /// No description provided for @featured.
  ///
  /// In en, this message translates to:
  /// **'Discover something delicious'**
  String get featured;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Meal details'**
  String get details;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @favourites.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get favourites;

  /// No description provided for @vendors.
  ///
  /// In en, this message translates to:
  /// **'Nearby vendors'**
  String get vendors;

  /// No description provided for @nameError.
  ///
  /// In en, this message translates to:
  /// **'Enter a name starting with a capital letter'**
  String get nameError;

  /// No description provided for @passwordError.
  ///
  /// In en, this message translates to:
  /// **'Use at least six characters'**
  String get passwordError;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @placeOrder.
  ///
  /// In en, this message translates to:
  /// **'Place demo order'**
  String get placeOrder;

  /// No description provided for @mapsSetup.
  ///
  /// In en, this message translates to:
  /// **'Configure a Google Maps key to see the map.'**
  String get mapsSetup;

  /// No description provided for @firebaseSetup.
  ///
  /// In en, this message translates to:
  /// **'Account features need StreetBite Firebase configuration.'**
  String get firebaseSetup;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash on delivery'**
  String get cash;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change photo'**
  String get changePhoto;

  /// No description provided for @orderPlaced.
  ///
  /// In en, this message translates to:
  /// **'Order placed'**
  String get orderPlaced;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @authError.
  ///
  /// In en, this message translates to:
  /// **'Could not sign in. Check your details and connection.'**
  String get authError;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @unlockProfile.
  ///
  /// In en, this message translates to:
  /// **'Unlock profile with fingerprint'**
  String get unlockProfile;

  /// No description provided for @biometricUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Biometrics unavailable. Set up fingerprint on a supported device.'**
  String get biometricUnavailable;

  /// No description provided for @confirmError.
  ///
  /// In en, this message translates to:
  /// **'Passwords must match'**
  String get confirmError;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @unsave.
  ///
  /// In en, this message translates to:
  /// **'Remove favourite'**
  String get unsave;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Order history'**
  String get orders;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get signup;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @visibility.
  ///
  /// In en, this message translates to:
  /// **'Password visibility'**
  String get visibility;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save favourite'**
  String get save;

  /// No description provided for @demoVendors.
  ///
  /// In en, this message translates to:
  /// **'Illustrative vendor locations'**
  String get demoVendors;

  /// No description provided for @card.
  ///
  /// In en, this message translates to:
  /// **'Demo card payment'**
  String get card;

  /// No description provided for @photoError.
  ///
  /// In en, this message translates to:
  /// **'Could not update photo. Try a smaller image.'**
  String get photoError;

  /// No description provided for @emailError.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get emailError;

  /// No description provided for @orderReceived.
  ///
  /// In en, this message translates to:
  /// **'Order received'**
  String get orderReceived;

  /// No description provided for @vendorCairo.
  ///
  /// In en, this message translates to:
  /// **'Cairo Bite'**
  String get vendorCairo;

  /// No description provided for @vendorAlexandria.
  ///
  /// In en, this message translates to:
  /// **'Alexandria Bite'**
  String get vendorAlexandria;

  /// No description provided for @vendorLuxor.
  ///
  /// In en, this message translates to:
  /// **'Luxor Bite'**
  String get vendorLuxor;

  /// No description provided for @vendorAswan.
  ///
  /// In en, this message translates to:
  /// **'Aswan Bite'**
  String get vendorAswan;

  /// No description provided for @vendorHurghada.
  ///
  /// In en, this message translates to:
  /// **'Hurghada Bite'**
  String get vendorHurghada;

  /// No description provided for @vendorCuisine.
  ///
  /// In en, this message translates to:
  /// **'Street food'**
  String get vendorCuisine;

  /// No description provided for @saveAddress.
  ///
  /// In en, this message translates to:
  /// **'Save address'**
  String get saveAddress;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @notStarted.
  ///
  /// In en, this message translates to:
  /// **'Not started'**
  String get notStarted;

  /// No description provided for @delivered.
  ///
  /// In en, this message translates to:
  /// **'Order delivered'**
  String get delivered;

  /// No description provided for @enterAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter your delivery address below'**
  String get enterAddress;

  /// No description provided for @addDetails.
  ///
  /// In en, this message translates to:
  /// **'Add delivery details'**
  String get addDetails;

  /// No description provided for @apartment.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get apartment;

  /// No description provided for @cooking.
  ///
  /// In en, this message translates to:
  /// **'Cooking your order'**
  String get cooking;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @courier.
  ///
  /// In en, this message translates to:
  /// **'Courier picking up your order'**
  String get courier;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All meals'**
  String get all;

  /// No description provided for @addressError.
  ///
  /// In en, this message translates to:
  /// **'Enter a complete delivery address'**
  String get addressError;

  /// No description provided for @browse.
  ///
  /// In en, this message translates to:
  /// **'Browse'**
  String get browse;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get settings;

  /// No description provided for @deliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery address'**
  String get deliveryAddress;

  /// No description provided for @demoOrderNotice.
  ///
  /// In en, this message translates to:
  /// **'Demo order saved. No restaurant dispatch or live delivery tracking is connected.'**
  String get demoOrderNotice;

  /// No description provided for @noOrders.
  ///
  /// In en, this message translates to:
  /// **'No orders yet'**
  String get noOrders;

  /// No description provided for @addDemoCard.
  ///
  /// In en, this message translates to:
  /// **'Add demo card'**
  String get addDemoCard;

  /// No description provided for @demoCardNotice.
  ///
  /// In en, this message translates to:
  /// **'Simulation only. Fixed sample details; no real card information or payment is collected.'**
  String get demoCardNotice;

  /// No description provided for @cardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card number'**
  String get cardNumber;

  /// No description provided for @cardholder.
  ///
  /// In en, this message translates to:
  /// **'Name on card'**
  String get cardholder;

  /// No description provided for @demoCardholder.
  ///
  /// In en, this message translates to:
  /// **'Demo customer'**
  String get demoCardholder;

  /// No description provided for @expiry.
  ///
  /// In en, this message translates to:
  /// **'Expiry'**
  String get expiry;

  /// No description provided for @securityCode.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get securityCode;

  /// No description provided for @postalCode.
  ///
  /// In en, this message translates to:
  /// **'ZIP'**
  String get postalCode;

  /// No description provided for @useDemoCard.
  ///
  /// In en, this message translates to:
  /// **'Use demo card'**
  String get useDemoCard;

  /// No description provided for @increaseQuantity.
  ///
  /// In en, this message translates to:
  /// **'Increase quantity'**
  String get increaseQuantity;

  /// No description provided for @decreaseQuantity.
  ///
  /// In en, this message translates to:
  /// **'Decrease quantity'**
  String get decreaseQuantity;

  /// No description provided for @seeMenu.
  ///
  /// In en, this message translates to:
  /// **'See menu'**
  String get seeMenu;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
