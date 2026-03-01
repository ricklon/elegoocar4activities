#!/usr/bin/env node
import { spawn } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const projectRoot = dirname(__dirname);

const children = [];
let shuttingDown = false;

function start(name, cmd, args, cwd = projectRoot) {
  const child = spawn(cmd, args, {
    cwd,
    stdio: 'inherit',
    env: process.env,
  });

  children.push({ name, child });

  child.on('exit', (code, signal) => {
    if (shuttingDown) return;
    const reason = signal ? `signal ${signal}` : `code ${code}`;
    console.error(`[launcher] ${name} exited (${reason})`);
    shutdown(code ?? 1);
  });
}

function shutdown(exitCode = 0) {
  if (shuttingDown) return;
  shuttingDown = true;

  for (const { child } of children) {
    if (!child.killed) child.kill('SIGTERM');
  }

  setTimeout(() => process.exit(exitCode), 100);
}

process.on('SIGINT', () => shutdown(0));
process.on('SIGTERM', () => shutdown(0));

const viteBin = join(projectRoot, 'node_modules', 'vite', 'bin', 'vite.js');

console.log('[launcher] starting bridge + vite dev server');
start('bridge', process.execPath, [join(__dirname, 'bridge.mjs')]);
start('vite', process.execPath, [viteBin, '--host']);
