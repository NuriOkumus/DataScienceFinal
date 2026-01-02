# 02. PCA (Principal Component Analysis) Teorisi

## 1. Neden `scale = TRUE` Demeliyiz? (Sınavın Banko Sorusu)

PCA, verideki **varyansı (değişkenliği)** maksimize eden yeni eksenler bulmaya çalışır. Bu yüzden PCA, değişkenlerin **birimlerine (scale)** karşı aşırı duyarlıdır.

*   **Senaryo:** Elimizde `Age` (Yaş, 20-80 arası) ve `Glucose` (Şeker, 80-200 arası) var. Bir de `Insulin` olsun (0-800 arası).
*   **Sorun:** Eğer `scale=TRUE` yapmazsak (yani veriyi standardize etmezsek), PCA sadece sayısal değeri büyük olan değişkeni (Insulin) "en önemli" değişken sanar. Çünkü onun varyansı (sayısal aralığı) matematiksel olarak daha büyüktür.
*   **Çözüm:** `scale=TRUE` diyerek tüm değişkenleri eşitliyoruz (Ortalama=0, Standart Sapma=1). Böylece "Elma ile Armut'u" değil, hepsini "Meyve" standardında karşılaştırabiliriz.

> **Sınav Cevabı Şablonu:** "If we do not set `scale=TRUE`, variables with large ranges (like Insulin) will dominate the Principal Components purely due to their units, masking the contribution of variables with smaller ranges (like Age or Pedigree)."

---

## 2. Scree Plot ve "Elbow Method"

PCA sonucunda kaç tane bileşen (PC) seçeceğimize nasıl karar veririz?

*   **Scree Plot:** Her bir PC'nin açıkladığı varyans oranını gösteren grafik.
*   **Elbow (Dirsek) Method:** Grafiğin "dirsek" yaptığı, yani dik düşüşün bitip düzleşmeye başladığı nokta.
*   **Yorum:** Dirsekten önceki bileşen sayısını seçeriz. "Buradan sonra eklediğim her yeni PC, varyansı açıklamada çok az katkı sağlıyor, değmez" dediğimiz nokta.

---

## 3. Loading (Yük) Değerlerini Yorumlama

`Rotation` matrisindeki değerlere "Loading" denir. O bileşenin hangi orijinal değişkenlerden oluştuğunu anlatır.

*   **PC1 Örneği:**
    *   `Age`: 0.60 (Pozitif, Yüksek)
    *   `Pregnancies`: 0.55 (Pozitif, Yüksek)
    *   `Skin`: -0.10 (Sıfıra yakın, Önemsiz)
*   **Yorum:** PC1, esas olarak **Yaş ve Hamilelik** sayısı ile ilgilidir. Yaş arttıkça ve hamilelik sayısı arttıkça PC1 skoru artar. PC1'e "Yaşlılık/Annelik Faktörü" adını verebiliriz.

*   **Negatif Loading:**
    *   `PC2` için `Insulin`: -0.80 olsun.
    *   Bu, PC2 skoru **arttıkça**, hastanının İnsülin değeri **azalıyor** demektir (Ters orantı).
