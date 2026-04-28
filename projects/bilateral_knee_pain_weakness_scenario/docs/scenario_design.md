# Scenario Design

## 설계 원칙

본 프로젝트의 `.scone` 설계는 다음 reference 패턴을 유지합니다.

1. 최상위 Optimizer 블록 (`CmaOptimizer`)
2. `SimulationObjective` 하위에
   - `ModelHyfydy`
   - `SequentialController` 또는 `CompositeController`
   - `CompositeMeasure`
3. include 문법 `<< path/to/file >>` 사용
4. 조건 변경은 주로 아래 항목만 바꿈
   - `init{file = ...}` (`.par`)
   - `ModelHyfydy.model_file` (`.hfd`)
   - signature/postfix

## 조건 변수

- `condition_id`: 시나리오 구분 키
- `init_file`: 조건별 초기 파라미터 (`.par`)
- `model_file`: 조건별 모델 파일 (`.hfd`)
- `pain_load_max`: 통증회피/하중 제한 관련 measure max 값
- `weakness_tag`: 약화 조건 식별자(문서/파일명 구분 용도)

## 템플릿 기반 생성

`templates/base_scenario_template.scone`에는 `${...}` 플레이스홀더를 두고,
`scripts/generate_scenarios.py`가 `parameters/conditions.csv`를 읽어
`generated/{condition_id}.scone`를 생성합니다.

## 실행/확장

- 우선 generated 시나리오를 직접 SCONE에서 실행
- 추후 필요 시 `scenarios/`에 검증 완료본만 수동 승격
- objective/measure 세부 튜닝은 생성 템플릿에서 중앙관리

## TODO

- 통증회피를 직접적으로 반영할 measure 정의(예: knee 관련 `ReactionForceMeasure` 또는 `DofMeasure.force`)의 최종 문법/대상 DOF 확정
- 모델 내부에서 weakness를 반영할지(모델 파라미터), controller gain/activation 한계로 반영할지 확정
