const app = Vue.createApp({
    // Shorthand syntax for data: function() {}
    data() {
      return {
        // The properties of this returned object are then accessible from our template (within e.g., index.html)
        model: '4070 Ti',
        price: '$1600',
        cores: 7680,
        // Should we show the graphics card?
        showCard: true,
        // x-coord in div square
        x: 0,
        y: 0
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
        },
        // The event object
        handleEvent(e, num) {
            console.log(e, e.type)
            if (num) {
                console.log(num)
            }
        },
        handleMousemove(e) {
            this.x = e.offsetX
            this.y = e.offsetY
            // console.log(this.x, "-", this.y)
        }
      }
  }).mount('#app')