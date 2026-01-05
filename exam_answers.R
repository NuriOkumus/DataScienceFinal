# SE 3509 Introduction to Data Science & Engineering
# Final Sinav Hazirlik Cevaplari

# Gerekli kütüphanelerin yüklenmesi
library(MASS)
library(caret)
library(mice)
library(tidyverse)

# Verinin yüklenmesi
data("Pima.tr")
data("Pima.te")

# 1. Missing Values check: Check whether the datasets includes any missing values.
# 0’s are missing for the variables except for npreg and type. NA’s are missing for all variables.

# NA kontrolü (Tüm değişkenler için)
anyNA(Pima.tr)
anyNA(Pima.te)

# 0 kontrolü (npreg ve type hariç)
# npreg ve type dışındaki sütunlardaki 0'ları NA yapabiliriz kontrol etmek için
tr_temp <- Pima.tr
tr_temp[, 2:7][tr_temp[, 2:7] == 0] <- NA
sum(is.na(tr_temp)) # Kaç tane eksik veri olduğunu verir

# 2. Symmetric Distribution: Explore the attributes and write down the ones that have symmetric distribution using the training dataset.

# Histogramlar ile dağılımı kontrol edebiliriz
par(mfrow = c(3, 3))
for (i in 1:7) {
    hist(Pima.tr[, i], main = colnames(Pima.tr)[i], col = "skyblue")
}
# Yorum: bmi, glu ve bp nispeten simetrik (normal) bir dağılım göstermektedir.
# npreg ve age sağ çarpıktır (skewed).

# 3. Feature Plot: Create a feature plot and evaluate the attributes that best classify the response using the training dataset.

featurePlot(
    x = Pima.tr[, 1:7],
    y = Pima.tr$type,
    plot = "box",
    scales = list(y = list(relation = "free"), x = list(rot = 90))
)
# Yorum: glu (glikoz) ve bmi (vücut kitle indeksi) kutu grafiklerinde
# "Yes" ve "No" grupları arasında en belirgin farkı göstermektedir, bu yüzden en iyi ayırt edicilerdir.

# 4. Cross Validation: Create a cross validation object for 10 fold CV with 5 replicates.

ctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 5)

# 5. Model Training: Train logistic regression and random forest models using centered and scaled predictors.

# Logistic Regression
set.seed(123)
model_logit <- train(type ~ .,
    data = Pima.tr, method = "glm", family = "binomial",
    preProcess = c("center", "scale"), trControl = ctrl
)

# Random Forest
set.seed(123)
model_rf <- train(type ~ .,
    data = Pima.tr, method = "rf",
    preProcess = c("center", "scale"), trControl = ctrl
)

# 6. Model Evaluation: Create confusion matrices where the positive class is “Yes”.
# Write down the accuracy, sensitivity and specificity scores for each model. Which one would you prefer?

# Tahminler
pred_logit <- predict(model_logit, Pima.te)
pred_rf <- predict(model_rf, Pima.te)

# Confusion Matrices
cm_logit <- confusionMatrix(pred_logit, Pima.te$type, positive = "Yes")
cm_rf <- confusionMatrix(pred_rf, Pima.te$type, positive = "Yes")

print(cm_logit)
print(cm_rf)

# Yorum: Accuracy (Doğruluk), Sensitivity (Duyarlılık - Hasta olanı bulma)
# ve Specificity (Özgüllük - Sağlıklı olanı bulma) değerlerini çıktılardan yazmalısın.
# Genellikle en yüksek Accuracy ve dengeli Sens/Spec değerine sahip model tercih edilir.

# 7. Prediction: Suppose two patients come with the following measurements.
# What would be the predicted classes for these two patients?

new_patients <- data.frame(
    npreg = c(4, 1),
    glu = c(148, 85),
    bp = c(72, 66),
    skin = c(35, 29),
    bmi = c(24.6, 26.6),
    ped = c(0.627, 0.351),
    age = c(40, 17)
)

predict(model_logit, new_patients)

# 8. PCA: Perform a Principal Component Analysis on the 7 numerical predictors of the Pima.tr dataset.
# Summarize the PCs and explain the cumulative variance contribution of the first 3 PCs.

pca_result <- prcomp(Pima.tr[, 1:7], scale = TRUE)
summary(pca_result)
# Yorum: "Cumulative Proportion" satırına bakarak ilk 3 PC'nin toplam varyansın
# ne kadarını açıkladığını (örneğin %70) belirtebilirsin.

# 9. Scale Necessity: Explain the statistical necessity of the scale = TRUE argument.

# Yorum: Değişkenlerin birimleri birbirinden farklıdır (Örn: age yıl iken glu mg/dL'dir).
# Eğer ölçekleme (scaling) yapılmazsa, sayısal olarak daha büyük değerlere sahip olan
# değişkenler PCA üzerinde haksız bir etki (dominance) yaratır.
# scale = FALSE olursa, loadings (ağırlıklar) sadece büyük değerli değişkenlere odaklanır.

# 10. Scree Plot: Produce a Scree Plot of the variances. Define the Elbow Method.

plot(pca_result, type = "l", main = "Scree Plot")
# Elbow Method (Dirsek Yöntemi): Grafik üzerinde varyansın düşüş hızının
# aniden azaldığı ("dirsek" yaptığı) nokta, seçilecek ideal bileşen sayısını gösterir.

# 11. PCA Interpretation:
# (a) PC1'de yüksek negatif skoru olan bir hastanın yorumu:
# Yorum: PC1; age, npreg ve glu ile pozitif yüklü ise, PC1 skoru yüksek olanlar "yaşlı, daha çok hamilelik geçirmiş ve yüksek glikozlu" kişilerdir.
# Bu durumda yüksek NEGATİF skor, bu değişkenlerin DÜŞÜK olduğu (yani genç, az hamilelik geçirmiş ve düşük glikozlu) kişileri temsil eder.

# (b) age ve glu'nun PC1'de her ikisinin de pozitif yükü varken negatif korelasyonlu olmaları mümkün mü?
# Yorum: Evet, matematiksel olarak mümkündür. PC1 bu değişkenlerin ortak bir eğilimini (genel sağlık/yaş durumu) temsil eder ancak
# bu, değişkenlerin kendi aralarında her zaman aynı yönde hareket edeceği anlamına gelmez. PCA, varyansı maksimize eder, korelasyonu değil.

# 12. PCA in Regression:
# (a) Avantaj (Multicollinearity): PC'ler birbirine diktir (orthogonal), yani aralarında korelasyon yoktur.
# Bu sayede regresyon modellerindeki çoklu doğrusal bağlantı (multicollinearity) sorunu tamamen çözülür.

# (b) Maliyet (Interpretability): PC'ler orijinal değişkenlerin doğrusal kombinasyonlarıdır.
# Bir doktora "PC1 skorunuz yüksek" demek klinik olarak anlamsızdır; çünkü PC1'in tam olarak neyi temsil ettiğini anlamak zordur.

# 13. Regression Assumptions:
model_bmi <- lm(bmi ~ . - type, data = Pima.tr)
par(mfrow = c(2, 2))
plot(model_bmi)

# (a) Residuals vs Fitted: Noktaların rastgele bir bulut gibi dağılması gerekir.
# Eğer bir "huni" (fan shape) şekli varsa bu Heteroscedasticity (değişen varyans) göstergesidir.
# (b) Normal Q-Q Plot: Noktaların uçlarda çizgiden sapması, hataların Normal Dağılıma uymadığını (kuyruklu dağılım) gösterir.

# 14. Interpretation of Estimates: skin Estimate = 0.395
# (a) Yorum: Diğer tüm değişkenler sabit tutulduğunda, skinfold thickness'taki 1 birimlik artış,
# BMI'da ortalama 0.395 birimlik artışa neden olur.
# (b) Significance: p-value < 2e-16 (yani < 0.05) olduğu için skin değişkeni istatistiksel olarak anlamlı bir belirleyicidir.

# 15. Multicollinearity:
# Nedir: Bağımsız değişkenlerin birbirleriyle yüksek derecede ilişkili (korelasyonlu) olmasıdır.
# Neden sorun: Katsayı tahminlerini (estimates) kararsız hale getirir ve standart hataları büyüterek
# değişkenlerin önemini yanlış değerlendirmemize neden olur.

# 16. R-squared:
summary(model_bmi)
# (a) Multiple R-squared: Modelin hedef değişkendeki (BMI) varyansı ne kadar iyi açıkladığını gösterir (%0 ile %100 arası).
# (b) Adjusted R-squared: Modele her yeni değişken eklendiğinde R-squared her zaman artar (anlamsız olsa bile).
# Adjusted R-squared ise sadece anlamlı değişkenler eklendiğinde artar, anlamsız değişken eklenmesini cezalandırır.

# 17. Stepwise Regression:
full_model <- lm(bmi ~ ., data = Pima.tr) # 'type' sütununu çıkararak denemek gerekebilir
# bmi için sayısal model kuruyoruz:
full_model <- lm(bmi ~ . - type, data = Pima.tr)
step_model <- step(full_model, direction = "backward")

# Değerlendirme: AIC (Akaike Information Criterion) değerine bakılır.
# En düşük AIC değerine sahip model en iyisidir.

# 18. Reduced Model:
# (a) Multiple R-squared: Reduced (azaltılmış) modelin R-squared değeri her zaman full modelden DÜŞÜK veya EŞİT olacaktır.
# (b) Tercih: Daha az değişkenle benzer sonuçlar veren "parsimonious" (basit) modeller,
# aşırı öğrenmeyi (overfitting) engellediği ve daha kolay açıklandığı için tercih edilir.

# 19. Stepwise Criticism:
# Yorum: Stepwise yöntemleri sadece istatistiksel anlamlılığa (AIC) bakar; klinik veya teorik önemi düşünmez.
# Ayrıca çoklu test problemi yaratarak p-değerlerini yanıltıcı hale getirebilir.

# 20. Mice Package (m=5):
# (a) m=5: 5 farklı kopyalanmış (imputed) veri seti oluşturulacağını gösterir.
# (b) Neden m > 1: Veri atamanın (imputation) getirdiği belirsizliği (uncertainty) hesaba katmak için
# birden fazla varyasyon oluşturmak daha güvenilirdir.

# 21. Missing Data Types:
# MCAR: Eksikliğin hiçbir veriyle ilişkisi yok (tamamen şans eseri).
# MAR: Eksikliğin gözlemlenen diğer değişkenlerle ilişkisi var (örn: erkeklerin kilosunu daha az bildirmesi).
# MNAR: Eksikliğin eksik olan değerin kendisiyle ilişkisi var (örn: kilosu çok yüksek olanların tartılmak istememesi).
# EN ZOR: MNAR (mice bunu çözmekte zorlanır çünkü sebep veride yoktur).
# Örnek (Yüksek Tansiyon): MNAR olur (çünkü eksiklik tansiyon değerinin kendisiyle ilişkilidir).

# 22. Pooling:
# (a) lm() neden tek başına yetmez: Tek bir veri seti eksikliğin yarattığı varyasyonu temsil etmez.
# (b) pool(): Farklı imputed veri setlerinden elde edilen sonuçları birleştirir.
# Katsayıların standart hatalarını, verinin orijinalinde eksik olmasından kaynaklanan "belirsizliği" içerecek şekilde büyütür.
