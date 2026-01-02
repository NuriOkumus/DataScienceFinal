# 04_Regresyon.R
# Konu: Lineer Regresyon ve Varsayımlar (Diagnostics)
# Odak: lm(), plot(), step()

library(MASS)
data(Pima.tr)

# 1. Basit bir Model Kuralım
# Hedef: BMI (Kilo indeksi)
# Değişkenler: Diğer her şey (nokta '.' hepsi demek)
# Not: Type (Yes/No) kategorik olduğu için onu şimdilik çıkarıyorum.
model_full <- lm(bmi ~ . - type, data = Pima.tr)

# Model Özeti (Karnesi)
summary(model_full)
# --- YORUMLAMA ---
# Estimate: Katsayı. (Örn: skin için 0.15 ise -> Deri 1 birim artarsa BMI 0.15 artar)
# Pr(>|t|): P-value. Eğer < 0.05 ise o değişken ÖNEMLİDİR (Yıldız alı*).
# Adjusted R-squared: Modelin başarısı. (Örn: 0.50 ise varyansın %50'sini açıklıyoruz).

# ---------------------------------------------------------

# 2. Varsayımları Kontrol Etme (Diagnostics Plots) - ÇOK ÖNEMLİ!
# Ekranı 2x2 bölelim ki 4 grafiği bir arada görelim
par(mfrow = c(2, 2))

plot(model_full)

# --- GRAFİKLER NASIL OKUNUR? ---

# Grafik 1 (Sol Üst): Residuals vs Fitted
# - Soru: "Hata varyansı sabit mi?" (Homoscedasticity)
# - İdeal: Noktalar rastgele dağılmalı. Huni veya Muz şekli OLMAMALI.
# - Pima verisinde: Genelde biraz huni şekli (sağa doğru açılma) görülebilir.

# Grafik 2 (Sağ Üst): Normal Q-Q
# - Soru: "Hatalar normal dağılıyor mu?" (Normality)
# - İdeal: Noktalar çizginin tam üstünde olmalı.
# - Pima verisinde: Uçlarda (baş ve son) çizgiden kopmalar olabilir.

# Grafik 3 (Sol Alt): Scale-Location
# - Grafik 1'in benzeridir, varyans kontrolü yapar. Çizgi düz olmalı.

# Grafik 4 (Sağ Alt): Residuals vs Leverage
# - Soru: "Modeli tek başına bozan aykırı bir veri (Outlier) var mı?"
# - Cook's Distance çizgilerini (kesikli kırmızı) aşan nokta var mı diye bakılır.

# Ekranı düzelt
par(mfrow = c(1, 1))

# ---------------------------------------------------------

# 3. Stepwise Regression (Geriye Doğru Eleme)
# "Hangi değişkenler gereksiz? Otomatik atalım."

# step() fonksiyonu, AIC değerine bakarak en iyi modeli bulana kadar değişken atar.
model_reduced <- step(model_full, direction = "backward")

# En son kalan "Reduced Model"in özeti
summary(model_reduced)

# YORUM:
# Full Model ile Reduced Model'in "Adjusted R-squared" değerlerini kıyasla.
# Genelde Reduced Model daha yüksektir veya çok yakındır (ama daha az değişkenle yapar, yani daha iyidir).
