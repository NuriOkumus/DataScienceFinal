# 05. Sınıflandırma (Classification) Teorisi

Hedefimiz bir sayı tahmin etmek değil, bir **ETİKET** yapıştırmaktır: (Hasta/Sağlıklı, Evet/Hayır).
Bu işte iki temel yöntem kullanırız:

## 1. Logistic Regression (glm)
*   **Mantık:** Lineer regresyonun `S` çizerek 0 ile 1 arasına sıkıştırılmış halidir (Sigmoid fonksiyonu).
*   **Avantajı:** Yorumlaması kolaydır. Hangi değişkenin olasılığı nasıl artırdığını (Odds Ratio) net söyler.
*   **Dezavantajı:** Veri çok karmaşıksa (Linear değilse) başarısız olabilir.

## 2. Random Forest (rf)
*   **Mantık:** "Akıl akıldan üstündür." Tek bir ağaç yerine yüzlerce Karar Ağacı (Decision Tree) kurar. Hepsi oylama yapar. Çoğunluk ne derse o olur.
*   **Avantajı:** Genelde en yüksek başarıyı (Accuracy) bu verir.
*   **Dezavantajı:** "Black Box"tır. Neden o kararı verdiğini anlamak zordur.

---

## 3. Confusion Matrix (Karışıklık Matrisi) - SINAVIN KALBİ ❤️

Model tahminlerini yaptıktan sonra bir tablo oluştururuz:

| | Tahmin: Hasta (Pos) | Tahmin: Sağlam (Neg) |
|---|---|---|
| **Gerçek: Hasta** | **True Positive (TP)** <br> *(Doğru Bildik!)* | **False Negative (FN)** <br> *(Kaçırdık!)* |
| **Gerçek: Sağlam** | **False Positive (FP)** <br> *(Yanlış Alarm!)* | **True Negative (TN)** <br> *(Doğru Bildik!)* |

### Metrikler (Ezberle!)
1.  **Accuracy (Doğruluk):** Toplamda ne kadarını bildik?
    *   `(TP + TN) / Toplam`
2.  **Sensitivity (Duyarlılık - Recall):** Hastaların yüzde kaçını yakaladık? (Doktorlar için en önemlisi!)
    *   `TP / (TP + FN)`
3.  **Specificity (Özgüllük):** Sağlamların yüzde kaçına sağlam dedik?
    *   `TN / (TN + FP)`
