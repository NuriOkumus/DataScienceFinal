# 2 Günlük Veri Bilimi Final Çalışma Planı

## 🗓️ 1. GÜN: Temeller ve Kritik Konular (Banko Sorular)

### 🌅 Sabah (09:00 - 12:00): Preprocessing & Missing Data (Mice)
*   **Odak:** `mice` paketi, `pool()` fonksiyonu, `m=5` parametresi.
*   **Kavramlar:** MCAR (Missing Completely at Random), MAR (Missing at Random), MNAR (Missing Not at Random) farkları.
*   **Detay:** PMM (Predictive Mean Matching) çalışma mantığı.

### ☀️ Öğleden Sonra (13:00 - 16:00): PCA (Dimension Reduction)
*   **Odak:** `scale=TRUE` argümanının istatistiksel gerekliliği.
*   **Analiz:** Scree Plot ile "Elbow Method" kullanımı ve varyans açıklama.
*   **Yorumlama:** Principal Component Loading değerlerine göre değişkenlerin ilişkisi.

### 🌙 Akşam (19:00 - 21:00): Veri Görselleştirme
*   **Odak:** `ggplot2` ve `dplyr` kütüphaneleri.
*   **Analiz:** Simetrik dağılımların keşfi ve Feature Plot çizimi.

---

## 🗓️ 2. GÜN: Modelleme ve Karar Verme

### 🌅 Sabah (09:00 - 12:00): Regresyon & Varsayımlar
*   **Odak:** Lineer Regresyon ve Backward Stepwise Regression (`step()` fonksiyonu).
*   **Kontrol:**
    *   **Homoscedasticity:** Residuals vs Fitted plot yorumlama.
    *   **Normality:** Q-Q Plot ve sapmalar.
    *   **Multicollinearity:** Neden sorundur?
*   **Metrik:** Adjusted R-squared vs Multiple R-squared.

### ☀️ Öğleden Sonra (13:00 - 16:00): Sınıflandırma (Classification)
*   **Odak:** Logistic Regression vs Random Forest.
*   **Araç:** `caret` paketi ile 10-fold Cross Validation.
*   **Metrikler:** Accuracy, Sensitivity, Specificity hesaplama ve Confusion Matrix.

### 🌙 Akşam (19:00 - ...): Final Provası
*   Hocanın paylaştığı "Test Yourself Final" sorularını baştan sona çözme ve cevapları kontrol etme.
