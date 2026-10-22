-- ============================================
-- BÖLÜM 4: Gruplama ve NULL (llm_ops veritabanı)
-- ============================================

-- Soru 1: Kaç çağrı kaydedilmiş?
SELECT COUNT(*) AS toplam_cagri
FROM llm_calls;
-- 12 satır döndü.
-- YORUM: Veritabanında toplam 12 adet LLM çağrısı kayıtlıdır.


-- Soru 2: Kaç çağrı 2 saniyeden yavaş?
SELECT COUNT(*) AS yavas_cagri_sayisi
FROM llm_calls
WHERE latency_ms > 2000;
-- 5 satır döndü.
-- YORUM: 12 çağrıdan 5 tanesi 2000 ms eşiğini aşarak yavaş kategorisine girmiştir.


-- Soru 3: Toplam maliyet ve toplam token sayısı.
SELECT SUM(cost_usd) AS toplam_maliyet, 
       SUM(prompt_tokens + completion_tokens) AS toplam_token
FROM llm_calls;
-- 1 satır döndü.
-- YORUM: Sistem genelinde harcanan toplam maliyet ve tüketilen toplam token miktarı özetlenmiştir (NULL maliyetler SUM'a dahil edilmez).


-- Soru 4: Ortalama gecikme (bir ondalık basamağa yuvarlanmış).
SELECT ROUND(AVG(latency_ms), 1) AS ortalama_gecikme_ms
FROM llm_calls;
-- 1 satır döndü.
-- YORUM: Çağrıların ortalama yanıt süresi hesaplanmıştır; sistem performansının genel seviyesini gösterir.


-- Soru 5: En hızlı ve en yavaş çağrı.
SELECT MIN(latency_ms) AS en_hizli_ms, 
       MAX(latency_ms) AS en_yavas_ms
FROM llm_calls;
-- 1 satır döndü.
-- YORUM: En hızlı ve en yavaş çağrılar arasındaki fark, farklı modellerin ve görevlerin karmaşıklığını yansıtır.


-- Soru 6: Her iş türünde (task_type) kaç çağrı var?
SELECT task_type, COUNT(*) AS cagri_sayisi
FROM llm_calls
GROUP BY task_type;
-- 5 satır döndü.
-- YORUM: 5 farklı iş türü olduğu için 5 satır dönmüştür. GROUP BY her benzersiz task_type için bir özet satırı oluşturur.


-- Soru 7: Her model için çağrı sayısı ve toplam maliyet (pahalıdan ucuza).
SELECT model_name, 
       COUNT(*) AS cagri_sayisi, 
       SUM(cost_usd) AS toplam_maliyet
FROM llm_calls
GROUP BY model_name
ORDER BY toplam_maliyet DESC NULLS LAST;
-- 6 satır döndü.
-- YORUM: Maliyeti en yüksek olan modeller üstte yer alarak bütçe yoğunluğunu gösterir.


-- Soru 8: Her kullanıcının her iş türünden kaç çağrısı var?
SELECT user_name, task_type, COUNT(*) AS cagri_sayisi
FROM llm_calls
GROUP BY user_name, task_type;
-- 11 satır döndü.
-- YORUM: Kullanıcı ve iş türü kombinasyonları gruplanmıştır. NULL kullanıcı da ayrı bir grup olarak görünür.


-- Soru 9: İkiden fazla çağrı almış modeller.
SELECT model_name, COUNT(*) AS cagri_sayisi
FROM llm_calls
GROUP BY model_name
HAVING COUNT(*) > 2;
-- 1 satır döndü.
-- YORUM: "İkiden fazla" ifadesi > 2 anlamına gelir. Sadece 3 veya daha fazla çağrısı olan modeller listelenir.


-- Soru 10: Sadece 500 ms'den yavaş çağrıları hesaba kat; en az 2 çağrısı olan modelleri ortalama gecikmesiyle göster.
SELECT model_name, AVG(latency_ms) AS ortalama_gecikme
FROM llm_calls
WHERE latency_ms > 500
GROUP BY model_name
HAVING COUNT(*) >= 2;
-- 3 satır döndü.
-- YORUM: WHERE gruplamadan önce 500 ms altındakileri eledi, HAVING ise gruplama sonrası en az 2 kaydı olan modelleri tuttu.


-- Soru 11: NULL avı. Tek bir sorguda count(*) ile her sütunun count'unu yan yana koy.
SELECT COUNT(*) AS toplam_satir,
       COUNT(id) AS id_dolu,
       COUNT(model_name) AS model_dolu,
       COUNT(user_name) AS user_name_dolu,
       COUNT(cost_usd) AS cost_dolu,
       COUNT(latency_ms) AS latency_dolu
FROM llm_calls;
-- 1 satır döndü.
-- YORUM: COUNT(*) tüm satırları sayar. COUNT(sütun) ise sadece NULL olmayanları sayar. Aradaki fark eksik veri sayısını verir.


-- Soru 12: Faturası gelmemiş çağrıları listele.
SELECT *
FROM llm_calls
WHERE cost_usd IS NULL;
-- 1 satır döndü.
-- YORUM: SQL'de = NULL çalışmaz (UNKNOWN döner). Eksik verileri bulmak için IS NULL kullanılmalıdır.


-- Soru 13: İki ortalama (boşları atlayarak vs. sıfır sayarak).
SELECT AVG(cost_usd) AS boslari_atlayan_ortalama,
       AVG(COALESCE(cost_usd, 0)) AS sifir_kabul_eden_ortalama
FROM llm_calls;
-- 1 satır döndü.
-- YORUM: AVG(cost_usd) NULL'ları yok sayar. COALESCE ile 0 kabul etmek ortalamayı düşürür. Faturalandırılan gerçek harcama için ilk ortalama daha dürüsttür.


-- Soru 14: Günlük kullanım raporu: gün, çağrı sayısı, toplam maliyet.
SELECT DATE(created_at) AS gun,
       COUNT(*) AS cagri_sayisi,
       SUM(cost_usd) AS toplam_maliyet
FROM llm_calls
GROUP BY DATE(created_at)
ORDER BY gun;
-- 5 satır döndü.
-- YORUM: Her gün için çağrı sayısı ve maliyet özetlenmiştir. Yoğun günlerde daha ucuz modeller kullanıldığı için maliyet beklenenden düşük kalabilir.


-- Soru 15: Gecikmeye göre kategorilendirme ve gruplama.
SELECT CASE 
         WHEN latency_ms < 1000 THEN 'Hizli'
         WHEN latency_ms BETWEEN 1000 AND 2499 THEN 'Orta'
         WHEN latency_ms >= 2500 THEN 'Yavas'
         ELSE 'Bilinmiyor'
       END AS gecikme_kategorisi,
       COUNT(*) AS cagri_sayisi,
       ROUND(AVG(latency_ms), 1) AS ortalama_gecikme
FROM llm_calls
GROUP BY CASE 
           WHEN latency_ms < 1000 THEN 'Hizli'
           WHEN latency_ms BETWEEN 1000 AND 2499 THEN 'Orta'
           WHEN latency_ms >= 2500 THEN 'Yavas'
           ELSE 'Bilinmiyor'
         END;
-- 3 satır döndü.
-- YORUM: CASE WHEN ile gecikme değerleri 3 kategoriye ayrılmış ve her kategorinin çağrı sayısı ile ortalama gecikmesi hesaplanmıştır.