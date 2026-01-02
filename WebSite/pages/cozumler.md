# Test Yourself Final - Çözümler ve Açıklamalar

Bu dosya, `Test Yourself Final` sınavındaki tüm soruların adım adım çözümlerini, gerekli R kodlarını ve sınavda yazılması gereken yorumları içerir.

---

## SORU 1: Missing Values (Eksik Veri Kontrolü)
**Soru:** "Check whether the datasets includes any missing values. 0’s are missing for the variables except for npreg and type..."

**Çözüm:**
Pima veri setinde "0" değeri teknik olarak mümkün olmayan yerlerde (Örn: Şeker=0, Tansiyon=0) Kayıp Veri (NA) olarak kabul edilmelidir.

**Kod:**
```r
library(MASS)
library(mice)
data(Pima.tr)

# 1. 0 olan değerleri NA yapalım (Eksik Veri olarak işaretle)
Pima.tr$glu[Pima.tr$glu == 0] <- NA
Pima.tr$bp[Pima.tr$bp == 0]   <- NA
Pima.tr$skin[Pima.tr$skin == 0] <- NA
Pima.tr$bmi[Pima.tr$bmi == 0]   <- NA

# 2. Kontrol Et
summary(Pima.tr)  # Artık NA sayılarını görebiliriz
md.pattern(Pima.tr) # Görsel olarak eksik desenini gör
```
**Yorum:** "Variables like glucose, bp, skin, and bmi cannot physically be 0. These zeros represent missing data."

---

## SORU 2: Symmetric Distribution (Simetrik Dağılım)
**Soru:** "Explore the attributes and write down the ones that have symmetric distribution..."

**Çözüm:**
Histogram çizerek dağılımın şekline (Çan eğrisi mi?) bakarız.

**Kod:**
```r
par(mfrow=c(2,4)) # Ekranı böl
for(i in 1:7) hist(Pima.tr[,i], main=names(Pima.tr)[i])
```
**Cevap:**
*   **Simetrik Olanlar:** `glu` (Glikoz) ve `bp` (Tansiyon).
*   **Simetrik Olmayanlar:** `age` (Sağa çarpık - Right Skewed).

---

## SORU 3: Feature Plot (Sınıflandırma Gücü)
**Soru:** "Create a feature plot and evaluate the attributes that best classify the response..."

**Çözüm:**
`caret` paketi ile kutu grafikleri çizerek "Yes" ve "No" gruplarının ne kadar ayrıştığına bakarız.

**Kod:**
```r
library(caret)
featurePlot(x = Pima.tr[, 1:7], 
            y = Pima.tr$type, 
            plot = "box", 
            scales = list(y = list(relation = "free")))
```
**Yorum:**
"We look for variables where the 'Yes' box and 'No' box are clearly separated."
*   **En İyi:** `glu` (Şeker). Kutu ayrımı çok nettir.
*   **En Kötü:** `bp` veya `skin`. Kutular üst üste biner.

---

## SORU 4, 5, 6: Modelleme ve Karşılaştırma
**Soru:** "Train logistic regression and random forest... Accuracy, Sensitivity, Specificity..."

**Çözüm:**
`caret` paketi ile iki model kurup karşılaştıracağız.

**Kod:**
```r
# 10-Katlı Çapraz Doğrulama (Cross Validation)
ctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 5)

# Model 1: Logistic Regression
set.seed(123)
model_glm <- train(type ~ ., data = Pima.tr, method = "glm",
                   preProcess = c("center", "scale"), trControl = ctrl)

# Model 2: Random Forest
set.seed(123)
model_rf <- train(type ~ ., data = Pima.tr, method = "rf",
                  preProcess = c("center", "scale"), trControl = ctrl)

# Karşılaştır
results <- resamples(list(Log = model_glm, RF = model_rf))
summary(results)
```
**Yorum:**
"Random Forest usually provides higher Accuracy compared to Logistic Regression, but Logistic Regression is easier to interpret."

---

## SORU 7: Tahmin (Yeni Hastalar)
**Soru:** "Patient #1 (npreg=4, glu=148...)... Predict class."

**Çözüm:**
Yeni hastanın verilerini bir `data.frame` olarak girip `predict` fonksiyonunu kullanırız.

**Kod:**
```r
yeni_hastalar <- data.frame(
  npreg = c(4, 1), 
  glu   = c(148, 85),
  bp    = c(72, 66),
  skin  = c(35, 29),
  bmi   = c(24.6, 26.6), 
  ped   = c(0.627, 0.351), 
  age   = c(40, 17)
)

# Tahmin Et (Random Forest ile)
predict(model_rf, newdata = yeni_hastalar)
```
**Cevap:**
*   **Patient #1:** `Yes` (Diyabetik)
*   **Patient #2:** `No` (Sağlıklı)

---

## SORU 8, 9, 10, 11, 12: PCA (Principal Component Analysis)

**Kod (Soru 8 & 10):**
```r
# PCA Uygula (Scale=TRUE Şart!)
pca_res <- prcomp(Pima.tr[,-8], scale = TRUE)

# Scree Plot (Soru 10)
screeplot(pca_res, type="lines")

# Loadings (Soru 11 - Yorumlama)
print(pca_res$rotation)
```

**Soru 9 (Scale=TRUE):**
*   **Cevap:** "We MUST use `scale=TRUE`. Otherwise, variables with large ranges (like Insulin) will dominate the PCA purely because of their units."

**Soru 11 (PC1 Yorumu):**
*   **Cevap:** "PC1 shows high loadings for Age, Glucose, and BMI. This suggests it represents general metabolic health/aging factor."

**Soru 12 (Avantaj/Dezavantaj):**
*   **Avantaj:** Multicollinearity sorunu yoktur.
*   **Dezavantaj (Cost):** Klinik yorumlaması zordur. Doktor "PC1'in arttı" demez, "Şekerin arttı" der.

---

## SORU 13, 14, 15, 16 (Regresyon Teorisi)

**Kod (Soru 13-16):**
```r
model <- lm(bmi ~ ., data = Pima.tr)
summary(model) # Soru 14 ve 16 için
par(mfrow=c(2,2)); plot(model) # Soru 13 için
```

**Soru 13 (Varsayımlar):**
*   **Homoscedasticity:** Residuals vs Fitted grafiğinde huni şekli olmamalı.
*   **Normality:** Q-Q Plot çizgi üzerinde olmalı.

**Soru 14 (P-value):**
*   `Pr(>|t|) < 0.05` ise anlamlıdır.

**Soru 16 (R-squared):**
*   **Adjusted R2** kullanılır çünkü gereksiz değişkenler eklendiğinde düşer (Modeli cezalandırır). Multiple R2 ise hep artar, güvenilmezdir.

---

## SORU 17, 18, 19: Stepwise ve Model Seçimi

**Kod (Soru 17):**
```r
# Geriye doğru eleme (Backward Elimination)
step(model, direction = "backward")
```

**Soru 18 (Full vs Reduced):**
*   **Cevap:** Reduced Model tercih edilir. Çünkü daha az değişkenle (basit model) neredeyse aynı başarıyı yakalar. "Parsimony Principle".

---

## SORU 20, 21, 22: MICE (Eksik Veri)
**(Teorik Sorular - Kod Gerektirmez)**

**Soru 20 (m=5):**
*   **Cevap:** "Imputing 5 different times to account for uncertainty."

**Soru 21 (MNAR):**
*   **Cevap:** MNAR (Missing Not at Random) is the most difficult. E.g., obese patients avoiding scales.

**Soru 22 (Pooling):**
*   **Cevap:** `pool()` combines results from 5 imputed datasets to correct standard errors.
