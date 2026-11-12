from pathlib import Path
import re,hashlib
r=Path(__file__).resolve().parent
t=''.join(p.read_text(encoding='utf-8') for p in sorted((r/'src/template').glob('*.txt')))
def substitute(m): return (r/'src/modules'/m.group(1)).read_text(encoding='utf-8')
s=re.sub(r'--\[\[YINMODULE:([^\]]+)\]\]',substitute,t)
size=44000
p=r/'dist/partes';p.mkdir(parents=True,exist_ok=True)
for f in p.glob('*.txt'): f.unlink()
for i in range(0,len(s),size):(p/(f'{i//size+1:03}.txt')).write_text(s[i:i+size],encoding='utf-8')
print('Fragmentos:',(len(s)+size-1)//size,'SHA256:',hashlib.sha256(s.encode()).hexdigest())
