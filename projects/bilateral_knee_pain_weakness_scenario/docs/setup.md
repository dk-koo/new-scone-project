# Setup

## 1) SCONE/Hyfydy 준비

- SCONE 설치 및 Hyfydy 지원 버전 확인
- SCONE에서 `.scone` 실행 가능한 상태 확인

참고 패턴:
- `ModelHyfydy { model_file = ...; state_init_file = ...; << HfdConfig...zml >> }`
- `SequentialController { << RF1...scone >> << RF2...scone >> << Gait...scone >> }`
- `CompositeMeasure { ... }`

## 2) 모델 파일 배치

`models/`에 아래 리소스를 준비하세요(직접 복사 또는 심볼릭 링크/경로 관리).

- `H1120_STW_normalseat_10MPa.hfd` 또는 연구용 기본 HFD 모델
- `HfdConfigPlanarMotorCollisionV2.zml` (Hyfydy config)
- `BasedOnLessDeg_P1242_C101_InitState_adj4_SH_044_Jan22.zml` (초기자세)
- `P1242_C101.sto` (MimicMeasure 참조 파일)
- `RF1_*.scone`, `RF2_*.scone`, `Gait_*.scone` (controller 블록)

> TODO: 실제 파일명은 연구 환경에 맞게 확정 후 `parameters/conditions.csv` 및 템플릿 변수와 일치시켜야 합니다.

## 3) 시나리오 생성

```bash
python3 scripts/generate_scenarios.py
```

생성 결과:
- `generated/*.scone`

## 4) 배치 실행

Linux/macOS:
```bash
bash batch/run_all.sh
```

Windows:
```bat
batch\\run_all.bat
```

> TODO: `SCONE_CMD` 환경변수 또는 설치 경로 기반의 실제 실행 명령을 확정하세요.
