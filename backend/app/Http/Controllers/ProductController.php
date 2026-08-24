<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Product;

class ProductController extends Controller
{
    public function index()
    {
        $products = Product::with('category')->get();

        foreach($products as $product){
              $product->image = asset('/api/image' . $product->image);
        }
        return response()->json($products);
    }
}
