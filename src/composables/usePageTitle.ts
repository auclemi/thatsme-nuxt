import { useHead } from "nuxt/app";

export function usePageTitle(title: string) {
  useHead({
    title: `${title} - That's Me !`
  })
  return title
}
