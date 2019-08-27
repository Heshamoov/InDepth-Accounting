<?php

namespace App\Http\Controllers;

use App\Expense;
use App\Http\Traits\AssetTrait;
use App\Http\Traits\CashAndBankTrait;
use App\Http\Traits\EquityTrait;
use App\Http\Traits\ExpenseTrait;
use App\Http\Traits\IncomeTrait;
use App\Http\Traits\LiabilityTrait;
use App\Income;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class FinancialStatementController extends Controller
{
    use AssetTrait, LiabilityTrait, EquityTrait, CashAndBankTrait, ExpenseTrait, IncomeTrait;

    public  $fromDate;
    public $toDate;

    public function __construct()
    {
        $this->setVariable();
    }

    public function getFinancialStatement()
    {

        $fixedAssets = $this->getFixedAsset();
        $currentAssets = $this->getCurrentAsset();
        $currentAssetsArs =  $this->getCurrentAssetAr();

        $longTermLiabilites = $this->getLongTermLaibilities();
        $shortTermLiabilites = $this->getShortTermLaibilities();
        $liabilitesAps = $this->getLiabilitiesAp();
        $liabilitesApsEmloyee =$this->getLiabilitiesEmployee();

        $capital = $this->getCapital();
        $otherCapital = $this->getOtherCapital();

        $withdraw =$this->getWithdraw();

        $cash =$this->getCash();
        $bank =$this->getBank();

        $vatProvide = Expense::whereBetween('expense_date',[$this->getFormDateAndToDate()['fromDate'],$this->getFormDateAndToDate()['toDate']])->sum('tax_amount');
        $vatGet = Income::whereBetween('income_date',[$this->getFormDateAndToDate()['fromDate'],$this->getFormDateAndToDate()['toDate']])->sum('tax_amount');
        $incomeVat=$this->getIncomeVat();
        $expenseAmount=$this->getExpenseVat();

        $liabilityVat=0;
        $assetVat=0;
        (($vatGet-$vatProvide)+($incomeVat-$expenseAmount)) >= 0?
            $liabilityVat=(($vatGet-$vatProvide)+($incomeVat-$expenseAmount)):
            $assetVat=abs(($vatGet-$vatProvide)+($incomeVat-$expenseAmount));

        return response()->json([
            'fixedAssets' => $fixedAssets,
            'currentAssets' => $currentAssets,
            'currentAssetsArs' => $currentAssetsArs,
            'longTermLiabilites' => $longTermLiabilites,
            'shortTermLiabilites' => $shortTermLiabilites,
            'liabilitesAps' => $liabilitesAps,
            'liabilitesApsEmloyee' => $liabilitesApsEmloyee,
            'capital' => $capital,
            'otherCapital' => $otherCapital,
            'withdraw' => $withdraw,
            'cash' => $cash,
            'bank' => $bank,
            'assetVat' => $assetVat,
            'liabilityVat' => $liabilityVat,

        ]);

    }


    public function setVariable(){
        $this->fromDate = $this->getFromDateToDateForBalanceSheet()['fromDate'];
        $this->toDate = $this->getFromDateToDateForBalanceSheet()['toDate'];
    }
}
