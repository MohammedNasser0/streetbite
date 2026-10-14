## Current physical exploratory QA — 14 October 2026

The matrix now records 36 Pass, 6 Not Run and 1 Blocked (owner-deferred bonus Maps). Newly observed physical/technical results and the exact remaining cases are detailed in [physical exploratory QA](physical-exploratory-qa.md). Earlier statements below retain their historical scope. This is not independent human execution or complete capstone closure.

# Traceability

| Requirement | Implementation | Verification |
|---|---|---|
| Auth and signup validation | AuthCubit / AuthScreen / UserBuilder | TC_LOGIN_001–007, TC_SIGNUP_001–003; LoginTest |
| Live API and caching | SearchMeals / MealRepositoryImpl / remote + cached sources | TC_HOME_001–006; cache/model unit tests |
| Cart and details | CartBloc / MealDetailsScreen / CartScreen | TC_HOME_007, TC_DETAILS_001, TC_CART_001; HomeTest |
| Orders and payment strategies | PlaceOrder / OrderRepository / cash and demo card | TC_ORDER_001–002; use-case unit tests; CheckoutTest cash order/history/restart on emulator |
| Favourites/profile | ProfileRepository / FirestoreService | TC_FAV_001 manual Not Run; build 9 FavouritesTest save/restart/remove passed; TC_PROFILE_001–002 owner-assisted physical passes; ProfileTest final build 4 |
| Vendor map | VendorMapScreen | TC_MAP_001 |
| Arabic/themes | LocaleCubit / ThemeBloc / ARB | TC_L10N_001, TC_THEME_001 |
| Ownership | firestore.rules | TC_SECURITY_001 |
| Beta | Firebase App Distribution | Upload dashboard and tester invitation evidence |

Execution status is tracked in manual-test-cases.csv and the closure report. Mapping alone is not evidence of a pass.

## Additional manual coverage — 14 October 2026

| Area | Implementation | Planned manual cases | Execution |
|---|---|---|---|
| Onboarding | WelcomeScreen | TC_ONBOARD_001 | Not Run |
| Search/category | BrowseScreen | TC_BROWSE_001 | Not Run |
| Checkout rows/payment/action | CheckoutScreen | TC_CHECKOUT_001–003 | Not Run; separate build 10 automated evidence is documented |
| Address validation/editing | DeliveryAddressScreen | TC_ADDRESS_001–002 | Not Run |
| Language/theme settings | MoreScreen | TC_SETTINGS_001 | Not Run |

Build 11 Browse retry: MenuCubit.retry / BrowseScreen, planned manual TC_BROWSE_002 remains Not Run; separate native BrowseRetryTest passed on the emulator.

## Support coverage — build 12

| Area | Implementation | Planned cases | Execution |
|---|---|---|---|
| Help/Contact | HelpCenterScreen / ContactScreen / SupportLinks | TC_SUPPORT_001–002 | Not Run; build12 widget/native support evidence is separate |

## Design flows — build13

| Area | Implementation | Manual case | Scope |
|---|---|---|---|
| Shared address/session isolation | DeliveryAddressCubit/Header and Checkout | TC_ADDRESS_003 | Not Run; separate widget/native evidence |
| Grouped menu/pinned categories/cart | GroupedMenuScreen | TC_MENU_001 | Not Run |
| Browse category tiles | CategoryTiles | TC_BROWSE_003 | Not Run |
| Direct details quantity | QuantityControl | TC_DETAILS_002 | Not Run |
