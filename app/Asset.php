<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Asset extends Model
{
   protected $guarded=['id','liability','account_payable','expense'];

    public function account(){
       return $this->belongsTo(Account::class);
   }

    public function accountPayable(){
        return $this->belongsTo(Account::class,'liability_id','id');
    }
}
