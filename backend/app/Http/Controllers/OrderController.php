<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Order;

class OrderController extends Controller
{
    public function index()
    {
        $orders = Order::all();
        return response()->json($orders);
    }

    public function getOrderPerUser($id){
        $orders = Order::with('product')->where('user_id', $id)->get();
        return response()->json($orders);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $products = $request->products;
        try{

            foreach ($products as $product) {
                
                $order = new Order();
                $order->product_id = $product['product_id'];
                $order->user_id = $request->user_id;
                $order->quantity = $product['quantity'];
                $order->order_status = 1;
                $order->save();
            }
            return response()->json([
                'message' => 'Order created successfully!',
                
            ], 201);
        }catch (\Exception $exception) {
            return response()->json([
                "Error" => "Order creation failed: ",
                $exception
            ], 500);
        }    

    }
}
