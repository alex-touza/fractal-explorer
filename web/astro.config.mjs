import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';

import react from '@astrojs/react';

// https://astro.build/config
export default defineConfig({
	site: 'https://alex-touza.github.io',
	base: '/fractal-explorer',
	prefetch: true,
	output: 'static',
	integrations: [
		tailwind({
			applyBaseStyles: false,
		}),
		react(),
	],
});
