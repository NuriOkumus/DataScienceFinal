# 02_PCA_Uygulama.R
# Konu: Principal Component Analysis (PCA)
# Odak: scale=TRUE, Scree Plot, Loadings

# Kütüphaneleri Yükle
library(MASS) # Pima verisi için
library(tidyverse) # ggplot2 ve veri manipülasyonu için

# 1. Veriyi Hazırla
data(Pima.tr)

# PCA sadece sayısal değişkenlere uygulanır.
# Son sütun "type" kategorik olduğu için çıkarıyoruz.
Pima_numeric <- Pima.tr[, -8]

# Kontrol
head(Pima_numeric)

# 2. PCA Uygula (prcomp)
# scale = TRUE : Çok ÖNEMLİ! Değişkenleri aynı ölçeğe getirir.
pca_result <- prcomp(Pima_numeric, scale = TRUE)

# Özet Sonuçlar
summary(pca_result)
# "Proportion of Variance": O eksenin açıkladığı varyans oranı.
# "Cumulative Proportion": Toplam açıklanan varyans (Genelde %70-80 hedeflenir).

# 3. Yükler (Loadings / Rotation)
# Hangi değişken hangi PC'yi oluşturuyor? (Dedektiflik Kısmı)
print(pca_result$rotation)

# --- DETAYLI YORUMLAMA (SINAV İÇİN) ---
# Tablodan çıkan rakamların anlamı:

# PC1: "Genel Metabolik Bozulma" (Kral Değişken)
# - Hakim Güçler: age, skin, bp, bmi, glu, npreg (Hepsi aynı yönde, genelde negatif)
# - Yorum: PC1 skoru negatif yönde yüksek olan hastalar;
#   Yaşlı, kilolu, tansiyonu yüksek ve çok doğum yapmış kişilerdir.
#   Bu bileşen hastanın genel sağlık durumunun kötülüğünü temsil eder.

# PC2: "Genç/Genetik Obezite vs. Yaşlılık"
# - Pozitif (+): bmi, ped, skin (Kilo ve Genetik)
# - Negatif (-): age, npreg (Yaş ve Doğum)
# - Yorum: PC2 skoru YÜKSEK olanlar -> GENÇ ama GENETİK olarak obez riskinde olanlar.
#   PC2 skoru DÜŞÜK olanlar -> YAŞLI ama daha zayıf (yaşlılığa bağlı riskler).

# 4. Görselleştirme 1: Scree Plot (Elbow Method)
# Varyansları çizelim
screeplot(pca_result,
    type = "lines",
    main = "Scree Plot of Pima Data"
)
# Yorum: Grafik nerede "dirsek" yapıp düzleşiyor? (Genelde 3. PC'den sonrası çöp)

# 5. Görselleştirme 2: Biplot
# Hem gözlemleri (noktalar) hem değişkenleri (oklar) aynı anda gösterir
biplot(pca_result, scale = 0, cex = 0.6)
# - Okların Yönü: Birbirine yakın oklar (örn: skin ve bmi) "kanka"dır (pozitif korelasyon).
# - Okların Zıtlığı: Zıt yöne bakan oklar (örn: age ve ped gibi) negatif ilişkilidir.
# - Okların Boyu: Ok ne kadar uzunsa, o değişken PC'leri o kadar çok etkiliyordur.

# 6. Sınav Sorusu: PC Skorlarını Tahmin Etme (predict)
# Yeni bir veri geldiğinde (örn: Pima.te), mevcut PCA modeline göre yerini bulma
test_data_numeric <- Pima.te[, -8]
test_scores <- predict(pca_result, newdata = test_data_numeric)
head(test_scores)
