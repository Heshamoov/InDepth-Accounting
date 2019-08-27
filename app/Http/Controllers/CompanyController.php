<?php

namespace App\Http\Controllers;

use App\Company;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class CompanyController extends Controller
{



    public function edit(){
        return Company::find(1);
    }

    public function store(){
        $companyData=json_decode(request()->input('company'));

        $file=request()->file('file');
        $company=Company::whereId(1)->first();
        if($file){
            if($company->image_path){
                Storage::disk('public')->delete($company->image_path);
            }
            $storeImage=Storage::disk('public')->put('company', $file);

            $company->image_path=$storeImage;
        }


        $company->name=$companyData->name;
        $company->address=$companyData->address;
        $company->mobile=$companyData->mobile;
        $company->save();

        return response()->json([
            'type'=>'success',
            'message'=>'Company Info has been updated successfully'
        ]);

    }

}
