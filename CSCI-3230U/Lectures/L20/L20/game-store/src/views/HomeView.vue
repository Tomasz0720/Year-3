<script setup>
// @ is an alias for src, making this an absolute path
import GraphicCard from '@/components/GraphicCard.vue'
import { ref } from 'vue'

const graphicsCards = ref([
  {
    id: 5928101,
    img: 'n4070.jpg',
    model: 'GeForce 4070',
    cost: 3850
  },
  {
    id: 4582797,
    img: 'n4090.jpg',
    model: 'GeForce 4090',
    cost: 4500
  },
  {
    id: 8419988,
    img: 'n5090.jpg',
    model: 'GeForce 5090',
    cost: 7500
  },
  {
    id: 5928101,
    img: 'n5070ti.jpg',
    model: 'GeForce 5070ti',
    cost: 6250
  },
  {
    id: 4582797,
    img: 'n5080.jpg',
    model: 'GeForce 5080',
    cost: 6500
  },
])
</script>

<template>
  <h2>Core store</h2>
  <div class="store">
    <!-- Iterate over each event Object. Bind to ID to help Vue track each item.
     Finally, add event Prop, which receives the event Object instance currently iterated -->
    <GraphicCard v-for="card in graphicsCards" :key="card.id" :cardProp="card" />
  </div>
</template>

<style scoped>
.store {
  display: grid;
  grid-template-columns: auto auto auto;
  justify-content: space-evenly;
  text-align: center;
}
</style>
