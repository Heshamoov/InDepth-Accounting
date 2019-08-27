<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Income extends Model
{
    protected $guarded=['id','payable_details','account_receivable'];


    public function account(){
        return $this->belongsTo(Account::class);
    }

    public function accountReceivable(){
        return $this->belongsTo(Account::class,'asset_id','id');
    }

}
