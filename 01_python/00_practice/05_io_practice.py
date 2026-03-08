'''
### 문제 1. 로그 파일에 기록하기

사용자에게 문장을 입력받아 `logs.txt`에 한 줄로 저장하세요.

1. 파일이 없으면 생성하세요.
2. 기존 내용이 있으면 뒤에 이어쓰기(append) 하세요.
3. 저장 형식은 `"2026-03-05 14:30:10 - 입력내용"` 형태로 저장하세요.

힌트: `datetime`을 사용할 수 있습니다.
'''
from datetime import datetime

message = input("문장을 입력하세요: ")

now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

with open("logs.txt", "a", encoding="utf-8") as file:
    file.write(f"{now} - {message}\n")

print("로그가 저장되었습니다.")

'''
### 문제 2. CSV 비슷한 데이터 저장

`students.txt` 파일에 학생 정보를 아래 형식으로 저장하세요.

```
이름,점수
BTS,95
BlackPink,88
NewJeans,92
```

요구사항

1. 사용자에게 이름/점수를 입력받아 파일에 저장(append)하세요.
2. 점수는 정수로 저장하세요.
3. 입력이 끝나면 파일을 읽어서 전체 학생 평균을 출력하세요.
'''

while True:
    name = input("이름을 입력하세요(엔터: 종료): ")

    if name == "":
        break

    score_input = input("점수를 입력하세요: ")

    if not score_input.isdigit():
        print("점수는 숫자만 입력하세요.")
        continue

    score = int(score_input)

    with open("students.txt", "a", encoding="utf-8") as file:
        file.write(f"{name},{score}\n")

scores = []

with open("students.txt", "r", encoding="utf-8") as file:
    for line in file:
        line = line.strip()
        if line == "":
            continue

        name, score = line.split(",")
        scores.append(int(score))

if scores:
    avg = sum(scores) / len(scores)
    print(f"전체 학생 평균: {avg:.2f}")
else:
    print("저장된 학생 데이터가 없습니다.")

'''
### 문제 3. 데이터 로딩 후 필터링

`students.txt`를 읽어서 “90점 이상 학생만” 출력하세요.

출력 예시

```
90점 이상: BTS(95), NewJeans(92)
```
'''

high_scores = []

with open("students.txt", "r", encoding="utf-8") as file:
    for line in file:
        line = line.strip()
        if line == "":
            continue

        name, score = line.split(",")
        score = int(score)

        if score >= 90:
            high_scores.append(f"{name}({score})")

if high_scores:
    print("90점 이상:", ", ".join(high_scores))
else:
    print("90점 이상 학생이 없습니다.")

'''
### 문제 4. 저장 포맷 개선: JSON으로 내보내기

`students.txt`를 읽어서 아래 형태의 `students.json` 파일을 생성하세요.

형태

```
[
  {"name":"BTS", "score":95},
  {"name":"BlackPink", "score":88}
]
```
'''

import json

students = []

with open("students.txt", "r", encoding="utf-8") as file:
    for line in file:
        line = line.strip()
        if line == "":
            continue

        name, score = line.split(",")
        students.append({
            "name": name,
            "score": int(score)
        })

with open("students.json", "w", encoding="utf-8") as file:
    json.dump(students, file, ensure_ascii=False, indent=2)

print("students.json 파일이 생성되었습니다.")