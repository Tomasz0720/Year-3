<script setup>
import { ref } from 'vue'

// Create a reactive variable for the title.
const title = ref("Welcome to today's class")

// Create a ref for the text field element.
const myTextfield = ref(null)

// Define a function to handle the click event.
function handleClick() {
  console.log(myTextfield.value)
  myTextfield.value.classList.add('activeField')
  myTextfield.value.focus()
}
</script>

<template>
  <!--
  <img alt="Vue logo" class="logo" src="./assets/logo.svg" width="125" height="125" />
  <div class="wrapper">
    <HelloWorld msg="You did it!" />
  </div>
  -->
  <h1>{{ title }}</h1>
  <input type="text" ref="myTextfield" />
  <button @click="handleClick">Focus on textfield</button>
</template>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

h1 {
  color: brown;
}

/* Optional styling for the active text field */
.activeField {
  border: 2px solid green;
}
</style>