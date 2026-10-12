# Design reference inspection

Source: Food Delivery Mobile App UI Kit by Vlad Solomakha, CC BY 4.0.
Community file: https://www.figma.com/community/file/1352761962360670057/food-delivery-mobile-app-ui-kit
User-opened copy: https://www.figma.com/design/i2ze5hKzwfziBl7odhsqt8/

The Screens page is accessible. Top-level frames observed: Welcome, Home (two variants), Home • Long, Resturaunt, Resturaunt • Scroll, Resturaunt • Added, Resturaunt • Search, Order (multiple variants), Checkout, Add card, Orders, Profile and More.

Observed delivery-address frame: 375 × 812, white background, black headings, light gray rounded input surfaces, large map, address/apartment/comment fields. Brand preview uses green delivery accents and bottom navigation.

Current implementation covers a functional subset adapted to the assignment's meals API. It is **not yet a faithful reproduction of every frame**. Remaining fidelity work includes delivery-address entry, restaurant search variants, order-progress screens, card UI simulation, exact typography/spacing and frame-by-frame visual QA. Card UI must remain a demo and must never collect real financial credentials.

Welcome artwork: exported Frame 6573 (node 30:7132) from the supplied Figma file, CC BY 4.0 attribution above. Stored at flutter_app/assets/images/welcome.png. Email/password authentication replaces the reference's phone input to meet the assignment's Firebase requirements.

Profile frame inspected: node 21:3864, 375 x 812. Reference uses an avatar/name header, Settings, Contact us and Help center rows, with bottom navigation. Current profile adds assignment-specific Firebase data and biometric gating; exact reference navigation/settings coverage remains open.

Additional frames inspected: Add card (2:767) uses card-number/name/expiry/CVV/ZIP fields and a bottom Continue action. Current payment is a simulation with no real card-data collection; this form remains a design gap. The top-level More frame (63:270) is a promotional plugin banner, not an application screen, and should not be copied into StreetBite.
