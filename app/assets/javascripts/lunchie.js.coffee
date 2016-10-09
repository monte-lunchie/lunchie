@lunchie = angular.module 'lunchie', [
  'ui.router',
  'templates',
  'ngMaterial',
  'ng-token-auth',
  'ngResource',
  'ngMessages',
  'yaru22.angular-timeago'
]

@lunchie.config [
  '$stateProvider',
  '$urlRouterProvider',
  '$authProvider',
  '$mdThemingProvider',
  '$resourceProvider',
  ($stateProvider, $urlRouterProvider, $authProvider, $mdThemingProvider) ->

    $mdThemingProvider.theme('finalized').backgroundPalette('orange');
    $mdThemingProvider.theme('ordered').backgroundPalette('blue');
    $mdThemingProvider.theme('delivered').backgroundPalette('green');

    $authProvider.configure
      apiUrl: '/api'
      authProviderPaths:
        github: '/auth/github'

    signUpState =
      name: 'sign-up'
      url: '/sign_up'
      templateUrl: 'auth/sign_up.html'
      controller: 'AuthCtrl'

    signInState =
      name: 'sign-in'
      url: '/sign_in'
      templateUrl: 'auth/sign_in.html'
      controller: 'AuthCtrl'

    homeState =
      name: 'home'
      url: ''
      templateUrl: 'home.html'

    userProfileState =
      name: 'profile'
      url: '/user/profile'
      templateUrl: 'user/show.html'

    ordersState =
      name: 'orders'
      url: '/orders'
      abstract: true
      template: '<div ui-view=""></div>'
      controller: 'OrdersCtrl'

    ordersIndexState =
      parent: 'orders'
      name: 'orders_index'
      url: '/index'
      templateUrl: 'orders/index.html'
      controller: 'OrdersIndexCtrl'

    orderNewState =
      parent: 'orders'
      name: 'order_new'
      url: '/new'
      templateUrl: 'orders/new.html'
      controller: 'OrderNewCtrl'

    orderShowState =
      parent: 'orders'
      name: 'order_show'
      url: '/{id:[0-9]{1,8}}'
      templateUrl: 'orders/show.html'
      controller: 'OrderShowCtrl'

    ordersHistoryState =
      parent: 'orders'
      name: 'orders_history'
      url: '/history'
      templateUrl: 'orders/history.html'
      controller: 'OrdersHistoryCtrl'

    $stateProvider.state signUpState
    $stateProvider.state signInState
    $stateProvider.state homeState
    $stateProvider.state userProfileState
    $stateProvider.state ordersState
    $stateProvider.state ordersIndexState
    $stateProvider.state ordersHistoryState
    $stateProvider.state orderNewState
    $stateProvider.state orderShowState

    $urlRouterProvider.otherwise '/sign_in'
    return
]
