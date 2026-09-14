const app = Vue.createApp({
    // Shorthand syntax for data: function() {}
    data() {
        return {
            // Array of card objects
            // Recall - Previously we had only simple data structure, now we're using an array as part of
            // our returned data() object.
            cards: [
                { model: 'Geforce RTX 4070 Ti', price: '$799', cores: 7680, img: 'assets/1.jpg', isSale: true },
                { model: 'Geforce RTX 3070', price: '$499', cores: 5888, img: 'assets/2.jpg', isSale: false },
                { model: 'Geforce RTX 4090', price: '$1599', cores: 16384, img: 'assets/3.jpg', isSale: true }
            ],
            // Should we show the graphics card?
            showCard: true,
            // Store URLs
            url_nvidia: 'https://www.nvidia.com/en-us/geforce/graphics-cards/',
            url_amd: 'https://www.amd.com/en/graphics/radeon-rx-graphics'
        }
    },
    methods: {
        // changeModel(model, price, cores) {
        //     this.model = model
        //     this.price = price
        //     this.cores = cores
        // },
        toggleCard() {
            // Flip the boolean value
            this.showCard = !this.showCard;
        },
        toggleSale(card) {
            card.isSale = !card.isSale
        }
    }
}).mount('#app')