# 01. Eksik Veri (Missing Data) ve MICE

## 1. Neden Veri Eksik? (Missing Data Mechanisms)

Veri setindeki boşlukların (NA) sebebi, `mice` paketinin başarısını doğrudan etkiler. 3 ana kategori vardır:

### A. MCAR (Missing Completely at Random)
*   **Türkçesi:** Tamamen Rastgele Kayıp.
*   **Mantık:** Verinin eksik olması şans eseridir. Ne eksik değerin kendisiyle ne de diğer değişkenlerle bir ilişkisi vardır.
*   **Örnek:** Laboratuvarda bir tüpün yanlışlıkla kırılması.
*   **Çözüm:** En zararsız türdür. Satırı silseniz (`na.omit`) bile analiz bozulmaz (veri kaybı dışında).

### B. MAR (Missing at Random)
*   **Türkçesi:** Rastgele Kayıp (Ama Gözlemlenebilen Bir Değişkene Bağlı).
*   **Mantık:** Eksiklik, veri setindeki *başka bir değişkene* bağlıdır.
*   **Örnek:** Kadınların yaşlarını söyleme eğilimi erkeklere göre daha düşük olabilir. Burada "Yaş" verisinin eksikliği, "Cinsiyet" değişkenine bağlıdır.
*   **Önemi:** `mice` paketi ve modern yöntemler (PMM) varsayılan olarak **bu durumu varsayar**.
*   **Çözüm:** Diğer değişkenleri kullanarak eksik veriyi tahmin etmek (Imputation) çok başarılı sonuç verir.

### C. MNAR (Missing Not at Random)
*   **Türkçesi:** Rastgele Olmayan Kayıp.
*   **Mantık:** Eksiklik, **eksik olan değerin kendisine** bağlıdır. En tehlikeli durumdur.
*   **Örnek:** Çok kilolu insanlar, tartılmak istemedikleri için kilo verisi eksiktir. Kilo verisi eksik çünkü kilonun kendisi yüksek.
*   **Sorun:** `mice` bu durumu doğrudan düzeltemez çünkü verinin neden eksik olduğunu "göremez".

---

## 2. MICE ve PMM (Predictive Mean Matching)

`mice` paketi (Multivariate Imputation by Chained Equations), eksik verileri doldurmak için en popüler araçtır. Varsayılan yöntemi **PMM**'dir.

### PMM Nasıl Çalışır? (Basit Mantık)
PMM, eksik veriyi doldurmak için **gerçek** bir değer kopyalar. Matematiksel bir ortalama yazmaz.

1.  **Regresyon Modeli Kur:** Eksik değişkeni (örn: BMI), diğer değişkenleri (Yaş, Şeker) kullanarak tahmin edecek bir model kurar.
2.  **Tahmin Et:** Eksik olan satır için bir BMI değeri tahmin eder (örn: 28.4).
3.  **Benzerini Bul (Donor):** Veri setinde BMI değeri **dolu** olan kişiler arasında, tahmini 28.4'e en yakın olan kişiyi bulur.
4.  **Kopyala:** O benzer kişinin (donörün) **gerçek** BMI değerini (örn: 28.1) alıp eksik yere yazar.

### Neden PMM Harika?
*   **Gerçekçi Değerler:** Asla 2.5 çocuk veya -5 tansiyon gibi imkansız sayılar üretmez. Çünkü veri setinden gerçek bir sayı kopyalar.
*   **Dağılımı Korur:** Verinin orijinal şeklini (varyansını) bozmaz.

---

### Sınav İpucu: mice(m=5) Parametresi
*   **m=5 ne demek?** `mice` fonksiyonu veriyi 5 kere farklı şekillerde doldurur ve 5 farklı veri seti oluşturur.
*   **Neden?** Tek bir doldurma işlemi hataya açık olabilir. 5 farklı tahmin yaparak belirsizliği (uncertainty) modele katmış oluruz.
*   **Sonuç:** `pool()` fonksiyonu bu 5 farklı havuzun sonuçlarını birleştirir.
