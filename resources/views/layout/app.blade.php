<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>Accounting management system london</title>
    <!-- Fonts -->
    {{--<link rel="dns-prefetch" href="https://fonts.gstatic.com">--}}
    <link href="https://fonts.googleapis.com/css?family=Raleway:300,400,600" rel="stylesheet" type="text/css">
    <link href="{{ asset('css/app.css') }}" rel="stylesheet" type="text/css">
    <link href="{{ asset('css/font-awesome.css') }}" rel="stylesheet" type="text/css">
    <link rel="icon" href="{{asset('images/favi.png')}}">
</head>
<body class="app sidebar-mini rtl pace-done">
<div id="app">
    {{--@include('layouts.partial.nav')--}}
        @yield('content')
</div>
<script src="{{ asset('js/app.js') }}" rel="script" type="text/javascript"></script>
</body>
</html>
