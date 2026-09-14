const app = Vue.createApp({
    data() {
        return {
            cards: [
                { model: 'Geforce RTX 4070 Ti', price: '$799', cores: 7680, img: 'assets/1.jpg', isSale: true },
                { model: 'Geforce RTX 3070', price: '$499', cores: 5888, img: 'assets/2.jpg', isSale: false },
                { model: 'Geforce RTX 4090', price: '$1599', cores: 16384, img: 'assets/3.jpg', isSale: true }
            ],
            showCard: true,
            url_nvidia: 'https://www.nvidia.com/en-us/geforce/graphics-cards/',
            url_amd: 'https://www.amd.com/en/graphics/radeon-rx-graphics'
        }
    },
    methods: {
        toggleCard() {
            // Flip the boolean value
            this.showCard = !this.showCard;
        },
        toggleSale(card) {
            card.isSale = !card.isSale
        }
    },
    computed: {
        // Returns a new array which contains only elements with isSale property = true
        onsaleCards() {
            return this.cards.filter(card => card.isSale)
        }
    }
}).mount('#app')
