<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('products')->insert([
            [
                'name' => 'JBL Tune720',
                'price' => 555.00,
                'description' => 'Fone de ouvido.'
            ],
            [
                'name' => 'Logitech MX Master 3',
                'price' => 420.50,
                'description' => 'Mouse wireless ergonômico.'
            ],
            [
                'name' => 'Apple AirPods Pro',
                'price' => 1300.00,
                'description' => 'Fones de ouvido sem fio com cancelamento de ruído.'
            ],
        ]);
    }
}
