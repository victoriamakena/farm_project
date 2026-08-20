<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->unsignedBigInteger('category_id');
            $table->foreign('category_id') -> references('id') -> on('categories');
            $table->integer('price');
            $table->string('image');
            $table->integer('availability');
            $table->string('description');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Schema::dropIfExists('books');
         Schema::table('books', function (Blueprint $table) {
            $table->dropForeign('genre_genre_id_foreign');

            $table->dropColumn('genre_id');
            
        });
    }
};
