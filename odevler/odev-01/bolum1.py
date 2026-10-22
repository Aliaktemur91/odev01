# ============================================
# Soru 1.1 - İz sürme
# ============================================

# Tablo:
# Adım | i | numbers[i] | total | result
# 1    | 0 | 4          | 4     | []
# 2    | 1 | 7          | 4     | [7]
# 3    | 2 | 2          | 6     | [7]
# 4    | 3 | 9          | 6     | [7, 9]
# 5    | 4 | 5          | 6     | [7, 9, 5]
# 6    | 5 | 1          | 6     | [7, 9, 5, 1]
# 7    | 6 | 8          | 14    | [7, 9, 5, 1]

# Tahminim: total = 14, result = [7, 9, 5, 1]
# Kodu çalıştırdım tahmin tuttu

numbers = [4, 7, 2, 9, 5, 1, 8]
total = 0
result = []

for i in range(len(numbers)):
    if numbers[i] % 2 == 0:
        total = total + numbers[i]
    else:
        result.append(numbers[i])

print("Soru 1.1 Çiktisi:")
print("total:", total)
print("result:", result)
print("-" * 40)


## ============================================
# Soru 1.2 - En uzun seri
# ============================================

"""
Sözde kod:
- current = 0 (şu anki seri)
- max_length = 0 (en uzun seri)

Her sayiyi tek tek kontrol et:
  Eğer sayi > 22 ise:
      current'i 1 artir
      current, max_length'ten büyükse max_length'i güncelle
  Değilse:
      current'i 0 yap (seri bozuldu)

En sonda max_length'i yazdir
"""

readings = [18, 21, 23, 25, 24, 26, 27, 19, 20, 22, 23, 24, 25, 26]
threshold = 22

current = 0
max_length = 0

for value in readings:
    if value > threshold:
        current = current + 1
        if current > max_length:
            max_length = current
    else:
        current = 0

print("Soru 1.2 Çiktisi:")
print("En uzun seri:", max_length)
print("-" * 40)

# ============================================
# Soru 1.3 - Elle gruplama
# ============================================

records = [
    {"student": "Ece", "course": "VTYS"},
    {"student": "Ali", "course": "Yapay Zeka"},
    {"student": "Ece", "course": "Yapay Zeka"},
    {"student": "Can", "course": "VTYS"},
    {"student": "Ali", "course": "VTYS"},
    {"student": "Ece", "course": "Robotik"},
]

course_counts = {}

for record in records:
    course_name = record["course"]
    if course_name in course_counts:
        course_counts[course_name] += 1
    else:
        course_counts[course_name] = 1

print("Soru 1.3 Çiktisi:")
print(course_counts)