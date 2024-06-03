/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [
    import('@tailwindcss/forms'),
  ],
  variants: {
    extend: {
      opacity: ['disabled'],
      border: ['disabled'],
      // add any tailwind classes you wish to enable disabled: on here  
    }
  },
}

