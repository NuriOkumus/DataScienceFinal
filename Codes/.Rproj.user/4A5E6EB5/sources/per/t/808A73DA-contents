# 05_Siniflandirma.R
# Konu: Logistic Regression vs Random Forest
# Kütüphane: caret (Her şey bunun içinde!)

library(caret)
library(MASS)
data(Pima.tr)

# 1. Hazırlık: 10-Katlı Çapraz Doğrulama (10-Fold CV)
# Amacımız: Modeli tek bir sınavla değil, 10 farklı sınavla test edip ortalamasını almak.
# "Şans eseri iyi sonuç almayı" engellemek için tekrar tekrar test ediyoruz.
ctrl <- trainControl(
    method = "repeatedcv",
    number = 10,
    repeats = 5
)

# 2. Yarışmacı 1: Logistic Regression ('glm')
# - Klasik istatistiksel yöntem. Veriyi bir formüle oturtmaya çalışır.
# - preProcess: Veriyi standardize et (scale) ki PCA'deki gibi birim hatası olmasın.
set.seed(123)
model_log <- train(type ~ .,
    data = Pima.tr,
    method = "glm",
    preProcess = c("center", "scale"),
    trControl = ctrl
)

# 3. Yarışmacı 2: Random Forest ('rf')
# - Modern Makine Öğrenmesi yöntemi.
# - Tek bir karar yerine, yüzlerce "Karar Ağacı" kurup oylama yapar.
# - Genelde Logistic'ten daha yüksek başarı (Accuracy) verir.
set.seed(123)
model_rf <- train(type ~ .,
    data = Pima.tr,
    method = "rf",
    preProcess = c("center", "scale"),
    trControl = ctrl
)

# 4. Karşılaştırma (Result!)
# Hangi model daha başarılı?
results <- resamples(list(Logistic = model_log, RandomForest = model_rf))
summary(results)
# --- YORUM KISMI ---
# Çıktıda "Accuracy" (Doğruluk) sütununa bakılır. En yüksek olan kazanır.

# 5. Confusion Matrix (Büyük Karşılaşma)
# Modeli "Görmediği Veri" (Pima.te) üzerinde test ediyoruz.
predictions_log <- predict(model_log, newdata = Pima.te)

# Tabloyu Çizelim (Hasta = Yes)
conf_matrix <- confusionMatrix(
    data = predictions_log,
    reference = Pima.te$type,
    positive = "Yes"
)

print(conf_matrix)

# --- SINAV İÇİN KRİTİK DEĞERLER ---
# 1. Accuracy (Genel Başarı): Toplamda yüzde kaçını doğru bildik? (Örn: 0.80 -> %80)
# 2. Sensitivity (Duyarlılık): GERÇEK HASTALARIN yüzde kaçını yakaladık?
#    - Doktor için en önemlisi budur! Hastayı eve göndermemek lazım. (Hasta ama "sağlam" deyip yollarsak kötü)
# 3. Specificity (Özgüllük): SAĞLAM olanların yüzde kaçına "sağlamsın" dedik?

# ---------------------------------------------------------

# 6. Soru 7'nin Cevabı: Yeni Gelen Hastayı Tahmin Etme ('predict')
# "Kapıdan 2 yeni hasta girdi, değerleri şöyle... Hasta mı değil mi?"

# Önce hastaların bilgilerini elle ("manuel") girelim:
yeni_hastalar <- data.frame(
    npreg = c(4, 1), # Hamilelik (Hasta 1: 4, Hasta 2: 1)
    glu = c(148, 85), # Şeker
    bp = c(72, 66), # Tansiyon
    skin = c(35, 29), # Deri
    bmi = c(24.6, 26.6), # Kilo (Sorudaki değerler)
    ped = c(0.627, 0.351), # Genetik
    age = c(40, 17) # Yaş
)
# NOT: data.frame içindeki sütun isimleri (glu, bp...) orjinal veriyle BİREBİR AYNI olmalı!

# Tahmin Et (Random Forest kullanarak)
tahminler <- predict(model_rf, newdata = yeni_hastalar)

print(tahminler)
# Çıktı örneği:
# [1] Yes No
# Demek ki 1. Hasta Diyabet, 2. Hasta Sağlam.
