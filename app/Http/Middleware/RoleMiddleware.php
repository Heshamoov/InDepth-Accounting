<?php

namespace App\Http\Middleware;

use Closure;

class RoleMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        $method=$request->method();
        $url=$request->url();

       if(auth()->user()){
           if(auth()->user()->role=='admin'){
               return $next($request);

           }else if(auth()->user()->role =='sub-admin'){

               if($method=='PATCH'|| $method=='DELETE'){
                   abort(403, 'Forbidden');

               }else{
                   if(strstr($url,'user-info')|| strstr($url,'profit-loss') || strstr($url,'cash-flow')|| strstr($url,'financial-statement')|| strstr($url,'cash-flow-previous-balance')){
                       abort(403, 'Forbidden');
                   }
                   if(strstr($url,'edit')){
                       abort(403, 'Forbidden');
                   }else{
                       return $next($request);
                   }

               }

           }else if(auth()->user()->role=='user'){
               if(strstr($url,'regular-form')||strstr($url,'dashboard')){
                   if($method=='PATCH'|| $method=='DELETE'){
                       abort(403, 'Forbidden');
                   }else{
                       return $next($request);
                   }
               }else{
                   abort(403, 'Forbidden');
               }
           }

           else{
               abort(403, 'Forbidden');
           }
       } else{
           return redirect('/login');
       }

    }
}
