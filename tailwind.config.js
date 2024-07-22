/** @type {import('tailwindcss').Config} */
// const defaultTheme = require('tailwindcss/defaultTheme')
import defaultTheme from 'tailwindcss/defaultTheme'

export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      fontFamily: {
        'sans': ['Montserrat', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    import('@tailwindcss/forms'),
    import('@tailwindcss/aspect-ratio')
  ],
  variants: {
    extend: {
      opacity: ['disabled'],
      border: ['disabled'], 
      italic: ['disabled', 'group-disabled'],
    }
  },
}

