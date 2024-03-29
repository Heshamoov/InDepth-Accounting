<?php
/**
 * Created by PhpStorm.
 * User: Raz
 * Date: 10/8/2018
 * Time: 8:06 PM
 */

namespace App\Http\Traits;


use Illuminate\Support\Facades\DB;

trait LiabilityTrait
{
    public function getLongTermLaibilities(){
        $data= DB::table('accounts')
            ->leftJoin('liabilities', 'liabilities.accountable_id', '=', 'accounts.id')
            ->select('accounts.name', 'accounts.id', 'liabilities.transaction_type', DB::raw("SUM(CASE  WHEN liabilities.transaction_type ='Payment' THEN -liabilities.amount ELSE liabilities.amount END) as amount"))
            ->where('liabilities.accountable_type', "App\Account")
            ->where('accounts.account_type', 'Long-term Liabilities')
            ->groupBy('liabilities.accountable_id');

        $data=$this->dateSearch('liability_date',$data,request());
        return $data->get();
    }




    public function getShortTermLaibilities(){
        $data=DB::table('accounts')
            ->leftJoin('liabilities', 'liabilities.accountable_id', '=', 'accounts.id')
            ->select('accounts.name', 'accounts.id', 'liabilities.transaction_type', DB::raw("SUM(CASE  WHEN liabilities.transaction_type ='Payment' THEN -liabilities.amount ELSE liabilities.amount END) as amount"))
            ->where('accounts.account_type', 'Short-term Liabilities')
            ->where('liabilities.accountable_type', "App\Account")
            ->groupBy('accounts.id');
        $data=$this->dateSearch('liability_date',$data,request());
        return $data->get();
    }




    public function getLiabilitiesAp(){

        $data=DB::table('accounts')
            ->leftJoin('liabilities', 'accounts.id', '=', 'liabilities.accountable_id')
            ->select('accounts.id as aid', 'accounts.name',

                DB::raw("(SELECT SUM(CASE  WHEN liabilities.transaction_type ='Payment' THEN -liabilities.amount ELSE liabilities.amount END) from liabilities where accountable_type='App\\\Account' and accountable_id = aid and liability_date between '$this->fromDate' and '$this->toDate') as liabilitiesAmount"),

                DB::raw("(SELECT sum(amount) FROM  expenses WHERE payment_type = 'Accounts Payable' and modelable_id=aid and modelable_type='App\\\Account' and expense_date between '$this->fromDate' and '$this->toDate') as expenseAmount"),
                DB::raw("(SELECT sum(amount) FROM  assets WHERE payment_type = 'Accounts Payable' and liability_id=aid and asset_date between '$this->fromDate' and '$this->toDate') as assetAmount"),

                DB::raw("(SELECT sum(amount) FROM  ownerequities WHERE liability_id = aid and equity_date between '$this->fromDate' and '$this->toDate')as equityAmount")
            )
            ->where('accounts.account_type', '=', 'Liabilities-AP')
            ->groupBy('accounts.id')
            ->get();
        return $data;
    }







    public function getLiabilitiesEmployee(){

        $data=DB::table('employees')
            ->leftJoin('liabilities', 'employees.id', '=', 'liabilities.accountable_id')
            ->select('employees.id as aid', 'employees.name',

                DB::raw("(SELECT SUM(CASE  WHEN liabilities.transaction_type ='Payment' THEN -liabilities.amount ELSE liabilities.amount END) from liabilities where accountable_type='App\\\Employee' and accountable_id = aid and liability_date between '$this->fromDate' and '$this->toDate') as liabilitiesAmount"),

                DB::raw("(SELECT sum(amount) FROM  expenses WHERE payment_type = 'Accounts Payable' and modelable_id=aid and modelable_type='App\\\Employee' and expense_date between '$this->fromDate' and '$this->toDate') as expenseAmount")

            )
            ->groupBy('employees.id')
            ->get();
        return $data;
    }
}