# دليل حزمة المراجعة — StreetBite 1.0.0 (13)

الحزمة تحتوي على المصدر، APK التجريبي، العرض، ملفات QA والأدلة الخاصة المسموح بإرفاقها. لم يُرسل المشروع إلى منصة Sprints حتى الآن.

## ما يمكنك عرضه الآن
- المستودع العام: https://github.com/MohammedNasser0/streetbite
- العرض: `presentation/StreetBite-project-review-build13-qa.pptx`.
- نسخة Android: `beta/StreetBite.apk` داخل ZIP. تحقق من `beta/SHA256.txt` و`SOURCE_COMMIT.txt`.
- Firebase: الإصدار13 موزّع على المختبرين؛ الدليل المنقح آليًا في `private-evidence/firebase-beta13-release.json`.
- صور Welcome/Login/Signup/Home EN/AR/Dark/Details/Cart/Map في `docs/screenshots/`، مع اختلاف إصدار الصور حسب توثيقها.
- صور الموبايل تبقى داخل `private-evidence/physical-beta4/` و`physical-beta5/` و`physical-beta9/` و`physical-beta13/`؛ لا تنشر هذا المجلد.
- لقطة نافذة البصمة الحقيقية من المحاكي: `private-evidence/emulator-beta5/biometric-prompt-windows.png`، وليست لقطة جهاز حقيقي.
- صور Firebase وJira الأصلية خاصة داخل الحزمة؛ النسخة المنشورة في README تطمس الإيميلات.

## المتبقي قبل إعلان إغلاق المشروع بالكامل
الاختبارات اليدوية غير المنفذة في `manual-test-cases.csv` تحتاج جهازًا حقيقيًا؛ لا تُعلّم Pass من نتائج المحاكي. سجّل الإصدار والجهاز والتاريخ والنتيجة الفعلية، وأضف أي فشل مُشاهد إلى Jira. راجع `manual-qa-walkthrough.md` عند توفر الجهاز.

مطابقة Figma ليست كاملة؛ الفروق الدقيقة موضحة في `figma-frame-coverage.md`. تشخيص مربعات الخريطة الفارغة مؤجل بطلب المالك باعتباره بونص. التطبيق يعرض أسعارًا وطلبات تجريبية ولا ينفذ دفعًا أو توصيلًا حقيقيًا. توقيع Android الحالي للتجربة، وiOS غير معتمد على Windows.

الـZIP يحتوي على أدلة خاصة؛ سلّمه للمراجع عبر قناة خاصة ولا ترفعه إلى المستودع العام.

نتائج الفحص الحالية: 36 Pass و6 Not Run وحالة الخرائط Blocked بطلب المالك. الفحص الجديد استكشافي على الموبايل بمساعدة الأداة؛ تفاصيله في physical-exploratory-qa.md. صور الدورة الجديدة المراجعة داخل private-evidence/manual-beta13 فقط.
