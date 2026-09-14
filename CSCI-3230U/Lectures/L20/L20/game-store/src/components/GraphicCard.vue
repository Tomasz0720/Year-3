<script setup>
defineProps({
  cardProp: {
    type: Object,
    required: true,
  },
})
</script>

<template>
  <div class="graphic-card">
    <h2>{{ cardProp.model }}</h2>
    <img :src="cardProp.img" :alt="cardProp.model">
    <span>${{ cardProp.cost }}</span>
  </div>
</template>

<style scoped>
img {
  width: 100px;
  height: 100px;
}
span {
  font-weight: bold;
  font-size: 30px;
}
h2 {
  font-size: 20px;
  color: #840424;
}
.graphic-card {
  padding: 20px;
  width: 250px;
  cursor: pointer;
  border: 1px solid #39495c;
  margin-bottom: 18px;
}
.graphic-card:hover {
  transform: scale(1.01);
  box-shadow: 0 3px 12px 0 rgba(0, 0, 0, 0.2);
}
</style>
