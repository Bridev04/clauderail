#!/usr/bin/env node
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const pkgRoot = path.join(__dirname, '..');
const cwd = process.cwd();

function copyRecursive(src, dest) {
  if (!fs.existsSync(src)) return false;
  const stat = fs.statSync(src);
  if (stat.isDirectory()) {
    fs.mkdirSync(dest, { recursive: true });
    for (const item of fs.readdirSync(src)) {
      copyRecursive(path.join(src, item), path.join(dest, item));
    }
  } else {
    fs.mkdirSync(path.dirname(dest), { recursive: true });
    fs.copyFileSync(src, dest);
  }
  return true;
}

const items = ['.claude', 'CLAUDE.md', '.mcp.json', '.github'];

console.log('Installing clauderail into', cwd, '\n');
for (const item of items) {
  const ok = copyRecursive(path.join(pkgRoot, item), path.join(cwd, item));
  if (ok) console.log(' copied', item);
}

try {
  execSync('chmod +x .claude/hooks/*.sh', { cwd, stdio: 'ignore' });
} catch {}

console.log('\nDone. Open Claude Code and run /onboard to get started.');
