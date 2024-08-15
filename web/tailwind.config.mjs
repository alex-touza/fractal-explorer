/** @type {Partial<CustomThemeConfig & {extend: Partial<CustomThemeConfig>}> & DefaultTheme} */
const defaultTheme = require("tailwindcss/defaultTheme")

export default {
	content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
	theme:   {

		extend: {
			fontFamily: {
				sans:  ["Roboto", ...defaultTheme.fontFamily.sans],
				serif: ["Lora", ...defaultTheme.fontFamily.serif]
			},
			screens:    {
				'2xs': '300px',
				'xs':  '475px',
				...defaultTheme.screens,
			},
			colors:     {
				primary: {
					950: '#030105',
					900: '#160E2C',
					800: '#2B2149',
					700: '#493C6C',
					600: '#65578C',
					500: '#9187B6',
					400: '#ACA5CB',
					300: '#C4C0DB',
					200: '#D5D0E4',
					100: '#DDDBEA',
					50:  '#EAE9F1',
				},

			}
		},
	},
	plugins: [],
};
