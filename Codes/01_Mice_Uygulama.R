# 01_Mice_Uygulama.R
# Konu: Eksik Veri Doldurma (Missing Data Imputation)
# Paketler: mice, VIM (Görselleştirme için)

# Kütüphaneleri Yükle
library(mice)
library(MASS) # Pima veriseti için

# 1. Veriyi Hazırla (Sınav Senaryosu)
# Pima.tr verisetini kullanalım (MASS kütüphanesinden)
data(Pima.tr)
summary(Pima.tr)

# Sınavda bazen kendi eksik verimizi yaratmamız istenebilir veya var olanı inceleriz.
# Örnek: Rastgele NA değeri atayalım (Eğitim amaçlı)
set.seed(123)
Pima_miss <- Pima.tr
Pima_miss[sample(1:nrow(Pima_miss), 20), "bmi"] <- NA # BMI değişkeninde 20 rastgele kayıp

# 2. Eksik Veri Analizi (Pattern)
# md.pattern() fonksiyonu eksik verinin yapısını gösterir.
# Hangi satırlarda eksik var? Sadece BMI mı eksik?
md.pattern(Pima_miss)

# 3. MICE ile Doldurma (Imputation)
# m=5 : 5 farklı doldurulmuş veri seti oluştur.
# method='pmm' : Predictive Mean Matching (Varsayılan ve en güvenlisi)
# maxit=5 : Her doldurma için 5 iterasyon (Hızlı olsun diye az tuttuk, default 5-10)
imputed_data <- mice(Pima_miss, m = 5, method = 'pmm', maxit = 5, seed = 500)

# Özeti görelim
summary(imputed_data)

# 4. Doldurulmuş Veriyi Çekme (Complete)
# Eylemlerden birini seçip tam veri setini almak için complete() kullanılır.
# action=1 : 1 numaralı doldurulmuş veriyi getir.
completed_data_1 <- complete(imputed_data, action = 1)

# Kontrol edelim: Artık NA var mı?
sum(is.na(completed_data_1)) # 0 olmalı

# 5. Modelleme ve Pooling (Sınavda sorulursa yapılacak kısım)
# Burası "veriyi doldurma" işlemi değildir. Doldurduğumuz veriyle "ANALİZ YAPMA" kısmıdır.
# Soru: "BMI değerini, yaş (age) ve şeker (glu) değişkenleri ile tahmin edebilir miyiz?"

# with() fonksiyonu: "Elimdeki 5 farklı veri setinin HER BİRİYLE ayrı ayrı bu analizi yap" der.
fit_mice <- with(data = imputed_data, exp = lm(bmi ~ age + glu + npreg))

# pool() fonksiyonu: "5 farklı analiz sonucunu al, ortalamasını alarak bana TEK BİR SONUÇ ver" der.
pooled_results <- pool(fit_mice)

# Sonuçları görelim (Hangi değişken BMI üzerinde etkili?)
summary(pooled_results)
