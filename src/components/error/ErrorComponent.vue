<script setup>
const props = defineProps({
  errorMessage: { type: String, required: true },
  instruction: { type: String, required: false }
})
</script>

<template>
  <div class="alert alert-danger" role="alert">
    <p class="mb-1">{{ props.errorMessage }}</p>
    <p v-if="props.instruction" class="mb-0">{{ props.instruction }}</p>
  </div>
</template>
