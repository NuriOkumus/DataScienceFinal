# Veri Bilimi Final Çalışma Rehberi

## 📚 Bölüm 1: Temeller ve Kritik Konular

### 1.1 Preprocessing & Missing Data (Mice)
*   **Odak:** `mice` paketi, `pool()` fonksiyonu, `m=5` parametresi.
*   **Kavramlar:** MCAR (Missing Completely at Random), MAR (Missing at Random), MNAR (Missing Not at Random) farkları.
*   **Detay:** PMM (Predictive Mean Matching) çalışma mantığı.

### 1.2 PCA (Dimension Reduction)
*   **Odak:** `scale=TRUE` argümanının istatistiksel gerekliliği.
*   **Analiz:** Scree Plot ile "Elbow Method" kullanımı ve varyans açıklama.
*   **Yorumlama:** Principal Component Loading değerlerine göre değişkenlerin ilişkisi.

### 1.3 Veri Görselleştirme
*   **Odak:** `ggplot2` ve `dplyr` kütüphaneleri.
*   **Analiz:** Simetrik dağılımların keşfi ve Feature Plot çizimi.

---

## 📊 Bölüm 2: Modelleme ve Karar Verme

### 2.1 Regresyon & Varsayımlar
*   **Odak:** Lineer Regresyon ve Backward Stepwise Regression (`step()` fonksiyonu).
*   **Kontrol:**
    *   **Homoscedasticity:** Residuals vs Fitted plot yorumlama.
    *   **Normality:** Q-Q Plot ve sapmalar.
    *   **Multicollinearity:** Neden sorundur?
*   **Metrik:** Adjusted R-squared vs Multiple R-squared.

### 2.2 Sınıflandırma (Classification)
*   **Odak:** Logistic Regression vs Random Forest.
*   **Araç:** `caret` paketi ile 10-fold Cross Validation.
*   **Metrikler:** Accuracy, Sensitivity, Specificity hesaplama ve Confusion Matrix.

---

## ✅ Final Provası
Hocanın paylaştığı "Test Yourself Final" sorularını baştan sona çözme ve cevapları kontrol etme.
