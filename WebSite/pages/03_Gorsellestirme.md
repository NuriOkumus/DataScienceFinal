# 03. Veri Görselleştirme (Data Visualization) Teorisi

Sınavda görselleştirme soruları genellikle iki amaca hizmet eder:
1.  **Dağılımı Anlamak:** "Hangi değişkenler simetrik (normal) dağılıyor?"
2.  **Sınıflandırma Gücünü Görmek:** "Hangi değişken diyabeti (Yes/No) en iyi ayırt ediyor?"

## 1. Histogram (Dağılım Kontrolü)
Histogram, bir veri sütununun (örn: Yaş) nasıl dağıldığını gösterir.
*   **Simetrik (Çan Eğrisi):** Ortada tepe yapan, sağı ve solu birbirine benzeyen grafik. İstatistikte en sevdiğimiz (Normal Dağılım) tiptir.
*   **Çarpık (Skewed):** Kuyruğu sağa (Right Skewed) veya sola uzayan grafikler.
    *   Örn: `Insulin` genelde sağa çarpıktır (çoğu düşük, az sayıda çok yüksek değer).

## 2. Feature Plot (Caret Paketi)
`caret` paketindeki `featurePlot`, birden fazla değişkenin "Type" (Yes/No) ile ilişkisini tek seferde gösterir.

*   **Box Plot (Kutu Grafiği) Olarak:**
    *   Eğer "Yes" kutusu ile "No" kutusu birbirinden **çok ayrı** duruyorsa (biri yukarıda biri aşağıda), o değişken **iyi bir ayırt edicidir**.
    *   Eğer kutular üst üste biniyorsa, o değişkenin sınıflandırma gücü zayıftır.

## 3. Box Plot (Aykırı Değer Avcısı)
Box Plot, verinin çeyreklerini (Quarter) gösterir.
*   **Kutunun dışındaki noktalar:** "Outlier" (Aykırı Değer) olarak kabul edilir.
*   Örn: Diastolik tansiyonu 120 olan biri aykırı değer olabilir.

> **Sınav İpucu:** Hoca "Hangi değişken en iyi sınıflandırır?" diye sorarsa Feature Plot çizip kutuları en ayrık olana bakacağız. "Hangi değişken simetriktir?" derse Histogram çizip çan eğrisine en çok benzeyeni seçeceğiz.
