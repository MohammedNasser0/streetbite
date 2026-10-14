# Physical exploratory QA — 14 October 2026

Final build13 APK SHA256318b20bf2526d994377d4df2e9b4f43058029be8ddc361f24797b111454a95b3. OPPO CPH2669 Android16, density320, font scale1.15.

The 43-case matrix now contains **36 Pass, 6 Not Run and 1 Blocked**. Thirty-four newly recorded cases used agent-driven exploratory input on the actual phone with Appium/USB and direct visual/accessibility review; the Firestore security case used signed-in REST checks. This is not a claim of independent human execution. The two earlier owner-assisted cases retain their actual scope: fingerprint/profile build13 and photo/restart build4.

Observed flows include signup/profile creation and persistent auth, invalid/empty/malformed login, password visibility, live Home/details, cached and fresh-cache offline states, favourites across restart, cart totals/removal, single demo order after double submit, address validation/edit/reuse/account clearing, EN/AR category navigation, support answers, language/theme persistence and responsive Home/Checkout.

Home was visually reviewed at375 and412 logical-pixel widths. Checkout was reviewed in EN/AR at both widths. Temporary750x1624 and824x1830 sizes at density320 were restored to the original720x1604. Wi-Fi and mobile data were restored enabled, and language/theme returned to English/light. All current phone images stay private in the review ZIP.

One network transition stalled the Appium source reader. USB screenshots confirmed the actual app error view; the original connection state was restored, the owned QA server restarted and the preserved query subsequently returned No meals found. Transient display-resize captures and interrupted input attempts are retained privately and excluded from reviewed evidence. No product defect is inferred from these tool interruptions.

Six cases still need execution: Login keyboard reachability and background/resume, featured-banner/five-offer swiping, scroll/memory profiling, onboarding fade and exact clipboard content/back navigation. Bonus Maps is Blocked by the owner's deferral. No new Jira product bug was confirmed in this cycle. STREET-3 remains verified Done.

Figma Checkout reference was re-opened directly:375x948 frame, map preview, delivery-time cards, address/instructions/contact/promo and bottom order action. Current implementation remains an adaptation; delivery-time/promo composition and complete reference fidelity are not certified. No final platform submission has been made.
