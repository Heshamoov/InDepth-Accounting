<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class EmployeeHistory extends Model
{
    protected $guarded=['id','employee'];

    public function employee(){
        return $this->belongsTo(Employee::class);
    }
}
