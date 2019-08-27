<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Account extends Model
{
    protected $guarded=['id'];

    public function expenses(){
        return $this->morphMany(Expense::class, 'modelable');
    }

    public function liabilities(){
        return $this->morphMany(Liability::class, 'accountable');
    }
}
