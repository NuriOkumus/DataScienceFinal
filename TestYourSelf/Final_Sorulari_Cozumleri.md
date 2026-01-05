# Test Yourself Final - Çözümler ve Açıklamalar (Güncel)

Bu dosya, `test_yourself_questions.md` sınavındaki tüm soruların en güncel, en basit R kodlarını ve sınavda yazılması gereken Türkçe yorumları içerir.

---

## 1. Missing Values (Eksik Veri Kontrolü)
**Soru:** Değişkenlerdeki eksik verileri kontrol edin. `npreg` ve `type` dışında 0'lar eksik veri kabul edilir.

**Kod:**
```r
library(MASS)
# NA kontrolü
anyNA(Pima.tr)

# 0 kontrolü (0'ları NA yaparak sayalım)
tr_temp <- Pima.tr
tr_temp[, 2:7][tr_temp[, 2:7] == 0] <- NA
sum(is.na(tr_temp))
```

---

## 2. Symmetric Distribution (Simetrik Dağılım)
**Soru:** Hangi öznitelikler simetrik dağılıma sahiptir?

**Kod:**
```r
par(mfrow = c(3, 3))
for(i in 1:7) hist(Pima.tr[, i], main = colnames(Pima.tr)[i], col = "skyblue")
```
**Yorum:** `bmi`, `glu` ve `bp` nispeten simetrik dağılım gösterirken; `npreg` ve `age` sağa çarpıktır.

---

## 3. Feature Plot (Sınıflandırma Gücü)
**Soru:** Hangi öznitelikler cevabı (type) en iyi sınıflandırır?

**Kod:**
```r
library(caret)
featurePlot(x = Pima.tr[, 1:7], y = Pima.tr$type, plot = "box")
```
**Yorum:** `glu` ve `bmi` kutu grafiklerinde gruplar arasında en belirgin farkı gösteren, yani en iyi ayırt edici değişkenlerdir.

---

## 4, 5 & 6. Modelleme ve Değerlendirme
**Soru:** 10-fold CV ile Lojistik Regresyon ve Random Forest modelleri kurup karşılaştırın.

**Kod:**
```r
ctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 5)

# Logistic Regression
model_logit <- train(type ~ ., data = Pima.tr, method = "glm", family = "binomial",
                     preProcess = c("center", "scale"), trControl = ctrl)

# Random Forest
model_rf <- train(type ~ ., data = Pima.tr, method = "rf",
                  preProcess = c("center", "scale"), trControl = ctrl)

# Confusion Matrix (Pima.te üzerinde)
pred_logit <- predict(model_logit, Pima.te)
confusionMatrix(pred_logit, Pima.te$type, positive = "Yes")
```
**Yorum:** Sınavda Accuracy, Sensitivity ve Specificity değerlerini çıktılardan karşılaştırıp en yüksek doğruluğa sahip olanı seçtiğinizi belirtmelisiniz.

---

## 7. Tahmin (Yeni Hastalar)
**Kod:**
```r
new_patients <- data.frame(
  npreg = c(4, 1), glu = c(148, 85), bp = c(72, 66),
  skin = c(35, 29), bmi = c(24.6, 26.6), ped = c(0.627, 0.351), age = c(40, 17)
)
predict(model_logit, new_patients)
```

---

## 8, 9 & 10. PCA (Temel Bileşenler Analizi)
**Kod:**
```r
pca_result <- prcomp(Pima.tr[, 1:7], scale = TRUE)
summary(pca_result)
plot(pca_result, type = "l") # Scree Plot
```
**Soru 9 (Scale=TRUE):** Değişkenlerin birimleri farklı olduğu için (örn: yaş vs glikoz) ölçekleme yapılmazsa sayısal olarak büyük değerler PCA'yı domine eder.
**Soru 10 (Elbow Method):** Varyans düşüşünün aniden yavaşladığı "dirsek" noktası, seçilecek ideal bileşen sayısını verir.

---

## 11. PCA Yorumlama
*   **(a) Negatif Skor:** PC1; yaş, hamilelik ve glikoz ile pozitif yüklü ise, yüksek negatif skor "genç, az hamilelik geçirmiş ve düşük glikozlu" kişileri temsil eder.
*   **(b) Korelasyon:** Evet, mümkündür. PCA varyansı maksimize etmeye odaklanır, değişkenlerin kendi aralarındaki korelasyonu her zaman aynı yönde korumak zorunda değildir.

---

## 12. Regresyonda PCA
*   **Avantaj:** PC'ler birbirine diktir (orthogonal), çoklu doğrusal bağlantı (multicollinearity) sorununu tamamen çözer.
*   **Maliyet:** Klinik yorumlanabilirlik düşüktür. PC skorları bir doktor için hastayı teşhis ederken doğrudan bir anlam ifade etmez.

---

## 13, 14, 15 & 16. Regresyon Analizi (BMI üzerine)
**Kod:**
```r
model_bmi <- lm(bmi ~ . - type, data = Pima.tr)
par(mfrow = c(2, 2)); plot(model_bmi) # Varsayım kontrolü
summary(model_bmi)
```
*   **Soru 13 (Varsayımlar):** Residuals vs Fitted grafiğinde huni şekli varsa "Heteroscedasticity" vardır. Q-Q Plot'ta sapmalar varsa hatalar normal dağılmıyordur.
*   **Soru 14 (Yorum):** 1 birimlik `skin` artışı, BMI'da ortalama 0.395 birimlik artış sağlar. P-value < 0.05 olduğu için anlamlıdır.
*   **Soru 15 (Multicollinearity):** Değişkenlerin birbirleriyle aşırı ilişkili olmasıdır. Katsayıları kararsızlaştırır.
*   **Soru 16 (Adjusted R2):** Gereksiz değişken eklenmesini cezalandırdığı için model karşılaştırmada daha güvenilirdir.

---

## 17, 18 & 19. Stepwise Regression
**Kod:**
```r
step_model <- step(model_bmi, direction = "backward")
```
*   **Değerlendirme:** En düşük AIC değerine sahip model seçilir.
*   **R-squared:** Azaltılmış (reduced) modelin R2 değeri her zaman full modelden düşük veya eşittir, ancak daha basit olduğu için tercih edilebilir (Parsimony).
*   **Eleştiri:** Stepwise sadece istatistiksel önem (AIC) bakar, klinik/teorik önemi ve uzman görüşünü dikkate almaz.

---

## 20, 21 & 22. MICE (Eksik Veri Atama)
*   **m=5:** 5 farklı kopyalanmış veri seti oluşturulacağını ifade eder. Belirsizliği ölçmek için m > 1 olmalıdır.
*   **MNAR (En Zor):** Eksikliğin verinin kendisiyle ilgili olmasıdır (örn: çok yüksek tansiyonluların ölçüm yaptırmaması). Çözümü en zordur.
*   **pool():** Farklı veri setlerinden gelen sonuçları birleştirir ve standart hataları eksik veriden kaynaklanan belirsizliği içerecek şekilde günceller.
