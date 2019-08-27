<?php

namespace App\Http\Controllers;

use App\Expense;
use App\Http\Traits\ExpenseTrait;
use App\Http\Traits\IncomeTrait;
use App\Income;
use Illuminate\Support\Facades\DB;

class ProfitLossController extends Controller
{
    use IncomeTrait; use ExpenseTrait;
    public function getProfitLoss(){

        $incomes= $this->getIncome();
        $expenses= $this->getExpense();

        $vatProvide = Expense::whereBetween('expense_date',[$this->getFormDateAndToDate()['fromDate'],
                      $this->getFormDateAndToDate()['toDate']])->sum('tax_amount');

        $vatGet = Income::whereBetween('income_date',[$this->getFormDateAndToDate()['fromDate'],                            $this->getFormDateAndToDate()['toDate']])->sum('tax_amount');

        $incomeVat=$this->getIncomeVat();
        $expenseAmount=$this->getExpenseVat();


        return response()->json([
            'incomes'=>$incomes,
            'expenses'=>$expenses,
            'tax'=>($vatGet-$vatProvide)+($incomeVat-$expenseAmount)

        ]);
    }
}
