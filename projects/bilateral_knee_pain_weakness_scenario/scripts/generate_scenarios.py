#!/usr/bin/env python3
"""Generate SCONE scenario files from CSV conditions and a base template.

This script intentionally keeps SCONE syntax in template files and only performs
string substitution to avoid inventing undocumented syntax.
"""

from __future__ import annotations

import csv
from pathlib import Path
from string import Template

ROOT = Path(__file__).resolve().parents[1]
TEMPLATE_PATH = ROOT / "templates" / "base_scenario_template.scone"
CONDITIONS_CSV = ROOT / "parameters" / "conditions.csv"
GENERATED_DIR = ROOT / "generated"


def load_template() -> Template:
    return Template(TEMPLATE_PATH.read_text(encoding="utf-8"))


def load_conditions() -> list[dict[str, str]]:
    with CONDITIONS_CSV.open("r", encoding="utf-8", newline="") as fp:
        reader = csv.DictReader(fp)
        rows = [row for row in reader]
    if not rows:
        raise ValueError(f"No conditions found in {CONDITIONS_CSV}")
    return rows


def render_and_write(template: Template, row: dict[str, str]) -> Path:
    condition_id = row["condition_id"].strip()
    if not condition_id:
        raise ValueError("Found empty condition_id")

    text = template.substitute(row)
    out_path = GENERATED_DIR / f"{condition_id}.scone"
    out_path.write_text(text, encoding="utf-8")
    return out_path


def main() -> int:
    GENERATED_DIR.mkdir(parents=True, exist_ok=True)

    template = load_template()
    conditions = load_conditions()

    written: list[Path] = []
    for row in conditions:
        out = render_and_write(template, row)
        written.append(out)

    print(f"Generated {len(written)} scenario files:")
    for p in written:
        print(f" - {p.relative_to(ROOT)}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
