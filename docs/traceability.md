# Traceability

| Requirement | Implementation | Verification |
|---|---|---|
| Auth and signup validation | AuthCubit / AuthScreen / UserBuilder | TC_LOGIN_001–007, TC_SIGNUP_001–003; LoginTest |
| Live API and caching | SearchMeals / MealRepositoryImpl / remote + cached sources | TC_HOME_001–006; cache/model unit tests |
| Cart and details | CartBloc / MealDetailsScreen / CartScreen | TC_HOME_007, TC_DETAILS_001, TC_CART_001; HomeTest |
| Orders and payment strategies | PlaceOrder / OrderRepository / cash and demo card | TC_ORDER_001–002; use-case unit tests; CheckoutTest cash order/history/restart on emulator |
| Favourites/profile | ProfileRepository / FirestoreService | TC_FAV_001, TC_PROFILE_001–002 |
| Vendor map | VendorMapScreen | TC_MAP_001 |
| Arabic/themes | LocaleCubit / ThemeBloc / ARB | TC_L10N_001, TC_THEME_001 |
| Ownership | firestore.rules | TC_SECURITY_001 |
| Beta | Firebase App Distribution | Upload dashboard and tester invitation evidence |

Execution status is tracked in manual-test-cases.csv and the closure report. Mapping alone is not evidence of a pass.
