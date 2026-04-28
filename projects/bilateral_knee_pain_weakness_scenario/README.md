# bilateral_knee_pain_weakness_scenario

SCONE/Hyfydy에서 **양측 무릎 통증 회피(pain-avoidance)** 및 **근력 약화(weakness)** 조건을 실행하기 위한 시나리오 작업 프로젝트입니다.

본 프로젝트는 다음 reference 구조를 기반으로 구성되었습니다.
- `reference_projects/Sit-to-walk-predictive-simulations-main`
- `reference_projects/STW-case-study-unilateral-pain-main`
- `reference_projects/ModelDataPerturbedBalanceControl-main`
- `reference_projects/scone-core-main`

## 폴더 구조

- `scenarios/`: 수동 작성한 최종 실행용 `.scone` 시나리오
- `templates/`: 조건별 시나리오 생성용 템플릿
- `models/`: `.hfd`, `.osim`, `.zml` 등 모델 관련 파일 또는 위치 안내
- `parameters/`: 조건 정의 CSV(weakness, pain-avoidance 등)
- `scripts/`: 템플릿 기반 scenario 생성 스크립트
- `batch/`: 다중 조건 실행 스크립트 (`.sh`, `.bat`)
- `docs/`: 설치/실행/설계 문서
- `generated/`: 자동 생성된 조건별 `.scone`
- `logs/`: 실행 로그 저장 위치

## 빠른 시작

1. `parameters/conditions.csv`에서 조건 정의
2. `scripts/generate_scenarios.py`로 `generated/*.scone` 생성
3. `batch/run_all.sh` 또는 `batch/run_all.bat`로 조건 일괄 실행

```bash
python3 scripts/generate_scenarios.py
```

> TODO: 실제 SCONE CLI 명령(`sconecmd` 또는 동등 실행기) 경로/옵션은 설치 환경별로 확인 후 `batch/run_all.*`에서 확정하세요.

## 주의사항

- `reference_projects/` 내부 파일은 수정하지 않습니다.
- 본 프로젝트는 **시나리오 실행 구성**에 집중하며, 결과 통계/가설검정 코드는 포함하지 않습니다.
