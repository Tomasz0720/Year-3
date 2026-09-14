<script setup>
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  <div id="layout">
    <header>
      <div class="wrapper">
        <nav>
          <RouterLink to="/">Home</RouterLink> |
          <RouterLink to="/about">About</RouterLink>
        </nav>
      </div>
    </header>
  </div>
  <RouterView />
</template>

<style>
#layout {
  font-family: 'Roboto', sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #444444;
}
nav {
  padding: 20px;
  background-color: #f8f9fa;
}
nav a {
  font-weight: bold;
  color: #444444;
  text-decoration: none;
  margin: 0 10px;
}
nav a.router-link-exact-active {
  color: #007bff;
}
h2 {
  font-size: 48px;
  color: #444444;
  margin-bottom: 20px;
}
</style>
