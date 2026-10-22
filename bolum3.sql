-- ============================================
-- BÖLÜM 3: SELECT ve WHERE (llm_ops veritabanı)
-- ============================================

-- Soru 1: Bütün çağrıların id'sini ve model adını listele.
SELECT id, model_name
FROM llm_calls;
-- 12 satır döndü.


-- Soru 2: Model adını model, toplam token sayısını (prompt + completion) total_tokens başlığıyla göster.
SELECT model_name AS model, 
       (prompt_tokens + completion_tokens) AS total_tokens
FROM llm_calls;
-- 12 satır döndü.


-- Soru 3: Gecikmesi 2 saniyeyi aşan çağrılar (2000 ms üstü).
SELECT *
FROM llm_calls
WHERE latency_ms > 2000;
-- 5 satır döndü.


-- Soru 4: Ece'nin yaptığı çağrılar.
SELECT *
FROM llm_calls
WHERE user_name = 'Ece';
-- 3 satır döndü.


-- Soru 5: Sohbet (chat) dışındaki çağrılar.
SELECT *
FROM llm_calls
WHERE task_type <> 'chat';
-- 9 satır döndü.


-- Soru 6: Adı claude ile başlayan modellere yapılan, 1 saniyeden yavaş çağrılar.
SELECT *
FROM llm_calls
WHERE model_name LIKE 'claude%' 
  AND latency_ms > 1000;
-- 2 satır döndü.


-- Soru 7: Kod veya çeviri işi olan, maliyeti 0.01 doları aşan çağrılar.
SELECT *
FROM llm_calls
WHERE (task_type = 'code' OR task_type = 'translate') 
  AND cost_usd > 0.01;
-- 3 satır döndü.


-- Soru 8: Gecikmesi 500 ile 1500 ms arasındaki çağrılar (uçlar dahil).
SELECT *
FROM llm_calls
WHERE latency_ms BETWEEN 500 AND 1500;
-- 3 satır döndü.


-- Soru 9: gpt ailesine (gpt-4o, gpt-4o-mini) yapılan çağrılar.
SELECT *
FROM llm_calls
WHERE model_name IN ('gpt-4o', 'gpt-4o-mini');
-- 4 satır döndü.


-- Soru 10: Model adında "mini" geçen çağrılar (büyük/küçük harf duyarsız).
SELECT *
FROM llm_calls
WHERE model_name ILIKE '%mini%';
-- 1 satır döndü.


-- Soru 11: Önce kullanıcıya, kullanıcı içinde maliyete (pahalıdan ucuza) göre sırala.
SELECT *
FROM llm_calls
ORDER BY user_name ASC, cost_usd DESC;
-- 12 satır döndü.


-- Soru 12: En pahalı 3 çağrı.
SELECT *
FROM llm_calls
ORDER BY cost_usd DESC NULLS LAST
LIMIT 3;
-- 3 satır döndü.


-- Soru 13: Hangi iş türleri (task_type) var? (Tekrarsız liste).
SELECT DISTINCT task_type
FROM llm_calls;
-- 5 satır döndü.


-- Soru 14: Kullanıcı adlarını doğru Türkçe alfabe sırasıyla, tekrarsız listele.
SELECT DISTINCT user_name
FROM llm_calls
ORDER BY user_name COLLATE "tr-TR-x-icu" ASC;
-- 6 satır döndü (NULL dahil).


-- Soru 15: 14 Ekim'den sonra yapılan, 1 saniyeden yavaş çağrıların id'sini, modelini ve gecikmesini en yavaştan başlayarak listele.
SELECT id, model_name, latency_ms
FROM llm_calls
WHERE created_at > '2026-10-14' 
  AND latency_ms > 1000
ORDER BY latency_ms DESC;
-- 5 satır döndü.