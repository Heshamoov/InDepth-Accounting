<?php

use Illuminate\Database\Seeder;
use Faker\Factory as Faker;

class UserTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {

            DB::table('users')->insert([
                'name'=>'Harison',
                'role'=>'admin',
                'email'=>'amsl@admin.com',
                'password'=>'$2y$12$di13EgZz1onP8jNsvUhw0.MtUD9AmQ14VQvCkcbt27e1EWSOBA6kC',
            ]);
            DB::table('users')->insert([
                'name'=>'Jon',
                'role'=>'sub-admin',
                'email'=>'amsl@sub-admin.com',
                'password'=>'$2y$12$di13EgZz1onP8jNsvUhw0.MtUD9AmQ14VQvCkcbt27e1EWSOBA6kC',
            ]);

        DB::table('users')->insert([
            'name'=>'Parikon',
            'role'=>'user',
            'email'=>'amsl@user.com',
            'password'=>'$2y$12$di13EgZz1onP8jNsvUhw0.MtUD9AmQ14VQvCkcbt27e1EWSOBA6kC',
        ]);

    }
}
