# 04. Regresyon Varsayımları (Diagnostics) - En Kritik Konu! 🚨

Bir Lineer Regresyon modeli kurduk (`lm`). Peki bu model güvenilir mi? Bunu anlamak için modele **"sağlık kontrolü" (Diagnostics)** yapmalıyız.

Sınavda hoca sana **4'lü bir grafik (Plot)** verir ve yorumlamanı ister. En önemli ikisi şunlardır:

---

## 1. Residuals vs Fitted (Homoscedasticity Kontrolü)

Bu grafik bize şunu söyler: **"Modelin hataları (residuals) tutarlı mı?"**

*   **İdeal Olan:** Noktalar (hatalar), 0 çizgisinin etrafında **rastgele bir bulut** gibi dağılmalıdır. Hiçbir şekil (U harfi, huni şekli vb.) OLMAMALIDIR.
    *   Buna "Homoscedasticity" (Eş Varyanslılık) denir. İyi bir şeydir. ✅

*   **Sorunlu Olan:**
    *   **Huni (Funnel) Şekli:** Noktalar solda dar başlayıp sağa doğru açılıyorsa (yelpaze gibi).
    *   **U Şekli (Non-Linearity):** Noktalar bir muz gibi kıvrılıyorsa.
    *   Bu duruma "Heteroscedasticity" denir. Kötüdür. ❌

> **Sınav Şablon Cevabı:** "We check the Residuals vs Fitted plot for Homoscedasticity. We expect a random scatter of points around the horizontal line with no distinct pattern (like a funnel or curve). If a pattern exists, the assumption is violated."

---

## 2. Normal Q-Q Plot (Normality Kontrolü)

Bu grafik bize şunu söyler: **"Hatalar Normal Dağılıyor mu?"**

*   **İdeal Olan:** Noktalar, **kesik kesik çizilen köşegen çizgisinin (diagonal line)** tam üstüne inci gibi dizilmelidir. ✅
*   **Sorunlu Olan:**
    *   Uçlarda (baştan veya sondan) çizgiden kopmalar, sapmalar varsa.
    *   S harfi çiziyorsa.
    *   Buna "Non-Normality" denir. ❌

---

## 3. Multicollinearity (Çoklu Bağlantı Problemi)

Bu grafik değil, bir hesaplamadır (VIF testi).
*   **Nedir?** Modeldeki iki değişkenin birbirinin aynısı (veya çok benzeri) olmasıdır.
*   **Örnek:** Modele hem `bmi` (Kilo indeks) hem de `skin` (Yağ kalınlığı) koymak. İkisi de "şişmanlığı" ölçer. Modelin kafası karışır.
*   **Belirtisi:** Standart Hatalar (Std. Error) aşırı büyür.
*   **Çözüm:** Birini modelden atmak!

---

## 4. R-Kare (Multiple vs Adjusted)
*   **Multiple R-squared:** Modele her yeni değişken eklediğinde (çöp bile olsa) ARTAR. Yanıltıcıdır.
*   **Adjusted R-squared:** Cezalandırıcıdır. Eğer eklediğin değişken işe yaramıyorsa, bu puan DÜŞER.
*   **Kural:** İki modeli kıyaslarken **her zaman Adjusted R-squared**'e bakılır.
