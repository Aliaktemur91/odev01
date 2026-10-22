# Bölüm 2: Veritabanı Kavramları

### 1. Excel ve Veritabanı Karşılaştırması
Bir kurumun verilerini Excel'de tutması durumunda karşılaşacağı üç somut sorun ve veritabanı çözümleri şunlardır:

* **Eşzamanlı Erişim ve Çakışma:** Excel dosyasına aynı anda birden fazla kişi erişip değişiklik yaptığında veri çakışması veya veri kaybı yaşanır. Veritabanı yönetim sistemleri ise eşzamanlı işlemleri (concurrency) transaction ve kilitleme mekanizmalarıyla güvenli şekilde yönetir.
* **Veri Bütünlüğü ve Tekrarı (Redundancy):** Excel'de aynı verinin birden fazla yere hatalı veya farklı biçimlerde girilmesini engellemek zordur. Veritabanı ilişkisel yapılar, birincil/yabancı anahtarlar (PK/FK) ve kısıtlamalar (constraints) sayesinde veri tekrarını önler ve bütünlüğü korur.
* **Performans ve Ölçeklenebilirlik:** Excel satır sayısı arttıkça yavaşlar, büyük veri setlerinde kilitlenir veya açılmaz. Veritabanları milyonlarca satırlık veriyi indeksleme yapısı sayesinde milisaniyeler içinde sorgulayıp işleyebilir.

---

### 2. Birincil Anahtar (Primary Key)
Birincil anahtar, bir tablodaki her bir satırı (kaydı) benzersiz (unique) kılan ve boş bırakılamayan (NOT NULL) sütun veya sütun grubudur. 

Öğrenci numarası her öğrenciye özel tanımlandığı, değişmediği ve benzersiz olduğu için ideal bir birincil anahtardır. Ad soyad ise iyi bir birincil anahtar değildir; çünkü aynı ad ve soyada sahip birden fazla öğrenci olabilir (çakışma yaşanır) ve isimlerdeki yazım değişiklikleri ilişkisel bütünlüğü bozar.

---

### 3. DBMS (VTYS) ve Veritabanı Farkı
Veritabanı, bilginin düzenli bir biçimde depolandığı veri koleksiyonunun kendisidir. Veritabanı Yönetim Sistemi (DBMS) ise bu veritabanını oluşturmayı, sorgulamayı, güncellemeyi, güvenliğini sağlamayı ve yönetmeyi sağlayan yazılımdır.

**PostgreSQL**, bu ikiliden bir Veritabanı Yönetim Sistemidir (DBMS / RDBMS).

---

### 4. Eşzamanlı Değişiklik Çakışması
Aynı anda iki kişi aynı kaydı değiştirmeye kalkarsa, DBMS eşzamanlılık denetimi (concurrency control) mekanizmasıyla ilgili kaydı kilitler (locking), işlemleri sıraya koyar ve veri bütünlüğü bozulmadan birinin işlemini tamamlayıp diğerininkini uygular veya çakışma durumunda birini iptal eder.