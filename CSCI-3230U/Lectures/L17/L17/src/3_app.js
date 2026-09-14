const app = Vue.createApp({
    // Shorthand syntax for data: function() {}
    data() {
      return {
        // The properties of this returned object are then accessible from our template (within e.g., index.html)
        model: '4070 Ti',
        price: '$1600',
        cores: 7680
      }
    }
  }).mount('#app')