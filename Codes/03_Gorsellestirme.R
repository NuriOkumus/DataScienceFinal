# 03_Gorsellestirme.R
# Konu: Veri Görselleştirme (Histogram & Feature Plot)
# Kütüphaneler: caret (Sınavda %100 istenir), MASS

library(MASS)
library(caret)

data(Pima.tr)

# 1. Histogram: Simetrik Dağılım Bulan Dedektif (Soru 2)
# Hangi değişkenler "Normal Dağılım"a (Çan Eğrisi) benziyor?

# Par(mfrow) komutu: Ekranı bölmek için (2 satır, 4 sütun)
par(mfrow = c(2, 4))

# Döngü ile hepsini çizelim
for (i in 1:7) {
    hist(Pima.tr[, i],
        main = names(Pima.tr)[i], # Başlık
        xlab = "Değer", # X ekseni
        col = "lightblue"
    )
}
# YORUM: Grafidere bak.
# - "glu" ve "bp" genelde simetriğe yakın çıkar.
# - "age" ve "ped" genelde sağa çarpıktır (sol tarafta yığılma).

# Ekranı sıfırla
par(mfrow = c(1, 1))


# 2. Feature Plot: En İyi Ayırt Ediciyi Bulmak (Soru 3)
# Hangi özellik (Feature), Hasta (Yes) ile Sağlıklıyı (No) en iyi ayırır?

# x: Değişkenler (Sütun 1'den 7'ye)
# y: Sonuç (Sütun 8 - type)
# plot: "box" (Kutu grafiği en net olanıdır)
# scales: İlişkileri rahat görelim diye serbest bıraktık
# auto.key: Lejant ekle
featurePlot(
    x = Pima.tr[, 1:7],
    y = Pima.tr$type,
    plot = "box",
    scales = list(y = list(relation = "free")),
    auto.key = list(columns = 2)
)

# YORUM YAPMA TAKTİĞİ:
# - İki kutu (Pembe ve Mavi) birbirinden ne kadar UZAK duruyorsa, o değişken o kadar iyidir.
# - "Glu" (Şeker) değişkenine bak: Yes kutusu yukarıda, No kutusu aşağıdadır. AYRIM NETTİR.
# - "Skin" veya "Bp"ye bak: Kutular neredeyse aynı hizada. AYRIM KÖTÜDÜR.
# - SONUÇ: Diyabeti en iyi sınıflandıran değişken "glu"dur.
