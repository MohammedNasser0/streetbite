# Figma frame coverage — 12 October 2026

Reference: Food Delivery Mobile App UI Kit by Vlad Solomakha, CC BY 4.0. The accessible Screens page contains 16 top-level frames (15 app frames and one promotional banner). This inventory describes this supplied copy; it does not certify the brief's advertised 50+ screens.

| Figma frame | Node | StreetBite mapping | Remaining fidelity work |
|---|---|---|---|
| Welcome | 30:6985 | WelcomeScreen | Email authentication adapts the reference phone form |
| Home | 6:1910 | HomeScreen | Build13 adds an editable address header shared with Checkout; typography and vendor-card composition remain adaptations to live meal data |
| Home • Long | 2:734 | HomeScreen scroll | Required meal grid differs from reference vendor list |
| Home (delivery address) | 30:7149 | DeliveryAddressScreen | Build 7 adds an interactive optional delivery pin and required text address; native map runtime verification and field fidelity remain under review |
| Resturaunt | 2:746 | MealDetailsScreen and live menu | Build13 adds GroupedMenuScreen with a real-meal hero, grouped rows and category filtering; no invented vendor ratings/ETAs |
| Resturaunt • Scroll | 19:2672 | Home/Browse scrolling | Build13 adds a pinned category strip and grouped rows in GroupedMenuScreen |
| Resturaunt • Added | 19:2840 | CartBloc and cart route | Build13 adds direct quantity controls to details and a live Cart/total action to the grouped menu |
| Resturaunt • Search | 18:1784 | BrowseScreen | Build13 adds a two-column category-tile grid; selecting a category opens filtered meal results |
| Order (cart) | 18:980 | CartScreen | Build 5 adds thumbnails, inline quantity controls and full-width action; Build13 adds subtotal and explicit zero additional demo charges; real delivery/pickup is outside the demo |
| Checkout | 10:338 | CheckoutScreen | Build 10 separates address, instructions and actual-account contact rows, adds a localized Checkout title and a fixed total/order action; selected-pin preview remains optional. Delivery-time choices and promotion row remain absent |
| Add card | 2:767 | DemoCardScreen (build 4) | Fixed demo values replace editable financial data; no default-card persistence |
| Order (preparing) | 19:3355 | OrderProgressScreen | Map/timeline composition; no live fulfilment exists |
| Order (courier) | 20:3626 | OrderProgressScreen | Courier state/contact is unavailable in this demo |
| Orders | 21:3759 | OrdersScreen | Build 6 source adds rounded meal thumbnails, localized dates and compact rows; current/past grouping remains absent because no live fulfilment status exists |
| Profile | 21:3864 | ProfileScreen | Build 12 source adds start-aligned avatar/name, working Settings/Contact/Help rows and shared bottom navigation; biometric, photo and live data remain available. Native visual verification pending |
| More | 63:270 | Excluded | Promotional plugin advertisement, not an app screen |

A mapped frame is not a fidelity pass. The demo does not claim actual couriers, delivery ETAs or payment processing. No invented live order progression is used to imitate reference screenshots.

Build 4 adds the Add card composition with a title, card/name sample surfaces, expiry/CVV/ZIP row and fixed bottom action. English/Arabic layout tests at 375/412 logical pixel widths and 568 height pass, and assert that no editable card-data input exists. Device verification is recorded separately.

On 14 October the reference Profile node 21:3864 was reviewed directly: left-aligned avatar/name, Settings, Contact us, Help center and bottom navigation. Build 12 source implements these composition elements; mocked Profile layout/gate checks pass; native authenticated Profile visual verification remains historical. Figma lists missing SF Compact Display, SF Compact and SF Pro fonts in this environment; current platform typography is not a font-fidelity pass.


Build13 source design pass: Home6:1910, Restaurant2:746 and Search18:1784 inspected directly. Optional grouped Menu preserves the assignment-required Home grid. Header addresses are session drafts cleared on account change, and active Checkout listens for clearing. Category names and recipes are real API data. No new delivery ETA, discount, restaurant fulfilment or courier state is claimed. Native build13 checks are pending; source checks are recorded separately.
