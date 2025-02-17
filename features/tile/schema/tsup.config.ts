import { defineConfig } from 'tsup';

export default defineConfig({
  entry: ['src/index.ts'],
  dts: true,
  splitting: false,
  sourcemap: false,
  clean: true,
  minify: true,
  platform: 'browser',
  format: ['esm'],
});
