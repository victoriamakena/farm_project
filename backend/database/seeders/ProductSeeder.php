<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use Illuminate\Database\Seeder;

use App\Models\Product;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Product::create([
            'name'=>'Tomato',
            'price'=>200,
            'category_id'=>1,
            'image'=>'products/tomato.jpg',
            'availability'=>1,
            'description'=>'Juicy and fresh',
        ]);
        Product::create([
            'name'=>'Onion',
            'price'=>200,
            'category_id'=>2,
            'image'=>'products/onion.jpg',
            'availability'=>1,
            'description'=>'Juicy and fresh',
        ]);
        Product::create([
            'name'=>'Orange',
            'price'=>200,
            'category_id'=>1,
            'image'=>'products/orange.jpg',
            'availability'=>1,
            'description'=>'Juicy and fresh',
        ]);
    }
}
