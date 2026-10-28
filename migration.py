#!/usr/bin/env python3
from __future__ import annotations

import re
import sys
import time
import unicodedata
from datetime import datetime
from pathlib import Path

MIGRATION_DIR = Path('src/main/resources/db/migration')


def normalize_name(value: str) -> str:
    # Vietnamese đ/Đ is not removed by NFKD.
    value = value.replace('đ', 'd').replace('Đ', 'D')
    value = unicodedata.normalize('NFKD', value)
    value = ''.join(c for c in value if not unicodedata.combining(c))
    value = value.lower().strip()
    value = re.sub(r'[^a-z0-9]+', '_', value)
    return value.strip('_')


def version_now() -> str:
    # Local machine time, millisecond precision: yyyyMMddHHmmssSSS
    now = datetime.now()
    return now.strftime('%Y%m%d%H%M%S') + f'{now.microsecond // 1000:03d}'


def main() -> int:
    if len(sys.argv) < 2:
        print('Usage: python migration.py <ten migration>')
        print('Example: python migration.py "tao bang nguoi dung"')
        return 2

    description = normalize_name(' '.join(sys.argv[1:]))
    if not description:
        print('Error: migration name is empty after normalization.', file=sys.stderr)
        return 2

    MIGRATION_DIR.mkdir(parents=True, exist_ok=True)

    # In the rare case two processes hit the same millisecond, wait for the next one.
    while True:
        version = version_now()
        path = MIGRATION_DIR / f'V{version}__{description}.sql'
        try:
            path.touch(exist_ok=False)
            break
        except FileExistsError:
            time.sleep(0.002)

    print(path.as_posix())
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
