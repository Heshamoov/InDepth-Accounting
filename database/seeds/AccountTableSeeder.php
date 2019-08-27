<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AccountTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('accounts')->insert([
            'name'=>'Investment',
            'account_type'=>'Current Asset',
        ]);
        DB::table('accounts')->insert([
            'name'=>'Prepaid Wages',
            'account_type'=>'Current Asset',
        ]);
        DB::table('accounts')->insert([
            'name'=>'Wages',
            'account_type'=>'Expense',
        ]);
        DB::table('accounts')->insert([
            'name'=>'Electricity Bill',
            'account_type'=>'Expense',
        ]);
        DB::table('accounts')->insert([
            'name'=>'Depreciation',
            'account_type'=>'Expense',
        ]);
        DB::table('accounts')->insert([
            'name'=>'Room Rent',
            'account_type'=>'Income',
        ]);
        DB::table('accounts')->insert([
            'name'=>'Car Parking',
            'account_type'=>'Income',
        ]);
        DB::table('accounts')->insert([
            'name'=>'Furniture',
            'account_type'=>'Fixed Asset',
        ]);
        DB::table('accounts')->insert([
            'name'=>'Table',
            'account_type'=>'Fixed Asset',
        ]);
        DB::table('accounts')->insert([
            'name'=>'AR-Jhon',
            'account_type'=>'Current Asset-AR',
        ]);
        DB::table('accounts')->insert([
            'name'=>'AR-Karim',
            'account_type'=>'Current Asset-AR',
        ]);
        DB::table('accounts')->insert([
            'name'=>'AP-Hanif',
            'account_type'=>'Liabilities-AP',
        ]);
        DB::table('accounts')->insert([
            'name'=>'AP-Shohag',
            'account_type'=>'Liabilities-AP',
        ]);
        DB::table('accounts')->insert([
            'name'=>'Bank Loan',
            'account_type'=>'Long-term Liabilities',
        ]);
        DB::table('accounts')->insert([
            'name'=>'Car Loan',
            'account_type'=>'Long-term Liabilities',
        ]);
        DB::table('accounts')->insert([
            'name'=>'Short Term Loan',
            'account_type'=>'Short-term Liabilities',
        ]);
        DB::table('accounts')->insert([
            'name'=>'Short Term Car Loan',
            'account_type'=>'Short-term Liabilities',
        ]);
        DB::table('employees')->insert([
            'name'=>'EM-Rohan',
            'id_card'=>'EM-001',
        ]);
        DB::table('employees')->insert([
            'name'=>'EM-Soha',
            'id_card'=>'EM-002',
        ]);
    }
}
