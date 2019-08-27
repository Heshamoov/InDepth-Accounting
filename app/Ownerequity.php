<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Ownerequity extends Model
{
    protected $guarded=['id','liability','account_payable'];


    public function accountPayable(){
        return $this->belongsTo(Account::class,'liability_id','id');
    }
}
