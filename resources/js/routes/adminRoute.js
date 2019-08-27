module.exports = [
    {
        path: '/dashboard',
        name: 'dashboard',
        component: require('../admin/views/dashboard')
    },

    //Employee History
    {
        path: '/employee/history/create',
        name: 'employeeHistoryCreate',
        component: require('../admin/views/employee/history/historyCreate.vue')
    },
    {
        path: '/employee/history',
        name: 'employeeHistoryList',
        component: require('../admin/views/employee/history/historyList.vue')
    },
    {
        path: '/employee/history/:id/edit',
        name: 'employeeHistoryEdit',
        component: require('../admin/views/employee/history/historyEdit.vue')
    },
    //Employee
    {
        path: '/employee/create',
        name: 'employeeCreate',
        component: require('../admin/views/employee/employeeCreate.vue')
    },
    {
        path: '/employee',
        name: 'employeeList',
        component: require('../admin/views/employee/employeeList.vue')
    },
    {
        path: '/employee/:id/edit',
        name: 'employeeEdit',
        component: require('../admin/views/employee/employeeEdit.vue')
    },
    //Account

    {
        path: '/account/create',
        name: 'accountCreate',
        component: require('../admin/views/account/accountCreate.vue')
    },
    {
        path: '/account',
        name: 'accountList',
        component: require('../admin/views/account/accountList.vue')
    },
    {
        path: '/account/:id/edit',
        name: 'accountEdit',
        component: require('../admin/views/account/accountEdit.vue')
    },

    //Expense

    {
        path: '/expense/create',
        name: 'expenseCreate',
        component: require('../admin/views/expense/expenseCreate.vue')
    },
    {
        path: '/expense',
        name: 'expenseList',
        component: require('../admin/views/expense/expenseList.vue')
    },
    {
        path: '/expense/:id/edit',
        name: 'expenseEdit',
        component: require('../admin/views/expense/expenseEdit.vue')
    },

    //Income

    {
        path: '/income/create',
        name: 'incomeCreate',
        component: require('../admin/views/income/incomeCreate.vue')
    },
    {
        path: '/income',
        name: 'incomeList',
        component: require('../admin/views/income/incomeList.vue')
    },
    {
        path: '/income/:id/edit',
        name: 'incomeEdit',
        component: require('../admin/views/income/incomeEdit.vue')
    },

    //Asset

    {
        path: '/asset/create',
        name: 'assetCreate',
        component: require('../admin/views/asset/assetCreate.vue')
    },
    {
        path: '/asset',
        name: 'assetList',
        component: require('../admin/views/asset/assetList.vue')
    },
    {
        path: '/asset/:id/edit',
        name: 'assetEdit',
        component: require('../admin/views/asset/assetEdit.vue')
    },

    //Liabilities

    {
        path: '/liability/create',
        name: 'liabilityCreate',
        component: require('../admin/views/liability/liabilityCreate.vue')
    },
    {
        path: '/liability',
        name: 'liabilityList',
        component: require('../admin/views/liability/liabilityList.vue')
    },
    {
        path: '/liability/:id/edit',
        name: 'liabilityEdit',
        component: require('../admin/views/liability/liabilityEdit.vue')
    },
    //owner-equity

    {
        path: '/owner-equity/create',
        name: 'ownerEquityCreate',
        component: require('../admin/views/owner-equity/ownerEquityCreate.vue')
    },
    {
        path: '/owner-equity',
        name: 'ownerEquityList',
        component: require('../admin/views/owner-equity/ownerEquityList.vue')
    },
    {
        path: '/owner-equity/:id/edit',
        name: 'ownerEquityEdit',
        component: require('../admin/views/owner-equity/ownerEquityEdit.vue')
    },

    //Ledger

    {
        path: '/ledger/:id/:type/:name',
        name: 'ledgerShow',
        component: require('../admin/views/ledger/ledgerShow.vue')
    },
    {
        path: '/account/ledger/:id/:type/:name',
        name: 'ledgerOtherShow',
        component: require('../admin/views/ledger/ledgerOtherShow.vue')
    },
    {
        path: '/ledger/accounts/account-receivable',
        name: 'ledgerAccountReceivableShow',
        component: require('../admin/views/ledger/account/accountReceivable.vue')
    },
    {
        path: '/ledger/accounts/account-payable',
        name: 'ledgerAccountPayableShow',
        component: require('../admin/views/ledger/account/accountPayable.vue')
    },
    {
        path: '/ledger/employee-ledger',
        name: 'ledgerEmployeeShow',
        component: require('../admin/views/employee/employee-ledger.vue')
    },

    {
        path: '/ledger/asset-ledger',
        name: 'ledgerAccountFixedAsset',
        component: require('../admin/views/ledger/assetLedgerShow.vue')
    },
    {
        path: '/ledger/liability-ledger',
        name: 'ledgerAccountLiability',
        component: require('../admin/views/ledger/liabilityLedgerShow.vue')
    },

    //Daybook

    {
        path: '/day-book/:type',
        name: 'dayBookShow',
        component: require('../admin/views/day-book/day-book-show.vue')
    },
    //Profit and Lose

    {
        path: '/profit-loss',
        name: 'profitLoss',
        component: require('../admin/views/profit-loss/profit-loss-show.vue')
    },
    //Profit and Lose

    {
        path: '/financial-statement',
        name: 'financialStatementCreate',
        component: require('../admin/views/financial-statement/financialStatementCreate.vue')
    },

    //Cash Flow
    {
        path: '/cash-flow',
        name: 'cashFlow',
        component: require('../admin/views/cash-flow/cashFlowShow.vue')
    },
    //Regular form
    {
        path: '/regular',
        name: 'regularForm',
        component: require('../admin/views/regular/regularForm.vue')
    },

    //user

    {
        path: '/user-info',
        name: 'userDetails',
        component: require('../admin/views/user/userShow.vue')
    },

    {
        path: '/user-info/create',
        name: 'userCreate',
        component: require('../admin/views/user/userCreate.vue')
    },
    {
        path: '/user-info/:id/edit',
        name: 'userEdit',
        component: require('../admin/views/user/userEdit.vue')
    },
    {
        path: '/company-info',
        name: 'companyDetails',
        component: require('../admin/views/account/company-info.vue')
    },



    { path: "*", component: {
        template: '<p>404 Page Not Found</p>'
    }
    },

]
