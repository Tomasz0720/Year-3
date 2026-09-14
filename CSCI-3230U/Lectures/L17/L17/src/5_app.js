const app = Vue.createApp({
    // Shorthand syntax for data: function() {}
    data() {
      return {
        // The properties of this returned object are then accessible from our template (within e.g., index.html)
        model: '4070 Ti',
        price: '$1600',
        cores: 7680,
        // Should we show the graphics card?
        showCard: true
      }
    },
    methods: {
        changeModel(model, price, cores) {
          this.model = model
          this.price = price
          this.cores = cores
        },
        toggleCard() {
            // Flip the boolean value
            this.showCard = !this.showCard;
        }
      }
  }).mount('#app')