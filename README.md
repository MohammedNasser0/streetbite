# StreetBite V1.0

Independent Flutter food discovery and ordering capstone. Application source lives in `flutter_app/`.

## References

- [Food Delivery Mobile App UI Kit, Vlad Solomakha](https://www.figma.com/community/file/1352761962360670057/food-delivery-mobile-app-ui-kit) — CC BY 4.0. Green delivery brand, white surfaces, category discovery, meal cards and order progress. Full frame inspection is pending Figma sign-in; pixel fidelity has not been verified.
- [TheMealDB API](https://www.themealdb.com/api.php). Development key `1` is for educational use. The API supplies recipes, **not prices, stock or real vendors**. StreetBite prices and vendor locations are explicitly demonstration data.

## Delivery status

This repository is under implementation. No public repository, Firebase deployment, beta upload, tester acceptance or physical-device QA is claimed until evidence is recorded.

## External setup

Use a **dedicated StreetBite Firebase project**. Do not copy ConnectMe credentials or data. Enable email/password Authentication and Firestore, configure FlutterFire for `com.streetbite.streetbite_app`, deploy the included rules, and supply Google Maps keys. Two tester email addresses and access to App Distribution are required for beta delivery. Card payment is a demo strategy and never collects real card information.
