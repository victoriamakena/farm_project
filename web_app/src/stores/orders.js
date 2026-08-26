import { ref, computed } from 'vue'
import { defineStore } from 'pinia'

export const useOrdersStore = defineStore('order',  {
   state: () => {
        const orders= {
            0:{
                id: 1,
                customer_id: 2,
                product_id: 4,
                quantity: 2,
                total_paid: 1600,
                status: "processing"
            },
            1:{
                id: 2,
                customer_id: 1,
                product_id: 10,
                quantity: 1,
                total_paid: 1650,
                status: "fulfilled"
            },
            2:{
                id: 3,
                customer_id: 4,
                product_id: 9,
                quantity: 1,
                total_paid: 2550,
                status: "processing"
            },
            3:{
                id: 4,
                customer_id: 3,
                product_id: 5,
                quantity: 2,
                total_paid: 4000,
                status: "fulfilled"
            },
            4:{
                id: 5,
                customer_id: 5,
                product_id: 9,
                quantity: 2,
                total_paid: 3600,
                status: "processing"
            },
            5:{
                id: 6,
                customer_id: 6,
                product_id: 7,
                quantity: 10,
                total_paid: 7500,
                status: "fulfilled"
            }
        }

        return{
            orders
        }
   },
   actions:{
       checkout(payload) {
            //get the last key in the object
            const existingKeys = Object.keys(this.orders).map(Number);
            const maxKey = existingKeys.length > 0 ? Math.max(...existingKeys) : 0;
            const nextKey = maxKey + 1;
            
            // Loop through each item in the cart object
            Object.values(payload).forEach((cartItem) => {
                
                const calculatedTotalPaid = Number(cartItem.price) * Number(cartItem.quantity)

                const newOrder = {
                id: nextKey,
                customer_id: 4, //to do: get id from user data
                product_id: cartItem.id,       
                quantity: cartItem.quantity,
                total_paid: calculatedTotalPaid, 
                status: "processing"           
                }

                this.orders[nextKey] = {
                ...newOrder,
                id: nextKey
            };
            })
            
        },
       completeOrder(id) {
            // find the order in the object
            const order = Object.entries(this.orders).find(
                ([key, item]) => item.id === id //compare the ids
            );

            if (!order) {
                console.error(`No order found with id: ${id}`);
                return;
            }

            const [objectKey] = order;

            //replace the existing order data with what was received in payload
            this.orders[objectKey] = {
                ...this.orders[objectKey], 
                status: 'fulfilled'
            };
        },
   },
   persist: true,
})