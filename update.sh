#!/bin/bash
# Вписывает текущий адрес приложения в страницу-переходник и выкладывает её.
set -e
cd /home/superlisa/workspace/app-tts
URL=$(/home/superlisa/workspace/vk-tts/tunnel_addr.sh)
python3 - "$URL" <<'PY'
import sys, re
url = sys.argv[1]
s = open('index.html', encoding='utf-8').read()
s = re.sub(r'const CURRENT = ".*?";', 'const CURRENT = "%s";' % url, s, count=1)
open('index.html', 'w', encoding='utf-8').write(s)
PY
git add -A
git commit -q -m "адрес приложения: $URL" || echo "нечего менять"
git push -q origin main 2>&1 | tail -2
echo "выложено: $URL"
