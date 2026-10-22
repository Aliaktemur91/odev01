# Ödev 1 Raporu

**Ad Soyad:** Ali Aktemur  
**Öğrenci No:** 202607131015
**PR Bağlantısı:** 

---

### 1. Ne Yaptım?
* **Bölüm 1:** Algoritma adımlarını takip ederek iz sürdüm, kesintisiz en uzun seri algoritmik mantığını kodladım ve Python'da sözlük yapısıyla manuel gruplama yaptım.
* **Bölüm 2:** Veritabanı yönetim sistemlerinin Excel'e göre avantajlarını, birincil anahtar (PK) kavramını ve eşzamanlılık kontrolü mekanizmalarını açıklayıp markdown dosyasına kaydettim.
* **Bölüm 3:** `llm_ops` veritabanında `SELECT`, `WHERE`, `LIKE`, `BETWEEN` ve `ORDER BY` kullanarak filtreleme sorguları çalıştırdım.
* **Bölüm 4:** `GROUP BY`, toplama fonksiyonları (`COUNT`, `AVG`, `SUM`) ve `NULL` değer yönetimi üzerine analiz sorguları yazıp sonuçları yorumladım.

---

### 2. Beklemediğim Bir Sonuç
Bölüm 3 Soru 7'de `AND` ve `OR` operatörlerini parantezsiz kullandığımda beklentimden çok daha fazla satır döndü. `AND` işlem önceliğinin `OR`dan yüksek olduğunu ve parantez kullanılmadığında mantıksal gruplamanın bozulduğunu fark etmek beni şaşırttı.

---

### 3. Bir Hata ve Çözümü
**Hata:** Bölüm 4 Soru 12'de `WHERE cost = NULL` yazdığımda sorgu hata vermedi fakat 0 satır döndürdü.  
**Çözüm:** SQL'de `NULL` değerlerin `=` operatörüyle kıyaslanamadığını (`UNKNOWN` döndürdüğünü) öğrendim ve sorguyu `WHERE cost IS NULL` şeklinde düzelterek eksik kayıtları başarıyla getirdim.

---

### 4. Yapay Zeka Beyanı
 Gemini ve grok modellerinden  faydalandım. sql sorguları ve kod ksımında da yardım aldım 

---

### 5.soruların cevapları 
1. **Parantez Tuzağı:** Parantezsiz kullanımda `AND` öncelikli çalıştığı için koşul bozuldu ve fazladan satır geldi.
2. **Türkçe Sıralama:** `COLLATE "tr-TR-x-icu"` eklenmediğinde Türkçe harfli isimler en sona atılıyordu, ekleyince alfabe sırasına oturdu.
3. **Kayıp Kayıtlar:** `WHERE x < 50` ve `WHERE x >= 50` toplamı tüm satırları vermedi; çünkü `NULL` olan kayıtlar iki koşula da uymayıp elendi.
4. **İki Ortalama:** `AVG(cost.usd)` boş kayıtları atlayarak sadece gerçekleşen faturaları ortalamaya katar. `COALESCE` ile 0 saymak ortalamayı yapay olarak düşürür. Bütçe raporlamasında faturalandırılan ortalama daha dürüst bir seçimdir.